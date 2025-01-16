variable "ami_id" {
  description = "AMI id for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key name for EC2 instance"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets for NAT Gateway"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnets for Internet Gateway"
  type        = list(string)
}
