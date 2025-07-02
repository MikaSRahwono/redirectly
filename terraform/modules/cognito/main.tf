resource "aws_cognito_user_pool" "user_pool" {
  name = var.pool_name

  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = false
    require_numbers   = true
    require_symbols   = false
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
}

resource "aws_cognito_user_pool_client" "app_client" {
  name         = "${var.pool_name}-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id

  generate_secret     = false
  allowed_oauth_flows = ["code"]
  callback_urls       = var.callback_urls
  logout_urls         = var.logout_urls
  allowed_oauth_scopes = ["email", "openid", "profile"]

  supported_identity_providers = ["COGNITO"]
  allowed_oauth_flows_user_pool_client = true
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = var.domain_prefix
  user_pool_id = aws_cognito_user_pool.user_pool.id
}
