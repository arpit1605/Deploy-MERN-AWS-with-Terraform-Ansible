provider "aws" {
  region = "us-west-2" # Change to your preferred region
}

terraform {
  backend "s3" {
    bucket = "arpit-terraform-state-bucket"
    key    = "path/to/terraform.tfstate"
    region = "us-west-2"
  }
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}

module "subnet" {
  source = "./modules/subnet"
  vpc_id           = module.vpc.vpc_id
  public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
}

module "nat-gateway" {
  source = "./modules/nat-gateway"
  public_subnets = module.subnet.public_subnet_ids
  private_subnets = module.subnet.private_subnet_ids
  vpc_id = module.vpc.vpc_id
}

module "security-group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  public_subnets = module.subnet.public_subnet_ids
  private_subnets = module.subnet.private_subnet_ids
}
