resource "aws_api_gateway_usage_plan" "admin_usage_plan" {
  name = "${var.environment}-${var.project_name}admin-usage-plan"

  throttle_settings {
    rate_limit  = 10 # 10 requests per second
    burst_limit = 20 # burst of 20
  }

  quota_settings {
    limit  = 10000 # monthly quota
    period = "MONTH"
  }
}

resource "aws_api_gateway_api_key" "admin_api_key" {
  name    = "${var.environment}-${var.project_name}-admin-api-key"
  enabled = true
}

resource "aws_api_gateway_usage_plan_key" "admin_key_attachment" {
  key_id        = aws_api_gateway_api_key.admin_api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.admin_usage_plan.id
}
