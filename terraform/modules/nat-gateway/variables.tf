variable "vpc_id" {
  description = "ID of the VPC"
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
