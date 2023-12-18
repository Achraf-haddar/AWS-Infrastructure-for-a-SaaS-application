# Create a hosted Route 53 zone and add an A record for each environemt
resource "aws_route53_zone" "main" {
  name = var.domain_name
}

# Create A records for each environment in the format env_name.domain_name
resource "aws_route53_record" "record" {
  for_each = var.ec2_ip_addresses

  zone_id = aws_route53_zone.main.zone_id
  name    = "${each.key}.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [each.value]
}
