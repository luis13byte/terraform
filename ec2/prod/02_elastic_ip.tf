resource "aws_eip" "elastic" {
  instance = aws_instance.zserver.id
  vpc      = true
  tags = {
    Name = "${var.instance_name}-eip"
  }
}
