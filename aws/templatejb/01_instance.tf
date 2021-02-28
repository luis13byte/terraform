#
# Creamos la instancia

resource "aws_instance" "z30ejemploweb01" {
  # https://wiki.centos.org/Cloud/AWS
	ami = "ami-cvugziknvmxgqna9noibqnnsy"
	instance_type = "t2.micro"
  
  tags = {
		Name = "z30ejemploweb01"
	}
  
#
# Network and Credit Specification

  credit_specification {
    cpu_credits = "unlimited"
  }

  
  
  
}
