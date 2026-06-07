variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Project tag applied to all resources"
  type        = string
  default     = "mobile-line"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
