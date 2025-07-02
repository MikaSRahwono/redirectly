output "lambda_redirect_arn" {
  value = module.lambda.redirect_url_arn
}

output "cloudfront_url" {
  value = module.cloudfront.domain_name
}

output "cognito_user_pool_id" {
  value = module.cognito.user_pool_id
}

output "cognito_client_id" {
  value = module.cognito.app_client_id
}

output "dynamodb_table" {
  value = module.dynamodb.table_name
}

output "route53_admin_ui_url" {
  value = module.route53.admin_ui_url
}

output "route53_redirect_url" {
  value = module.route53.redirect_url
}
