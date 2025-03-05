resource "aws_eip" "eip" {
  count = var.eip_count
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-${var.vpc_name}-EIP"
    Owner = "PLANK"
  }
}