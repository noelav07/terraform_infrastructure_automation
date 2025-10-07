resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_instance" "instances" {
  count                       = var.instance_count
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids[count.index]
  vpc_security_group_ids      = var.security_group_ids
  user_data_base64            = var.user_data_base64
  key_name                    = var.key_name
}


