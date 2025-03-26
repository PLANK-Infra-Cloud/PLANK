resource "aws_instance" "master" {
  ami                    = var.ami
  instance_type          = var.EC2_instance_type
  subnet_id              = var.public_subnet_id
  security_groups        = [var.EC2_security_group]

  tags = {
    Name  = "${var.project_name}-${var.vpc_name}-master"
    Owner = "PLANK"
    Role  = "swarm-master"
  }
}

resource "aws_instance" "nodes1" {
  ami                    = var.ami
  instance_type          = var.EC2_instance_type
  subnet_id              = var.public_subnet_id
  security_groups        = [var.EC2_security_group]

  tags = {
    Name  = "${var.project_name}-${var.vpc_name}-nodes1"
    Owner = "PLANK"
    Role  = "swarm-node"
  }
}

resource "aws_instance" "nodes2" {
  ami                    = var.ami
  instance_type          = var.EC2_instance_type
  subnet_id              = var.public_subnet_id
  security_groups        = [var.EC2_security_group]

  tags = {
    Name  = "${var.project_name}-${var.vpc_name}-nodes2"
    Owner = "PLANK"
    Role  = "swarm-node"
  }
}

resource "aws_instance" "runner" {
  ami                    = var.ami
  instance_type          = var.EC2_instance_type
  subnet_id              = var.public_subnet_id
  security_groups        = [var.EC2_security_group]

  tags = {
    Name  = "${var.project_name}-${var.vpc_name}-runner"
    Owner = "PLANK"
    Role  = "standalone-runner"
  }
}