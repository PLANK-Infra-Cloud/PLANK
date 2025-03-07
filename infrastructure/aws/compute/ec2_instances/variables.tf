variable "EC2_instance_type" {
  description = "Instance type for the Database Server"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for the Web Server"
  type        = string
}

variable "EC2_security_group" {
  description = "Security group ID for the Database Server"
  type        = string
}

variable "project_name" {
  description = "Name of the project for tagging"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC for tagging"
  type        = string
}

# variable "private_subnet_id" {
#   description = "Private subnet ID for the Database Server"
#   type        = string
# }