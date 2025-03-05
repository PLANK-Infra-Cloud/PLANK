# Public route table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.project_name}-${var.vpc_name}-PublicRouteTable"
    Owner= "PLANK"
  }
}

# Association de chaque subnet public à la table de routage publique
resource "aws_route_table_association" "public_subnets" {
  count          = length(var.public_subnet_ids)
  subnet_id      = element(var.public_subnet_ids, count.index)
  route_table_id = aws_route_table.public.id
}

# Ajout d'une route vers l'Internet Gateway dans la table de routage publique
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}
