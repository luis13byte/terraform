#
# Exportamos nuestra key SSH

resource "aws_key_pair" "jb_back" {
  key_name   = "jb_back"
  public_key = file("id_rsa.pub")
}
