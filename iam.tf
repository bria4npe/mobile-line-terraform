resource "aws_iam_user" "api" {
  name = "${var.project}-api"

  tags = {
    project     = var.project
    environment = var.environment
  }
}

resource "aws_iam_access_key" "api" {
  user = aws_iam_user.api.name
}

resource "aws_iam_policy" "dynamodb_access" {
  name        = "${var.project}-dynamodb-access"
  description = "Allow API to read/write DynamoDB tables"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = [
          aws_dynamodb_table.lines.arn,
          aws_dynamodb_table.transactions.arn,
          "${aws_dynamodb_table.transactions.arn}/index/*"
        ]
      }
    ]
  })

  tags = {
    project     = var.project
    environment = var.environment
  }
}

resource "aws_iam_user_policy_attachment" "api" {
  user       = aws_iam_user.api.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}
