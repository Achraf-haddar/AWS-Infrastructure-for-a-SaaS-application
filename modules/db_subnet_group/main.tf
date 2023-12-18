# Create a db subnet group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "rds_subnet_group"
  description = "DB subnet group"
  subnet_ids  = [var.private_subnet_1_id, var.private_subnet_2_id]
}
