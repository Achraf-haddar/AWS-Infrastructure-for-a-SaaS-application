output "ec2_ip_address" {
  value = [for instance in aws_instance.server : instance.public_ip]
}
