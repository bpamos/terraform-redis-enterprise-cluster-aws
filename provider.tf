terraform {
  required_version = "~> 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# AWS region and AWS key pair
# choose your provider (aws) and provide the region and aws creds.
provider "aws" {
  region = var.region
  access_key = var.aws_creds[0]
  secret_key = var.aws_creds[1]
}