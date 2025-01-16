resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  count = length(var.public_subnets)
  subnet_id = var.public_subnets[count.index]
  tags = {
    Name = "arpit-web-server"
  }
}

resource "aws_instance" "db_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  count = length(var.private_subnets)
  subnet_id = var.private_subnets[count.index]
  tags = {
    Name = "arpit-db-server"
  }
}
