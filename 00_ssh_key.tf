#
# Exportamos nuestra key SSH

resource "aws_key_pair" "luis_back" {
  key_name   = "luis_back"
  public_key = file("id_rsa.pub")
}
