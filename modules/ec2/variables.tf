variable "ami_id" {
  description = "AMI ID for instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to place instances into"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs to attach"
  type        = list(string)
}

variable "instance_count" {
  description = "How many instances to create"
  type        = number
  default     = 2
}

variable "user_data_base64" {
  description = "Base64-encoded user data to pass to instances"
  type        = string
  default     = null
}

variable "key_name" {
  description = "Name of the key pair to create/use"
  type        = string
}

variable "public_key" {
  description = "Public key material for key pair"
  type        = string
}


