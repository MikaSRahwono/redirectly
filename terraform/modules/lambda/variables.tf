variable "create_zip_path" {
  description = "Path to zip file for create_url Lambda"
  type        = string
}

variable "redirect_zip_path" {
  description = "Path to zip file for redirect_url Lambda"
  type        = string
}

variable "auth_zip_path" {
  description = "Path to zip file for auth_user Lambda"
  type        = string
}

variable "stats_zip_path" {
  description = "Path to zip file for get_stats Lambda"
  type        = string
}

variable "env_variables" {
  description = "Environment variables for all Lambdas"
  type        = map(string)
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Subnets for redirect Lambda to access Redis"
}

variable "redirect_lambda_sg_id" {
  type        = string
  description = "Security group ID for redirect Lambda"
}
