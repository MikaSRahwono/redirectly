variable "project_name" {
  description = "Name of the Cognito User Pool"
  type        = string
}

variable "environment" {
  description = "Environment of the Cognito User Pool"
  type        = string
}

variable "domain_prefix" {
  description = "Prefix for the Cognito hosted domain"
  type        = string
}

variable "callback_urls" {
  description = "Callback URLs for app client (after login)"
  type        = list(string)
  default     = ["https://admin.mikasrahwono.link"]
}

variable "logout_urls" {
  description = "Logout URLs for app client"
  type        = list(string)
  default     = ["https://admin.mikasrahwono.link/logout"]
}
