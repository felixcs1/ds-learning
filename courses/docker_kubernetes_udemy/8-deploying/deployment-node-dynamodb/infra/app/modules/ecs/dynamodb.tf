resource "aws_dynamodb_table" "this" {
  name         = "${var.app_name}-dynamodb-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserID"

  attribute {
    name = "UserID"
    type = "S"
  }
}