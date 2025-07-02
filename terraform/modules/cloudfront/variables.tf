variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "s3_domain_name" {
  description = "S3 bucket domain name"
  type        = string
}

variable "name" {
  description = "Name prefix for OAC"
  type        = string
  default     = "admin-cdn"
}
