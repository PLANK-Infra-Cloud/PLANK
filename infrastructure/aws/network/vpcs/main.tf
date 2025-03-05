# Define a Virtual Private Cloud (VPC) with a specified CIDR block and default tenancy
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-${var.vpc_name}"
  }
}
