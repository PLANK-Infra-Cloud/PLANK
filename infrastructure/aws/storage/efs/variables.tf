variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets where to mount EFS"
  type        = list(string)
}

variable "efs_security_group" {
  description = "Security group allowing NFS access to EFS"
  type        = string
}