output "user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "app_client_id" {
  value = aws_cognito_user_pool_client.app_client.id
}

output "user_pool_domain" {
  value = aws_cognito_user_pool_domain.domain.domain
}
