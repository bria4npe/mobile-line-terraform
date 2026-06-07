resource "aws_dynamodb_table" "lines" {
  name         = "${var.project}-lines"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "number"

  attribute {
    name = "number"
    type = "S"
  }

  tags = {
    project     = var.project
    environment = var.environment
  }
}

resource "aws_dynamodb_table" "transactions" {
  name         = "${var.project}-transactions"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "transaction_id"

  attribute {
    name = "transaction_id"
    type = "S"
  }

  attribute {
    name = "line_number"
    type = "S"
  }

  global_secondary_index {
    name            = "line_number-index"
    hash_key        = "line_number"
    projection_type = "ALL"
  }

  tags = {
    project     = var.project
    environment = var.environment
  }
}
