# Create RDS instances and place it in private subnet using db subnet group
resource "aws_db_instance" "rds_database" {
  for_each = var.environments

  identifier = "${each.key}-environment-database"

  allocated_storage    = 10
  db_name              = each.value.db_name
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = each.value.username
  password             = each.value.password
  parameter_group_name = "default.mysql5.7"
  publicly_accessible  = false
  db_subnet_group_name = var.db_subnet_group_name

  vpc_security_group_ids = [each.value.sg_rds_id]

  # Skip creating a final DB snapshot when the RDS instance is deleted
  skip_final_snapshot = true

  tags = {
    Name = "${each.key}-environment-database"
  }

}



