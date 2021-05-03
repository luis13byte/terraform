# AMI variables

variable "ami_name"{
  description = "El nombre de la AMI"
  type        = string
}

variable "ami_owner" {
  description = "Configuration owner"
  type        = string
}

# VPC variables

variable "instance_name"{
  description = "Nombre de la instancia"
  type        = string
}

variable "aws_region_az" {
  description = "AWS region availability zone"
  type        = string
  default     = "us-east-1"
}

variable "eip_tag"{
  description = "Tag name for eip of instance"
  type        = string
}

# CIDR know hosts

variable "office_cidr_block" {
  description = "Ip publica de la oficina"
  type        = string
  default     = "10.0.0.0/32"
}
