# Create Private Route Table and associate it with the two private subnets  
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private_route_table"
  }

}

# Add public subnet to the route table
resource "aws_route_table_association" "private_1" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = var.private_subnet_1_id
}

# Add public subnet to the route table
resource "aws_route_table_association" "private_2" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = var.private_subnet_2_id
}


