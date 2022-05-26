terraform {
  backend "s3" {
    bucket         = "petclinic-terraformtfstate"
    key            = "recipe-app.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "petclinic-terraformtfstate-lock"
  }
}

provider "aws" {
  region = "us-east-1"
  version = "~> 4.15.1"
}

