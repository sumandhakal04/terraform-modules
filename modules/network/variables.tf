variable "environment" {}

variable "vpc_name" {}

variable "vpc_cidr_block" {}

variable "public_subnet-1" {}

variable "public_subnet-2" {}

variable "private_subnet-1" {}

variable "private_subnet-2" {}

variable "azs" {
  type = list(string)
}

variable "vpn_cidr_block" {
  type = list(string)
}

