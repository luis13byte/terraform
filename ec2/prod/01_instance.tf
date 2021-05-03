
##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "centos7" {
  most_recent = true

  owners = ["679593333241"] # Amazon

  filter {
    name = "name"
    values = [var.ami_name]
  }

  filter {
    name = "description"
    values = ["CentOS 7 with Updates HVM 20200923"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_file" "user_data" {
  template = file("./userdata.yaml")
}

## Deploy

resource "aws_instance" "z30web" {
  ami                         = data.aws_ami.centos7.id
  instance_type               = "t2.nano"
  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  associate_public_ip_address = true

  # no permitido unlimited en t2 instances
  #credit_specification {
  #  cpu_credits = "unlimited"
  #}


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

  #vpc_security_group_ids  = [ 
  #  "sg-42352",
  #  "sg-54371g"
  #]

  tags = {
    Name = var.instance_name
  }


  key_name  = "luisback"
  user_data = data.template_file.user_data.rendered
}

#########################################################
# Modules for deploy the instance and attach ebs volumes
#########################################################

