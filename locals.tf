data "aws_secretsmanager_secret_version" "db_secrets" {
  secret_id = "rds_credentials"
}

locals {
  environments = {
    bessie = {
      index      = 0
      db_name    = "bessie_db"
      username   = jsondecode(data.aws_secretsmanager_secret_version.db_secrets.secret_string)["username_bessie"]
      password   = jsondecode(data.aws_secretsmanager_secret_version.db_secrets.secret_string)["password_bessie"]
      sub_domain = ""
    }
    clarabelle = {
      index    = 1
      db_name  = "clarabelle_db"
      username = jsondecode(data.aws_secretsmanager_secret_version.db_secrets.secret_string)["username_clarabelle"]
      password = jsondecode(data.aws_secretsmanager_secret_version.db_secrets.secret_string)["password_clarabelle"]
    }
    penelope = {
      index    = 2
      db_name  = "penelope_db"
      username = jsondecode(data.aws_secretsmanager_secret_version.db_secrets.secret_string)["username_penelope"]
      password = jsondecode(data.aws_secretsmanager_secret_version.db_secrets.secret_string)["password_penelope"]
    }
  }

  domain_name = "exercise.com"

}
