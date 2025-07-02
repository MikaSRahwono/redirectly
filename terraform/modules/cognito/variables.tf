variable "pool_name" {
  description = "Name of the Cognito User Pool"
  type        = string
  default     = "url-shortener-users"
}

variable "domain_prefix" {
  description = "Prefix for the Cognito hosted domain"
  type        = string
  default     = "mika-url-auth"
}

variable "callback_urls" {
  description = "Callback URLs for app client (after login)"
  type        = list(string)
  default     = ["https://admin.mikasrahwono.link/callback"]
}

variable "logout_urls" {
  description = "Logout URLs for app client"
  type        = list(string)
  default     = ["https://admin.mikasrahwono.link"]
}
