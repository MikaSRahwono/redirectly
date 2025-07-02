variable "zone_id" {
  type        = string
  description = "ID of the Route53 hosted zone"
}

variable "redirect_subdomain" {
  type        = string
  default     = "mikasrahwono.link"
}

variable "admin_subdomain" {
  type        = string
  default     = "admin.mikasrahwono.link"
}

variable "api_gateway_domain_name" {
  type = string
}

variable "api_gateway_zone_id" {
  type = string
}

variable "cloudfront_domain_name" {
  type = string
}

variable "cloudfront_zone_id" {
  type = string
}
