data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"] # This is the AWS account ID for official images

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}




resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_instance" "instances" {
  count                       = var.instance_count
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids[count.index]
  vpc_security_group_ids      = var.security_group_ids
  user_data_base64            = var.user_data_base64
  key_name                    = var.key_name
}


