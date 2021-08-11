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

# PATH variables

variable "scripts_directory"{
 description = "Ruta de directorio de scripts"
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
