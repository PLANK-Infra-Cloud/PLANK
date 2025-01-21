###############################################################################################################################################################
#####                                                                                                                                                     #####
#####    ███████╗██╗  ██╗██╗███████╗████████╗     ████████╗███████╗ ██████╗██╗  ██╗     ███████╗███████╗ ██████╗██╗   ██╗██████╗ ██╗████████╗██    ██║    #####
#####    ██╔════╝██║  ██║██║██╔════╝╚══██╔══╝     ╚══██╔══╝██╔════╝██╔════╝██║  ██║     ██╔════╝██╔════╝██╔════╝██║   ██║██╔══██╗██║╚══██╔══╝ ██  ██╔╝    #####
#####    ███████╗███████║██║██████╗    ██║           ██║   █████╗  ██║     ███████║     ███████╗█████╗  ██║     ██║   ██║██████╔╝██║   ██║     ████╔╝     #####
#####    ╚════██║██╔══██║██║██╔═══╝    ██║           ██║   ███╗    ██║     ██║  ██║     ╚════██║███╗    ██║     ██║   ██║██╔═██╗ ██║   ██║      ██╔╝      #####
#####    ███████║██║  ██║██║██║        ██║           ██║   ███████╗╚██████╗██║  ██║     ███████║███████╗╚██████╗╚██████╔╝██║  ██╗██║   ██║      ██║       #####
#####    ╚══════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝           ╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝     ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝       #####
#####                                                                                                                                                     #####
###############################################################################################################################################################
##### Authors: Tristan Truckle & Ibrahim Bedoui
##### Version: 1.0
##### Date: xx-xx-xxxx
##### Subject:
##### Description:
###############################################################################################################################################################

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

#Call module ALB
module "application_load_balancers" {
  source             = "./aws/load_balancers/application_load_balancers"
  public_subnet_ids  = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids
  sg_web_lb_id       = module.security_groups.sg_web_lb_id
  sg_db_lb_id        = module.security_groups.sg_db_lb_id
  project_name       = var.project_name
  vpc_name           = var.vpc_name
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
  source = "./aws/compute/ec2_instances"

  web_server_instance_type  = "t2.micro"
  db_server_instance_type   = "t2.micro"

  public_subnet_id          = module.subnets.public_subnet_ids[0]
  private_subnet_id         = module.subnets.private_subnet_ids[0]

  web_server_security_group = module.security_groups.web_server_sg_id
  db_server_security_group  = module.security_groups.db_server_sg_id

  project_name              = var.project_name
  vpc_name                  = var.vpc_name
}

#Call module s3 bucket
module "s3_bucket" {
  source       = "./aws/storage/s3_buckets"
  project_name = var.project_name
  environment  = var.environment
}