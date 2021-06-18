#
# Las claves de acceso se obtienen desde "Identity and Access Management (IAM)" en el panel de AWS

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "./.aws/credentials"
  profile                 = "luis13byte"
  max_retries             = "1"
}
