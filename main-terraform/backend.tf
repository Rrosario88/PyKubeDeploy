terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.19" # Update to a version >= 3.19.0

    }
  }
}

# Configure the AWS provider with temporary static credentials
provider "aws" {
  alias      = "static"
  access_key = "TEMPORARY_ACCESS_KEY"
  secret_key = "TEMPORARY_SECRET_KEY"
  region     = "us-east-1"
}

# Retrieve the AWS credentials from Secrets Manager
data "aws_secretsmanager_secret_value" "my_credentials" {
  provider  = aws.static
  secret_id = "AWSCastleKeys"
}

# Configure the AWS provider with the retrieved credentials
provider "aws" {
  access_key = jsondecode(data.aws_secretsmanager_secret_value.my_credentials.secret_string)["aws_access_key_id"]
  secret_key = jsondecode(data.aws_secretsmanager_secret_value.my_credentials.secret_string)["aws_secret_access_key"]
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
