# Subnets publics
resource "aws_subnet" "public" {
  count                   = var.public_subnet_count
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.vpc_name}-AZ${count.index + 1}-PublicSubnet${count.index + 1}-EC2-Bastion"
  }
}

# Subnets privés
resource "aws_subnet" "private" {
  count             = var.private_subnet_count
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + var.public_subnet_count)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "${var.project_name}-${var.vpc_name}-AZ${count.index + 1}-PrivateSubnet${count.index + 1}-EC2-Docker"
  }
}