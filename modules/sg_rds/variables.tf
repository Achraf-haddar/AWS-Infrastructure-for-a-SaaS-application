variable "vpc_id" {
  description = "ID of the VPC"
}

variable "sg_ec2_ids" {
  type        = map(string)
  description = "IDs of the Security Groups created for every EC2"
}
