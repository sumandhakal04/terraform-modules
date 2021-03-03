terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.global_region
}

module "VPC-1" {
  source = "./modules/network/"

  vpc_cidr_block = var.cidr_block

  public_subnet-1       = var.public_subnet-1
  public_subnet-2       = var.public_subnet-2

  private_subnet-1       = var.private_subnet-1
  private_subnet-2       = var.private_subnet-2
  
  vpn_cidr_block = [var.vpn_cidr_block]

  azs         = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  vpc_name    = var.vpc_name
  environment = var.environment
}

module "s3-bucket-1" {
  source = "./modules/storage/"
  
  bucket_name = var.Bucket-1_name
  environment = var.environment
}

module "s3-bucket-2" {
  source = "./modules/storage/"
  
  bucket_name = var.Bucket-2_name
  environment = var.environment
}

module "ec2-instance" {
  source = "./modules/compute/"

  environment                 = var.environment

  public_ami_name             = var.public_server_ami
  public_server_instance_type = var.public_server_instance_type
  public_instance_name        = var.public_instance_name
  public_server_key_name      = var.public_server_key_name
  public_subnet_id-1          = module.VPC-1.public_subnet_id-1
  public_subnet_id-2          = module.VPC-1.public_subnet_id-2
  public_sg                   = module.VPC-1.public_sg

  private_ami_name             = var.private_server_ami
  private_server_instance_type = var.private_server_instance_type
  private-instance-name        = var.private_instance_name
  private_server_key_name      = var.private_instance_key_name
  private_subnet_id-1          = module.VPC-1.private_subnet_id-1
  private_subnet_id-2          = module.VPC-1.private_subnet_id-2
  private_sg                   = module.VPC-1.private_sg

  web_alb_sg      = [module.VPC-1.public-sg]
  certificate_arn = data.aws_acm_certificate.amazon_issued.arn
  vpc_id          = module.VPC-1.vpc-id
}