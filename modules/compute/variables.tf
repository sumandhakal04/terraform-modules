variable "public_ami_name" {}

variable "public_server_key_name" {}

variable "public_instance_name" {}

variable "public_server_instance_type" {}

variable "public_subnet_id_1" {}

variable "public_subnet_id_2" {}

variable "private_ami_name" {}

variable "private_server_key_name" {}

variable "private_instance_name" {}

variable "private_server_instance_type" {}

variable "private_subnet_id_1" {}

variable "private_subnet_id_2" {}

variable "public_sg" {}

variable "private_sg" {}

variable "web_alb_sg" {
  type = list(string)
}

variable "vpc_id" {}

variable "environment" {}
