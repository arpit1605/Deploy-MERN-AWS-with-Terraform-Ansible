resource "aws_internet_gateway" "ig" {
  vpc_id = var.vpc_id
  tags = {
    Name = "arpit-ig"
  }
}

resource "aws_eip" "eip" {
  associate_with_private_ip = null
  tags = {
    Name = "arpit-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.public_subnets[0]
  tags = {
    Name = "arpit-nat-gateway"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = { 
    Name = "arpit-public-rt" 
  }
}

# Associate Route Table with Public Subnets
resource "aws_route_table_association" "public_assoc" {
  count = length(var.public_subnets)
  subnet_id = var.public_subnets[count.index]
  route_table_id = aws_route_table.public.id
}

# Route Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = { 
    Name = "arpit-private-rt" 
  }
}

# Associate Route Table with Private Subnets
resource "aws_route_table_association" "private_assoc" {
  count = length(var.private_subnets)
  subnet_id = var.private_subnets[count.index]
  route_table_id = aws_route_table.private.id
}
