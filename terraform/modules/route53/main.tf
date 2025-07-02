resource "aws_route53_record" "redirect_record" {
  zone_id = var.zone_id
  name    = var.redirect_subdomain
  type    = "A"

  alias {
    name                   = var.api_gateway_domain_name
    zone_id                = var.api_gateway_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "admin_ui_record" {
  zone_id = var.zone_id
  name    = var.admin_subdomain
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}
