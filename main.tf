terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  backend "remote" {
    organization = "khaireeorg"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "lambda_with_api_gw_module" {
  source = "./lambda_with_api_gw_module"
  resource_name_prefix = var.resource_name_prefix
}