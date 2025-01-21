## Output for AWS

output "vpc_id" {
  description = "The ID of the VPC from the VPC module"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The ID of the public subnets"
  value       = module.subnets.public_subnet_ids
}
output "private_subnet_ids" {
  description = "The ID of the private subnets"
  value       = module.subnets.private_subnet_ids
}

output "web_server_sg_id" {
  description = "ID of the Web Server Security Group"
  value       = module.security_groups
}

output "db_server_sg_id" {
  description = "ID of the Database Server Security Group"
  value       = module.security_groups
}

output "lb_web_sg_id" {
  description = "ID of the Web Load Balancer Security Group"
  value       = module.security_groups
}

output "lb_db_sg_id" {
  description = "ID of the Database Load Balancer Security Group"
  value       = module.security_groups
}

# output "web_lb_arn" {
#   description = "ARN of the Web Server Application Load Balancer"
#   value       = module.application_load_balancers
# }

# output "web_lb_dns" {
#   description = "DNS name of the Web Server Application Load Balancer"
#   value       = module.application_load_balancers
# }

# output "db_lb_arn" {
#   description = "ARN of the Database Server Application Load Balancer"
#   value       = module.application_load_balancers
# }

# output "db_lb_dns" {
#   description = "DNS name of the Database Server Application Load Balancer"
#   value       = module.application_load_balancers
# }

output "igw_id" {
  description = "ID of the Internet Gateway"
  value       = module.igws.igw_id
}

# output "elastic_ips" {
#   description = "Liste of Elastic IPs createds"
#   value       = module.elastic_ips.elastic_ip_ids
# }

# output "web_server_id" {
#   description = "ID of the Web Server instance"
#   value       = module.ec2_instances.web_server_id
# }

# output "db_server_id" {
#   description = "ID of the Database Server instance"
#   value       = module.ec2_instances.db_server_id
# }

# output "web_server_public_ip" {
#   description = "Public IP of the Web Server instance"
#   value       = module.ec2_instances.web_server_public_ip
# }

# output "db_server_private_ip" {
#   description = "Private IP of the Database Server instance"
#   value       = module.ec2_instances.db_server_private_ip
# }

# output "bucket_name" {
#   description = "Name of the S3 bucket"
#   value       = module.s3_bucket.bucket_name
# }

# output "bucket_arn" {
#   description = "ARN of the S3 bucket"
#   value       = module.s3_bucket.bucket_arn
# }