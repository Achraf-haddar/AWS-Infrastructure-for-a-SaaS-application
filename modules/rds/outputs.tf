output "rds_arns" {
  value = [for rds in aws_db_instance.rds_database : rds.arn]
}
