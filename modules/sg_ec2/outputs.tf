output "sg_ec2_ids" {
  value = [for sg_ec2 in aws_security_group.sg_ec2 : sg_ec2.id]
}
