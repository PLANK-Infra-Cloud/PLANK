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

output "master_public_ip" {
  value = module.ec2_instances.master_public_ip
}

output "nodes1_public_ip" {
  value = module.ec2_instances.nodes1_public_ip
}

output "nodes2_public_ip" {
  value = module.ec2_instances.nodes2_public_ip
}

output "runner_public_ip" {
  value = module.ec2_instances.runner_public_ip
}

output "master_private_ip" {
  value = module.ec2_instances.master_private_ip
}

output "nodes1_private_ip" {
  value = module.ec2_instances.nodes1_private_ip
}

output "nodes2_private_ip" {
  value = module.ec2_instances.nodes2_private_ip
}

output "runner_private_ip" {
  value = module.ec2_instances.runner_private_ip
}

# output "bucket_name" {
#   description = "Name of the S3 bucket"
#   value       = module.s3_bucket.bucket_name
# }

# output "bucket_arn" {
#   description = "ARN of the S3 bucket"
#   value       = module.s3_bucket.bucket_arn
# }