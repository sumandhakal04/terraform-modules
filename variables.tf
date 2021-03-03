variable "environment" {}

variable "global_region" {}

variable "terrform_state_files_bucket" {}

variable "cidr_block" {}

variable "vpc_name" {}

variable "public_subnet-1" {}

variable "public_subnet-2" {}

variable "private_subnet-1" {}

variable "purivate_subnet-2" {}

variable "vpn_cidr_block" {
  default = list(string)
}

variable "public_server_ami" {}

variable "private_server_ami" {}

variable "Bucket-1_name" {}

variable "Bucket-2_name" {}



