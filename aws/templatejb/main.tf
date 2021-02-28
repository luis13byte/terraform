#
# Preparar el directorio de trabajo para usarlo con AWS

provider "aws" {
	region = "eu-west-3"
  access_key = "my_access_key" # proporcionar credenciales correspondientes
	secret_key = "my_user_secret_key" 
}
