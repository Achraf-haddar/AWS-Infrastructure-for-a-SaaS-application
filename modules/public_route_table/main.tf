# Create Public Route Table and associate it with the public subnet  
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = "public_route_table"
  }

  # Add a connection with aws internet gateway (destination any 0.0.0.0 and targeting the internet)
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }
}

# Add public subnet to the route table
resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = var.public_subnet_id
}

