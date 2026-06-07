output "lines_table_name" {
  description = "DynamoDB lines table name"
  value       = aws_dynamodb_table.lines.name
}

output "transactions_table_name" {
  description = "DynamoDB transactions table name"
  value       = aws_dynamodb_table.transactions.name
}

output "api_access_key_id" {
  description = "AWS access key ID for the API"
  value       = aws_iam_access_key.api.id
}

output "api_secret_access_key" {
  description = "AWS secret access key for the API"
  value       = aws_iam_access_key.api.secret
  sensitive   = true
}
