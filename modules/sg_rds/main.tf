# Create Security Group for every RDS instance
resource "aws_security_group" "sg_rds" {
  for_each = var.sg_ec2_ids

  name        = "sg_rds_${each.key}"
  description = "Security Group for RDS instance of environment ${each.key}"

  vpc_id = var.vpc_id

  # Allow inbound traffic coming from EC2 on port 3306 (Mysql port)
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [each.value]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
