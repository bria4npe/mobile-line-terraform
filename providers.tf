terraform {
  required_version = ">= 1.1"

  cloud {

    organization = "bria4npe"

    workspaces {
      name = "mobile-line-workspace"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      project = "mobile-line"
    }
  }
}
