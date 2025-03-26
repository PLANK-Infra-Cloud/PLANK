  # Specify required providers and their versions
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.82.0" # Compatible avec AWS provider version 4.16 et plus
    }
  }
}

# Define the AWS provider with a specified region
provider "aws" {
  region = var.AWS_REGION
}

## Call AWS Modules

#Call module VPC
module "vpc" {
  source       = "./aws/network/vpcs"
  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
  vpc_name     = var.vpc_name
}

#Call module subnets
module "subnets" {
  source              = "./aws/network/subnets"
  vpc_id              = module.vpc.vpc_id
  vpc_cidr            = var.vpc_cidr
  public_subnet_count = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  availability_zones  = var.availability_zones
  project_name        = var.project_name
  vpc_name            = var.vpc_name
}

#Call module security groups
module "security_groups" {
  source              = "./aws/network/security_groups"
  project_name = var.project_name
  vpc_name     = var.vpc_name
  vpc_id       = module.vpc.vpc_id
}

#Call module Internet Gateway
module "igws" {
  source       = "./aws/network/igws"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  vpc_name     = var.vpc_name
}

#Call module route_tables
module "route_tables" {
  source              = "./aws/network/route_tables"
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.subnets.public_subnet_ids
  private_subnet_ids  = module.subnets.private_subnet_ids
  igw_id              = module.igws.igw_id
  project_name        = var.project_name
  vpc_name            = var.vpc_name
}

#Call module elastic_ips
module "elastic_ips" {
  source       = "./aws/network/elastic_ips"
  eip_count    = var.eip_count
  # instance_ids = var.instance_ids
  project_name = var.project_name
  vpc_name     = var.vpc_name
}

#Call module ec2_instances
module "ec2_instances" {
  source             = "./aws/compute/ec2_instances"
  EC2_instance_type  = var.EC2_instance_type
  public_subnet_id   = module.subnets.public_subnet_ids[0]
  EC2_security_group = module.security_groups.instance_sg_id
  project_name       = var.project_name
  vpc_name           = var.vpc_name
  ami                = var.ami
  key_name           = var.key_name
  efs_dns_name       = module.efs.efs_dns_name
}

#Call module efs
module "efs" {
  source              = "./aws/storage/efs"
  project_name        = var.project_name
  vpc_name            = var.vpc_name
  subnet_ids          = module.subnets.private_subnet_ids
  efs_security_group  = module.security_groups.efs_sg_id
}