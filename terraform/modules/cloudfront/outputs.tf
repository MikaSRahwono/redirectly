output "distribution_id" {
  value = aws_cloudfront_distribution.cdn.id
}

output "domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}
