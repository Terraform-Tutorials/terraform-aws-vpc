resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-terraform"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-terraform"
  }
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc

  tags = {
    Name = "internet-gateway-terraform"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.my_internet_gateway
  }

  tags = {
    Name = "route-table-terraform"
  }
}

resource "aws_route_table_association" "route_association" {
  subnet_id      = aws_subnet.my_subnet
  route_table_id = aws_route_table.my_route_table
}

resource "aws_security_group" "my_security_group" {
  name        = "security-terraform"
  description = "Allow TLS sometraffic"
  vpc_id      = aws_vpc.my_vpc

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
