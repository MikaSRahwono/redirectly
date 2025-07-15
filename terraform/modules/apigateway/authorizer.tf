resource "aws_api_gateway_authorizer" "cognito_authorizer" {
  name            = "${var.environment}-${var.project_name}-cognito-authorizer"
  rest_api_id     = aws_api_gateway_rest_api.api.id
  identity_source = "method.request.header.Authorization"
  type            = "COGNITO_USER_POOLS"
  provider_arns   = [var.cognito_user_pool_arn]
}
