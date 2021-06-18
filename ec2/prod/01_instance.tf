## Data sources to get VPC, subnet, security group and AMI details ##

data "aws_vpc" "selected" {
  state = "available"
}

## Searching AMI ##

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.selected.id
}

data "aws_ami" "centos7" {
  most_recent = true

  owners = [var.ami_owner]

  filter {
    name = "name"
    values = [var.ami_name]
  }

  filter {
    name = "description"
    values = [var.ami_description]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

## Cloud init file ##

data "template_file" "script" {
  template = file("./scripts/centos7-initial-config.sh")

  vars = {
    SERVER = var.instance_name
    EPHEMERALDISK= "/dev/nvme1n1"
    UUID = ""
    VERSION_ID = ""
  }
}

data "template_cloudinit_config" "shell_script" {
  gzip = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content  = data.template_file.script.rendered
  }
}

## Deploy instance ##

resource "aws_instance" "zserver" {
  ami                         = data.aws_ami.centos7.id
  instance_type               = "t3.large"
  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  associate_public_ip_address = true

  credit_specification {
    cpu_credits = "unlimited"
  }

## EBS Volumes ##
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 45
    delete_on_termination = false
    tags = {
      Name = "${var.instance_name}-root"
    }
  }

  ebs_block_device {
    device_name           = "/dev/sdb"
    volume_type           = "gp3"
    volume_size           = 5
    delete_on_termination = false
    tags = {
      Name = "${var.instance_name}-ephemeral0-tmp"
    }
  }

  vpc_security_group_ids  = [ 
    aws_security_group.sg_web.id,
    aws_security_group.sg_default_jb.id
  ]

  tags = {
    Name = var.instance_name
  }


  key_name = "luis_back"
  user_data_base64 = data.template_cloudinit_config.shell_script.rendered

}
