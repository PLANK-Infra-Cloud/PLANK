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

output "instance_sg_id" {
  description = "ID of the Security Group"
  value       = module.security_groups.instance_sg_id
}

output "igw_id" {
  description = "ID of the Internet Gateway"
  value       = module.igws.igw_id
}

output "elastic_ips" {
  description = "Liste of Elastic IPs createds"
  value       = module.elastic_ips.elastic_ip_ids
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = module.route_tables.public_route_table_id
}

output "EC2_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2_instances.EC2_id
}

output "EC2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2_instances.EC2_public_ip
}

output "EC2_private_ip" {
  description = "Private IP of the EC2 instance"
  value       = module.ec2_instances.EC2_private_ip
}

# output "bucket_name" {
#   description = "Name of the S3 bucket"
#   value       = module.s3_bucket.bucket_name
# }

# output "bucket_arn" {
#   description = "ARN of the S3 bucket"
#   value       = module.s3_bucket.bucket_arn
# }