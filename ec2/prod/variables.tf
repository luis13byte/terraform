# AMI variables

variable "ami_name"{
 description = "El nombre de la AMI"
 type        = string
}

variable "ami_owner" {
 description = "Propietario de la AMI"
 type        = string
}

variable "ami_description" {
 description = "Descripcion de la AMI"
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
 default     = "eu-west-1"
}


# CIDR know hosts

variable "office_yoigo_cidr_block" {
  description = "IP publica de la oficina (Yoigo)"
  type        = list
  default     = ["67.218.244.36/32"]
}

variable "office_movistar_cidr_block" {
  description = "IP publica de la oficina (Movistar)"
  type        = list
  default     = ["83.56.26.211/32"]
}

variable "jb_zabbix_server" {
  description = "IP del servidor Zabbix"
  type        = list
  default     = ["62.75.188.164/32"]
}

variable "emascaro_cidr_block" {
  description = "IP publica de eMascaro"
  type        = list
  default     = ["213.27.245.174/32"]
}
