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

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, prod)"
}

variable "project_name" {
  type        = string
  description = "Name of the project for resource naming"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where Lambdas will be deployed"

}

