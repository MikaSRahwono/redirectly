variable "environment" {
  description = "Name of the deployment stage (e.g. dev, prod)"
  type        = string
}

variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
}

variable "cognito_user_pool_arn" {
  description = "ARN of the Cognito User Pool used for authorizer"
  type        = string
}

variable "aws_region" {
  description = "AWS region where the API Gateway is deployed"
  type        = string
}

variable "redirect_url_arn" {
  description = "ARN of the Lambda function that handles redirects"
  type        = string
}

variable "create_url_arn" {
  description = "ARN of the Lambda function that handles create URL"
  type        = string
}

variable "stats_url_arn" {
  description = "ARN of the Lambda function that handles stats URL"
  type        = string
}
