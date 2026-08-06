data "aws_caller_identity" "current" {}

module "vpc" {
  source = "../../modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "security_groups" {
  source = "../../modules/security"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}

module "alb" {
  source = "../../modules/ALB"

  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security_groups.alb_security_group_id
}

module "rds" {
  source = "../../modules/RDS"

  project_name          = var.project_name
  environment           = var.environment
  private_subnet_ids    = module.vpc.private_subnet_ids
  rds_security_group_id = module.security_groups.rds_security_group_id
  instance_class        = var.db_instance_class
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
}

module "asg" {
  source = "../../modules/ASG"

  project_name              = var.project_name
  environment               = var.environment
  ami_id                    = var.ami_id
  instance_type             = var.instance_type
  private_subnet_ids        = module.vpc.private_subnet_ids
  ec2_security_group_id     = module.security_groups.ec2_security_group_id
  frontend_target_group_arn = module.alb.frontend_target_group_arn
  backend_target_group_arn  = module.alb.backend_target_group_arn

  db_host     = module.rds.rds_endpoint
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  min_size         = 1
  desired_capacity = 1
  max_size         = 2
}

module "codedeploy" {
  source = "../../modules/CodeDeploy"

  project_name               = var.project_name
  environment                = var.environment
  autoscaling_group_name     = module.asg.autoscaling_group_name
  frontend_target_group_name = module.alb.frontend_target_group_name
}

module "codebuild" {
  source = "../../modules/CodeBuild"

  project_name = var.project_name
  environment  = var.environment
}

module "codepipeline" {
  source = "../../modules/CodePipeline"

  project_name           = var.project_name
  environment            = var.environment
  aws_account_id         = data.aws_caller_identity.current.account_id
  github_owner           = var.github_owner
  github_repo            = var.github_repo
  github_branch          = var.github_branch
  codebuild_project_name = module.codebuild.codebuild_project_name
  codedeploy_app_name    = module.codedeploy.codedeploy_app_name
  deployment_group_name  = module.codedeploy.deployment_group_name
}

module "cloudwatch" {
  source = "../../modules/CloudWatch"

  project_name           = var.project_name
  environment            = var.environment
  aws_region             = var.aws_region
  autoscaling_group_name = module.asg.autoscaling_group_name
  db_identifier          = module.rds.db_identifier
}