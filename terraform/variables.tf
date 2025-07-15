variable "aws_region" {
    default = "ap-southeast-1"
}

variable "project_name" {
    default = "redirectly"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "ddb_table_name" {
    default = "shortened_links"
}

variable "s3_bucket_name" {
    default = "mika-admin-dashboard"
}

variable "create_zip_path" {}
variable "redirect_zip_path" {}
variable "auth_zip_path" {}
variable "stats_zip_path" {}

variable "lambda_env_variables" {
    type = map(string)
}

variable "cognito_pool_name" {
    default = "url-shortener-users"
}

variable "cognito_domain_prefix" {
    default = "mika-url-auth"
}

variable "cognito_callback_urls" {
    type    = list(string)
    default = ["https://admin.mikasrahwono.link/callback"]
}

variable "cognito_logout_urls" {
    type    = list(string)
    default = ["https://admin.mikasrahwono.link"]
}

variable "route53_zone_id" {}
variable "redirect_domain" {
    default = "mikasrahwono.link"
}
variable "admin_domain" {
    default = "admin.mikasrahwono.link"
}
variable "environment" {
    default = "dev"
}
variable "created_by" {
    default = "mikasrahwono"
}

variable "api_gateway_domain_name" {}
variable "api_gateway_zone_id" {}
variable "cloudfront_zone_id" {}
