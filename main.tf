# main.tf

provider "aws" {
  region = "us-east-1"
}

# Call the vpc module
module "vpc" {
  source = "./modules/vpc"
}

# Call the internet gateway module
module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
}

# Call the public route table
module "public_route_table" {
  source              = "./modules/public_route_table"
  vpc_id              = module.vpc.vpc_id
  public_subnet_id    = module.vpc.public_subnet_id
  internet_gateway_id = module.internet_gateway.internet_gateway_id
}

# Call the public route table
module "private_route_table" {
  source              = "./modules/private_route_table"
  vpc_id              = module.vpc.vpc_id
  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id
}

# Call the security group for EC2 module
module "sg_ec2" {
  source            = "./modules/sg_ec2"
  vpc_id            = module.vpc.vpc_id
  environments_name = [for env_name, _ in local.environments : env_name]
  # domain_name = var.domain_name
}


# Call the IAM Role to get full access to RDS 
module "iam_ec2" {
  source = "./modules/iam_ec2"
}


# Call the security group for EC2 module
module "ec2" {
  source           = "./modules/ec2"
  public_subnet_id = module.vpc.public_subnet_id
  iam_ec2_role     = module.iam_ec2.role_name
  sg_ec2_ids = {
    for env_name, env_config in local.environments : env_name => module.sg_ec2.sg_ec2_ids[env_config.index]
  }
}




# Call the route53 module
module "route53" {
  source      = "./modules/route53"
  domain_name = local.domain_name
  ec2_ip_addresses = {
    for env_name, env_config in local.environments : env_name => module.ec2.ec2_ip_address[env_config.index]
  }
}


# Call the Security Groups for RDS module
module "sg_rds" {
  source = "./modules/sg_rds" # Path to your module directory
  vpc_id = module.vpc.vpc_id
  sg_ec2_ids = {
    for env_name, env_config in local.environments : env_name => module.sg_ec2.sg_ec2_ids[env_config.index]
  }
}



# Call the DB subnet group module
module "db_subnet_group" {
  source              = "./modules/db_subnet_group"
  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id

}


# Call the RDS module
module "rds" {
  source               = "./modules/rds"
  db_subnet_group_name = module.db_subnet_group.db_subnet_group_name

  environments = {
    for env_name, env_config in local.environments : env_name => {
      db_name   = env_config.db_name
      username  = env_config.username
      password  = env_config.password
      sg_rds_id = module.sg_rds.sg_rds_ids[env_config.index]
    }
  }
}


# Call the DB Admin User module to create iam user for database admins
module "database_admin" {
  source = "./modules/db_admin_user"

}


