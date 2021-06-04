resource "aws_eip" "elastic" {
  instance = aws_instance.z30.id
  vpc      = true
  tags = {
    Name = "${var.instance_name}-eip"
  }
}
