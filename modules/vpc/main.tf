# Create a VPC with one public subnet and two private subnets
resource "aws_vpc" "main" {
  # Classless Inter-Domain Routing (CIDR) 
  #  the VPC can have IP addresses ranging from 10.0.0.0 to 10.0.255.255.
  cidr_block = "10.0.0.0/16"
  # Allow ec2 instance in the VPC to resolve public DNS hostname
  enable_dns_support   = true
  enable_dns_hostnames = true

  # Tagging
  tags = {
    Name = "VPC"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet"
  }
}

# We need to create at least two private subnet from different availability zones so that we can create a db_subnet_group
resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false # Private subnet does not have public IP addresses

  tags = {
    Name = "PrivateSubnet1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false # Private subnet does not have public IP addresses

  tags = {
    Name = "PrivateSubnet2"
  }
}
