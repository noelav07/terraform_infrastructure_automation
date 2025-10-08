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


locals {
  public_key_material = var.public_key != null && var.public_key != "" ? var.public_key : (var.public_key_path != null && var.public_key_path != "" ? file(var.public_key_path) : null)
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = [var.subnet1_cidr, var.subnet2_cidr]
  availability_zones   = var.availability_zones
  security_group_name  = "vpc1_sg"
}

module "ec2" {
  source               = "./modules/ec2"
  ami_id               = data.aws_ami.latest_amazon_linux.id
  instance_type        = var.instance_type
  subnet_ids           = module.vpc.public_subnet_ids
  security_group_ids   = [module.vpc.security_group_id]
  instance_count       = var.instance_count
  user_data_base64     = base64encode(file("server.sh"))
  key_name             = var.key_name
  public_key           = var.public_key
}



# data "aws_route53_zone" "primary" {
#   name         = "noelav.cloud"
#   private_zone = false  
# }

resource "aws_lb" "vpc1_alb" {
  name               = "vpc1-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.vpc.security_group_id]
  subnets            = module.vpc.public_subnet_ids
}

resource "aws_lb_target_group" "vpc1_tg" {
  name     = "vpc1-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "attachments" {
  for_each         = { for i in range(var.instance_count) : i => i }
  target_group_arn = aws_lb_target_group.vpc1_tg.arn
  target_id        = module.ec2.instance_ids[each.value]
  port             = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.vpc1_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.vpc1_tg.arn
    type             = "forward"
  }
}

# output "loadbalancerdns" {
#   value = aws_lb.vpc1_alb.dns_name
# }


# resource "aws_route53_record" "alb" {
#   zone_id = data.aws_route53_zone.primary.zone_id
#   name    = "noelav.cloud"
#   type    = "A"

#   alias {
#     name                   = aws_lb.vpc1_alb.dns_name
#     zone_id                = aws_lb.vpc1_alb.zone_id
#     evaluate_target_health = true
#   }
# }



output "alb_dns"{
    value= aws_lb.vpc1_alb.dns_name
}

# output "ec2_instance_ids" {
#   value = module.ec2.instance_ids
# }
