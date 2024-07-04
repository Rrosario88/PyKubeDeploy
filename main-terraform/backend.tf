terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"

    }
  }
}

provider "aws" {

  region     = "us-east-1"

  access_key = jsondecode(data.aws_secretsmanager_secret_version.my_credentials_version.secret_string)["aws_access_key_id"]
  secret_key = jsondecode(data.aws_secretsmanager_secret_version.my_credentials_version.secret_string)["aws_secret_access_key"]

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
