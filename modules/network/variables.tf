variable "environment" {}

variable "vpc_name" {}

variable "vpc_cidr_block" {}

variable "public_subnet_1" {}

variable "public_subnet_2" {}

variable "private_subnet_1" {}

variable "private_subnet_2" {}

variable "azs" {
  type = list(string)
}

variable "vpn_cidr_block" {
  type = list(string)
}

