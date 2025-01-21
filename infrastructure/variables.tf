# Declare variables to match Terraform Cloud workspace settings (Terraform HCL : secrets & variables)
variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = "AWS access key for authentication"
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = "AWS secret access key for authentication"
  sensitive   = true
}

# Declare the AWS variables
variable "AWS_REGION" {
 description = "This variable defines the default region for AWS deployments"
 type        = string
 default     = "eu-west-3"
}

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
  default     = "VPC1"
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

variable "eip_count" {
  description = "Nombre total d'Elastic IP nécessaires"
  type        = number
  default     = 3
}

variable "web_server_instance_type" {
  description = "Instance type for the Web Server"
  type        = string
  default     = "t2.micro"
}

variable "db_server_instance_type" {
  description = "Instance type for the Database Server"
  type        = string
  default     = "t2.micro"
}

variable "environment" {
  description = "Environment (dev, prod, ...)"
  type        = string
  default     = "prod"
}