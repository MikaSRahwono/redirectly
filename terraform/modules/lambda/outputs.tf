output "create_url_arn" {
  value = aws_lambda_function.create_url.arn
}

output "redirect_url_arn" {
  value = aws_lambda_function.redirect_url.arn
}

output "stats_url_arn" {
  value = aws_lambda_function.get_stats.arn
}

output "redirect_lambda_sg_id" {
  value = aws_security_group.lambda_redirect_sg.id
}
