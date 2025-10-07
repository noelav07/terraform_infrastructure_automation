output "instance_ids" {
  value = [for i in aws_instance.instances : i.id]
}

output "private_ips" {
  value = [for i in aws_instance.instances : i.private_ip]
}

output "public_ips" {
  value = [for i in aws_instance.instances : i.public_ip]
}


