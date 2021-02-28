#
# Preparar el uso de variables para datos sensibles (secrets)

variable "my_access_key" {
  description = "Access-key-for-AWS"
  default = "no_access_key_value_found"
}
 
variable "my_secret_key" {
  description = "Secret-key-for-AWS"
  default = "no_secret_key_value_found"
}
 
output "access_key_is" {
  value = var.my_access_key
}
 
output "secret_key_is" {
  value = var.my_secret_key
}

# Preparar el directorio de trabajo para usarlo con AWS

provider "aws" {
  region = "eu-west-3"
  access_key = var.my_access_key
  secret_key = var.my_user_secret_key
}
