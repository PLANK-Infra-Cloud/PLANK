  # Specify required providers and their versions
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.94.1" # Compatible avec AWS provider version 4.16 et plus
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
  ssh_private_key_content = var.ssh_private_key_content
#  ssh_private_key_path = var.ssh_private_key_path
}

#Call module efs
module "efs" {
  source              = "./aws/storage/efs"
  project_name        = var.project_name
  vpc_name            = var.vpc_name
  subnet_ids          = module.subnets.private_subnet_ids
  efs_security_group  = module.security_groups.efs_sg_id
}

locals {
  nodes = {
    master  = module.ec2_instances.master_public_ip
    nodes1  = module.ec2_instances.nodes1_public_ip
    nodes2  = module.ec2_instances.nodes2_public_ip
  }
}

resource "null_resource" "wait_for_ssh" {
  for_each = local.nodes

  connection {
    type        = "ssh"
    host        = each.value
    user        = "ubuntu"
    private_key = var.ssh_private_key_content
  #  private_key = file(var.ssh_private_key_path)

    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${each.key} est accessible en SSH ${each.value}"
    ]
  }
}

resource "null_resource" "ansible_apply" {
  provisioner "local-exec" {
    command = <<EOT
      #!/bin/bash
      echo "Lancement du playbook Ansible"

      LOG_FILE="../ansible/logs/deploy_$(date +%Y%m%d_%H%M%S).log"

      ANSIBLE_FORCE_COLOR=true \
      ANSIBLE_CONFIG=../ansible/ansible.cfg \
      ansible-playbook -i ../ansible/aws_ec2.yml ../ansible/docker-swarm.yml | tee "$LOG_FILE"

      echo "Playbook terminé. Logs : $LOG_FILE"
    EOT

    interpreter = ["/bin/bash", "-c"]
    working_dir = "${path.module}"
  }

  depends_on = [
    null_resource.wait_for_ssh
  ]
}