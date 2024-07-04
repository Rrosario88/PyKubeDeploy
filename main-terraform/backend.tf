terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.19"
    }
  }
}

# Configure the AWS provider with credentials from environment variables
provider "aws" {
  alias  = "static"
  region = "us-east-1"
}

# Retrieve the AWS credentials from Secrets Manager
data "aws_secretsmanager_secret" "my_credentials" {
  provider = aws.static
  name     = "AWSCastleKeys"
}

data "aws_secretsmanager_secret_version" "my_credentials_version" {
  provider  = aws.static
  secret_id = data.aws_secretsmanager_secret.my_credentials.id
}

# Configure the AWS provider with the retrieved credentials
provider "aws" {
  access_key = jsondecode(data.aws_secretsmanager_secret_version.my_credentials_version.secret_string)["aws_access_key_id"]
  secret_key = jsondecode(data.aws_secretsmanager_secret_version.my_credentials_version.secret_string)["aws_secret_access_key"]
  region     = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "tform-states" 
    key            = "PyKubeDeploy/terraform.tfstate"
    region         = "us-east-1" 
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
