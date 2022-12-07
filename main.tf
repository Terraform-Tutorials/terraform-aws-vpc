terraform {
  //required_version = ">=1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider for this project
provider "aws" {
  shared_credentials_file = "/home/amaurybsouza/.aws"
  profile                 = "devopsaws"
  region                  = "us-east-1"

  default_tags {
    tags = {
      owner      = "Amaury"
      maneged_by = "terraform"
    }
  }
}