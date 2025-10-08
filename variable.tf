    # variable "ami_id" {

    # description = "ami id of ec2 instance; module example"

    # type = string 

    # } 



variable "instance_type" {

description = "instance type of ec2 instance; module example"

type = string 

} 


###################################Virtual Private Cloud###################################

## region is configured in provider.tf; remove input to avoid prompts

variable "vpc_cidr" {

    description = "CIDR for VPC"
    type = string
}


variable "subnet1_cidr" {

    description = "CIDR for sub1"
    type = string
}

variable "subnet2_cidr" {

    description = "CIDR for sub2"
    type = string
}



variable "availability_zones" {

description = "AZs aligned with subnets"
type = list(string)
}

variable "instance_count" {

description = "Number of EC2 instances to create and register"
type = number
default = 2
}

variable "key_name" {

description = "Key pair name for EC2"
type = string
}

variable "public_key_path" {

description = "Absolute or relative path to public key file"
type = string
default = null
}

variable "public_key" {

description = "Public key material (useful for Terraform Cloud)"
type = string
default = null
}

# variable "user_data_file" {

# description = "Path to user-data script file"
# type = string
# }

# variable "route53_zone_name" {

# description = "Route53 public hosted zone name"
# type = string
# }

