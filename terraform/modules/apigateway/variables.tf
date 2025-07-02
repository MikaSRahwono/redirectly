variable "api_id" {
  description = "The ID of the API Gateway"
  type        = string
}

variable "stage_name" {
  description = "The name of the deployed stage"
  type        = string
}

variable "cognito_user_pool_arn" {
  description = "Cognito user pool ARN for authorization"
  type        = string
}
