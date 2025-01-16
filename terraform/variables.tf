variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "arpit-vpc"
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "ami_id" {
  description = "AMI id for EC2 instance"
  type        = string
  default       = "ami-07d9cf938edb0739b"
}

variable "instance_type" {
  description = "Instance type for EC2 instance"
  type        = string
  default       = "t2.micro"
}

variable "key_name" {
  description = "Key name for EC2 instance"
  type        = string
  default      = "arpit-key-ec2"
}
