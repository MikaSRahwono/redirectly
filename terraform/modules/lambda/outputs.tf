output "create_url_arn" {
  value = aws_lambda_function.create_url.arn
}

output "redirect_url_arn" {
  value = aws_lambda_function.redirect_url.arn
}

output "auth_user_arn" {
  value = aws_lambda_function.auth_user.arn
}

output "get_stats_arn" {
  value = aws_lambda_function.get_stats.arn
}
