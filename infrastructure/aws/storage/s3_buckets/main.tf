resource "aws_s3_bucket" "main_bucket" {
  bucket = "${lower(var.project_name)}-${lower(var.environment)}-main-bucket"
  force_destroy = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-main-bucket"
    Environment = var.environment
  }
}