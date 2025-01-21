#Définitions dezs variables liées au VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "PLANK-PARIS"
  type        = string
  default     = "PLANK-PARIS"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}