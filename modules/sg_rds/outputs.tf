output "sg_rds_ids" {
  value = [for sg_rds in aws_security_group.sg_rds : sg_rds.id]
}
