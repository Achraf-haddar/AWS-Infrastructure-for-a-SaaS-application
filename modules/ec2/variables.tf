variable "sg_ec2_ids" {
  type        = map(string)
  description = "IDs of the Security Groups created for EC2 instances"
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
}

variable "iam_ec2_role" {
  description = "Name of the IAM Role created for the EC2 instances"
}
