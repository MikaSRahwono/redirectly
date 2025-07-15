provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      CreatedBy   = var.created_by
      Environment = var.environment
      Project     = "redirectly"
    }
  }
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  name     = "redirectly-vpc-${var.environment}"
}

module "redis" {
  source                = "./modules/redis"
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  lambda_redirect_sg_id = module.lambda.redirect_lambda_sg_id
  project_name          = var.project_name
  environment           = var.environment
}

module "dynamodb" {
  source     = "./modules/dynamodb"
  table_name = var.ddb_table_name
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "${var.s3_bucket_name}-${var.environment}"
}

module "cloudfront" {
  source         = "./modules/cloudfront"
  bucket_name    = module.s3.bucket_name
  s3_domain_name = "${module.s3.bucket_name}.s3.amazonaws.com"
  name           = "admin-dashboard"
}

module "cognito" {
  source        = "./modules/cognito"
  domain_prefix = var.cognito_domain_prefix
  callback_urls = var.cognito_callback_urls
  logout_urls   = var.cognito_logout_urls
  project_name  = var.project_name
  environment   = var.environment
}

module "lambda" {
  source             = "./modules/lambda"
  create_zip_path    = var.create_zip_path
  redirect_zip_path  = var.redirect_zip_path
  auth_zip_path      = var.auth_zip_path
  stats_zip_path     = var.stats_zip_path
  env_variables      = var.lambda_env_variables
  private_subnet_ids = module.vpc.private_subnet_ids
  environment        = var.environment
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
}

module "apigateway" {
  source = "./modules/apigateway"

  project_name          = var.project_name
  environment           = var.environment
  cognito_user_pool_arn = module.cognito.user_pool_arn
  redirect_url_arn      = module.lambda.redirect_url_arn
  create_url_arn        = module.lambda.create_url_arn
  stats_url_arn         = module.lambda.stats_url_arn
  aws_region            = var.aws_region
}


# module "route53" {
#   source                  = "./modules/route53"
#   zone_id                 = var.route53_zone_id
#   redirect_subdomain      = var.redirect_domain
#   admin_subdomain         = var.admin_domain
#   api_gateway_domain_name = var.api_gateway_domain_name
#   api_gateway_zone_id     = var.api_gateway_zone_id
#   cloudfront_domain_name  = module.cloudfront.domain_name
#   cloudfront_zone_id      = var.cloudfront_zone_id
# }
