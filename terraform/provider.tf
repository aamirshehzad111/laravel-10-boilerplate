terraform {
  required_providers {
    aws = {
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-west-2"
  profile = "ddeefault"
}