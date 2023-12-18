variable "vpc_id" {
  description = "ID of the VPC"
}

variable "environments_name" {
  type        = list(string)
  description = "List of environment names"
}

