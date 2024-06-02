terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "infra-ex"
    key = "minikube"
    region = "ap-south-1"
    dynamodb_table = "infra-lock"
    
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}