output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.subnet.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.subnet.private_subnet_ids
}

output "web_server_public_ip" { 
  value = module.ec2.web_server_public_ip 
  description = "The public IP of the web server" 
} 

output "db_server_private_ip" { 
  value = module.ec2.db_server_private_ip 
  description = "The private IP of the DB server" 
}
