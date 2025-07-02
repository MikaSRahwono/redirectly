resource "aws_api_gateway_usage_plan" "admin_usage_plan" {
  name = "admin-usage-plan"

  throttle {
    rate_limit  = 10  # 10 requests per second
    burst_limit = 20  # burst of 20
  }

  quota {
    limit  = 10000  # monthly quota
    period = "MONTH"
  }
}

resource "aws_api_gateway_api_key" "admin_api_key" {
  name    = "admin-api-key"
  enabled = true

  stage_key {
    rest_api_id = var.api_id
    stage_name  = var.stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "admin_key_attachment" {
  key_id        = aws_api_gateway_api_key.admin_api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.admin_usage_plan.id
}
