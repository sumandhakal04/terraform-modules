
output "vpc_id" {
  description = "VPC_1"
  value       = aws_vpc.myvpc.id
}

output "public_subnet_id_1" {
  description = "Public-Subnet-1"
  value       = aws_subnet.public_subnet_1.id
}

output "public_subnet_id_2" {
  description = "Public-Subnet-2"
  value       = aws_subnet.public_subnet_2.id
}


output "private_subnet_id_1" {
  description = "Private-Subnet-1"
  value       = aws_subnet.private_subnet_1.id
}

output "private_subnet_id_2" {
  description = "Private-Subnet-2"
  value       = aws_subnet.private_subnet_2.id
}

output "public_sg" {
  description = "Public Security Group"
  value       = aws_security_group.public_sg.id
}

output "private_sg" {
  description = "Private Security Group"
  value       = aws_security_group.private_sg.id
}