variable "domain_name" {
  description = "The root domain name"
  type        = string
  default     = "exercise.com"
}

variable "ec2_ip_addresses" {
  type        = map(string)
  description = "IP addresses of the created EC2 instances"
}
