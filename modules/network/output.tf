output "vpc-id" {
  description = "VPC-1"
  value       = aws_vpc.myvpc.id
}

output "public_subnet_id-1" {
  description = "Public-Subnet-1"
  value       = aws_subnet.public-subnet-1.id
}

output "public_subnet_id-2" {
  description = "Public-Subnet-2"
  value       = aws_subnet.public-subnet-2.id
}


output "private_subnet_id-1" {
  description = "Private-Subnet-1"
  value       = aws_subnet.private-subnet-1.id
}

output "private_subnet_id-2" {
  description = "Private-Subnet-2"
  value       = aws_subnet.private-subnet-2.id
}

output "public-sg" {
  description = "Public Security Group"
  value       = aws_security_group.public-sg.id
}

output "private-sg" {
  description = "Private Security Group"
  value       = aws_security_group.private-sg.id
}