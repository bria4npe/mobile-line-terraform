# mobile-line-terraform

Infrastructure as Code for the mobile-line-api project using Terraform and AWS.

## Resources

| Resource | Name | Description |
| -------- | ---- | ----------- |
| `aws_dynamodb_table` | `mobile-line-lines` | Stores mobile line data |
| `aws_dynamodb_table` | `mobile-line-transactions` | Stores balance transactions with GSI |
| `aws_iam_user` | `mobile-line-api` | IAM user for the API |
| `aws_iam_policy` | `mobile-line-dynamodb-access` | DynamoDB read/write policy |
| `aws_iam_access_key` | — | Access key for the IAM user |
| `aws_iam_user_policy_attachment` | — | Attaches policy to IAM user |

## Stack

- **Terraform** >= 1.0
- **AWS Provider** ~> 5.0
- **Doppler** — secrets management
- **GitHub Actions** — CI/CD

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- [Doppler CLI](https://docs.doppler.com/docs/install-cli)
- AWS credentials with admin permissions

## Local Development

### 1. Install dependencies

```bash
winget install Hashicorp.Terraform
winget install Doppler.doppler
```

### 2. Authenticate

```bash
doppler login
doppler setup
```

### 3. Run Terraform

```bash
doppler run -- terraform init
doppler run -- terraform plan
doppler run -- terraform apply
```

## CI/CD

Every push to `main` triggers the GitHub Actions pipeline:

1. `terraform init` — initializes the AWS provider
2. `terraform fmt -check` — validates formatting
3. `terraform plan` — previews changes
4. `terraform apply` — applies changes to AWS (main branch only)

Pull requests only run `plan` — no changes are applied.

## Secrets (Doppler)

Secrets are managed in Doppler under the `mobile-line-terraform` project and synced automatically to GitHub Secrets via the [Doppler GitHub integration](https://docs.doppler.com/docs/github-actions).

| Secret | Description |
| ------ | ----------- |
| `AWS_ACCESS_KEY_ID` | AWS admin access key |
| `AWS_SECRET_ACCESS_KEY` | AWS admin secret key |
| `AWS_REGION` | AWS region (default: `us-east-1`) |

## Outputs

After `terraform apply`, Terraform outputs the credentials for the `mobile-line-api` IAM user. Add these to Doppler under the `mobile-line-api` project:

```bash
terraform output api_access_key_id
terraform output -raw api_secret_access_key
```

| Output | Description |
| ------ | ----------- |
| `lines_table_name` | DynamoDB lines table name |
| `transactions_table_name` | DynamoDB transactions table name |
| `api_access_key_id` | Access key ID for the API user |
| `api_secret_access_key` | Secret access key for the API user (sensitive) |
