# Create an IAM role to enable connection to the EC2 instances via AWS console
# It is for debugging purposes
resource "aws_iam_role" "iam_ec2_role" {
  name = "iam_ec2_role"
  # Attach the full access to RDS
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "ec2_instance_connect_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceConnect"
  role       = aws_iam_role.iam_ec2_role.name
}
