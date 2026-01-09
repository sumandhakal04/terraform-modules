#############
### VPC 
#############

### VPC ###

resource "aws_vpc" "myvpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

### Public-subnets ###

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.public_subnet_1
  map_public_ip_on_launch = true
  availability_zone       = var.azs[0]
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.public_subnet_2
  map_public_ip_on_launch = true
  availability_zone       = var.azs[1]
}

### Private subnets ###

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.private_subnet_1
  map_public_ip_on_launch = false
  availability_zone       = var.azs[0]
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.private_subnet_2
  map_public_ip_on_launch = false
  availability_zone       = var.azs[1]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_eip" "eip_nat_gw" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip_nat_gw.id
  subnet_id     = aws_subnet.public_subnet_1.id
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name = "TF-nat-gw"
  }
}

### Route Table ###

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public-route-table"
  }
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "Private-route-table"
  }
}

#resource "aws_vpc_endpoint" "s3" {
#  vpc_id       = aws_vpc.myvpc.id
#  service_name = "com.amazonaws.us-east-2.s3"
#}

#resource "aws_vpc_endpoint_route_table_association" "s3-route-table-association" {
#  route_table_id  = aws_route_table.private_route.id
#  vpc_endpoint_id = aws_vpc_endpoint.s3.id
#}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route.id
}


###################
## Security Groups
###################

resource "aws_security_group" "public_sg" {
  name        = "Public-Security-group-${var.environment}"
  description = "Public security group for ${var.environment}"
  vpc_id      = aws_vpc.myvpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.vpn_cidr_block
    description = "VPN IP"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow http access"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Public-Security-group-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "private_sg" {
  name        = "Private-Security-group-${var.environment}"
  description = "Private Security group for ${var.environment}"
  vpc_id      = aws_vpc.myvpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.vpn_cidr_block
    description = "VPN IP"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow http access"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Private-Security-group-${var.environment}"
    Environment = var.environment
  }
}