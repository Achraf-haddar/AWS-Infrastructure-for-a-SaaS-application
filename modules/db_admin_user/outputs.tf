output "iam_user_access_key" {
  value = aws_iam_access_key.database_admin_access_key.id
}

output "iam_user_secret_access_key" {
  value = aws_iam_access_key.database_admin_access_key.secret
}

output "iam_user_arn" {
  value = aws_iam_user.database_admin.arn
}

output "iam_user_name" {
  value = aws_iam_user.database_admin.name
}

output "iam_user_password" {
  value = aws_iam_user_login_profile.database_admin_login_profile.password
}
