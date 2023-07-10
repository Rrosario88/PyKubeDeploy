terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.6.2"
      
    }
  }
}

provider "aws" {

  region = "us-east-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY

}