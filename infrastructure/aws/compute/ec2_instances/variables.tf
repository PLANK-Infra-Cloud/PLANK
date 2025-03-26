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

variable "ami" {
  description = "ID of the AMI"
  type        = string
}

variable "efs_dns_name" {
  description = "EFS DNS name for mounting"
  type        = string
}

variable "key_name" {
  description = "Name of the AWS key pair for SSH access"
  type        = string
}