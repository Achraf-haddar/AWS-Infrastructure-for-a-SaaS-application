# Create multiple EC2 instances (one for each tenant)
resource "aws_instance" "server" {
  for_each = var.sg_ec2_ids

  ami           = "ami-0fc5d935ebf8bc3bc" # Ubuntu image  
  instance_type = "t2.micro"              # depends on the resources needed for the application
  subnet_id     = var.public_subnet_id

  # Specify the IAM instance profile associated with the IAM role
  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile.name

  associate_public_ip_address = true # Assign a public IP to the EC2 instance

  vpc_security_group_ids = [each.value]

  tags = {
    Name = "${each.key}-environment-server"
  }

  # Add starting code to deploy one page
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              echo '<html><head><title>Test Page</title></head><body><h1>This is the "${each.key}" Environment</h1></body></html>' | sudo tee /var/www/html/index.html
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF
}

# We attach an IAM role to the EC2 instance to enable connection via AWS console (EC2InstanceConnect)
# It is for debugging purposes
resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "iam_instance_profile"
  role = var.iam_ec2_role # Add a role to the instance (for writing and reading from rds instances)
}
