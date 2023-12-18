# This module aims at creating an IAM user for database admin with 
# permission to see metrics of RDS instances 
resource "aws_iam_user" "database_admin" {
  name = "database_admin"
}

resource "aws_iam_access_key" "database_admin_access_key" {
  user = aws_iam_user.database_admin.name

}

resource "aws_iam_user_login_profile" "database_admin_login_profile" {
  user                    = aws_iam_user.database_admin.name
  password_length         = 20
  password_reset_required = true
}

# Create iam policy with actions to be allowed for seeing metrcis of RDS instances
resource "aws_iam_policy" "database_admin_policy" {
  name        = "DatabaseAdminPolicy"
  description = "Policy for Database Admins"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "rds:DescribeDBInstances",
            "rds:DescribeDBClusters",
            "rds:DescribeGlobalClusters",
            "cloudwatch:GetMetricData",
            "cloudwatch:ListMetrics",
            "cloudwatch:ListDashboards",
            "cloudwatch:GetDashboard",
            "iam:ChangePassword"
          ],
          "Resource" : "*"
        },
      ]
    }
  )
}

# Attach the policy to the created iam user
resource "aws_iam_user_policy_attachment" "database_admin_attach_policy" {
  user       = aws_iam_user.database_admin.name
  policy_arn = aws_iam_policy.database_admin_policy.arn
}
