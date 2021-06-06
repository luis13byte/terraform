#
# Creamos los security groups

resource "aws_security_group" "sg_default_jb" {
 name        = "default_jb"
 description = "General Security Group for JOOPbox"
 vpc_id      = data.aws_vpc.selected.id

 ingress {
   description      = "Office (Yoigo)"
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = var.office_yoigo_cidr_block
 }

 ingress {
   from_port        = 10050
   to_port          = 10051
   protocol         = "tcp"
   cidr_blocks      = ["146.255.100.178/32"]
 }

 ingress {
   from_port        = 10050
   to_port          = 10051
   protocol         = "tcp"
   cidr_blocks      = var.jb_zabbix_server
 }

 egress {
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
   #ipv6_cidr_blocks = ["::/0"]
 }

 tags = {
   Name = "vpc-sg-default-jb"
 }
}

resource "aws_security_group" "sg_web" {
 name        = "web"
 description = "Allow web traffic"
 vpc_id      = data.aws_vpc.selected.id

 ingress {
   description      = "HTTP from VPC"
   from_port        = 80
   to_port          = 80
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
   #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
 }

 ingress {
   description      = "TLS from VPC"
   from_port        = 443
   to_port          = 443
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]             
   #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
 }

 tags = {
   Name = "vpc-sg-web"
 }
}


resource "aws_security_group" "sg_ftp" {
 name        = "ftp"
 description = "Allow FTP traffic"
 vpc_id      = data.aws_vpc.selected.id

 ingress {
   description      = "eMascaro FTP"
   from_port        = 20
   to_port          = 21
   protocol         = "tcp"
   cidr_blocks      = ["213.27.245.178/32"]
 }

 ingress {
   description      = "eMascaro SFTP"
   from_port        = 2222  
   to_port          = 2222  
   protocol         = "tcp"
   cidr_blocks      = ["213.27.245.178/32"]
 }

 egress {
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
   #ipv6_cidr_blocks = ["::/0"]
 }

 tags = {
   Name = "vpc-sg-ftp"
 }
}
