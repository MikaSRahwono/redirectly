variable "name" {
  description = "Prefix for resource naming"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where Redis will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "lambda_redirect_sg_id" {
  description = "Security Group ID of Lambda redirect function"
  type        = string
}

variable "node_type" {
  description = "Instance type for Redis"
  type        = string
  default     = "cache.t3.micro"
}
