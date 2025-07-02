resource "aws_dynamodb_table" "url_table" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "short_url"

  attribute {
    name = "short_url"
    type = "S"
  }

  tags = {
    Name = var.table_name
  }
}
