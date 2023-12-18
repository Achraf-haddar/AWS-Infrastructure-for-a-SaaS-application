output "iam_user_access_key" {
  value     = module.database_admin.iam_user_access_key
  sensitive = true
}

output "iam_user_secret_access_key" {
  value     = module.database_admin.iam_user_secret_access_key
  sensitive = true
}

output "iam_user_arn" {
  value = module.database_admin.iam_user_arn
}

output "iam_user_name" {
  value = module.database_admin.iam_user_name
}

output "iam_user_password" {
  value     = module.database_admin.iam_user_password
  sensitive = true
}
