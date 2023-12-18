variable "db_subnet_group_name" {
  description = "Name of the db_subnet_group"
}

variable "environments" {
  type        = map(map(string))
  description = "RDS db information for every Environments/Tenants"
}
