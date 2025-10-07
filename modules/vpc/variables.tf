variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of AZs aligned with public_subnet_cidrs"
  type        = list(string)
}

variable "security_group_name" {
  description = "Name for the default security group"
  type        = string
  default     = "vpc_default_sg"
}


