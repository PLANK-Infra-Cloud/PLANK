variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default     = 3
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
  default     = 3
}

variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
  default     = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "PLANK-PARIS"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the Internet Gateway"
  type        = string
}