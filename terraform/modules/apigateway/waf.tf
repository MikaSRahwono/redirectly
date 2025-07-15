resource "aws_wafv2_web_acl" "api_waf" {
  name        = "${var.environment}-${var.project_name}-api-protection"
  scope       = "REGIONAL"
  description = "Protect API Gateway from abuse"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "apiProtectionWAF"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "LimitRequestRate"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 1000 # 1000 requests per 5 minutes per IP
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "LimitRequestRate"
      sampled_requests_enabled   = true
    }
  }
}
