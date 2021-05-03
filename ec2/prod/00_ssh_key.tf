# Aqui se crea la clave ssh para conetarse sin contraseña, en caso de que ya exista esta en el panel, simplemente se añadira a la hora de crear la instancia: ssh_keys= 423y89

#
# Exportamos nuestra key SSH

resource "aws_key_pair" "luisback" {
  key_name   = "luisback"
  public_key = file("id_rsa.pub")
}
