variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key ID"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Access Key"
}

# Retrieve the AWS credentials from Secrets Manager
data "aws_secretsmanager_secret" "my_credentials" {
  name = "AWSCastleKeys"
}

data "aws_secretsmanager_secret_version" "my_credentials_version" {
  secret_id = data.aws_secretsmanager_secret.my_credentials.id
}

# Configure the AWS provider with the retrieved credentials
provider "aws" {
  access_key = jsondecode(data.aws_secretsmanager_secret_version.my_credentials_version.secret_string)["aws_access_key_id"]
  secret_key = jsondecode(data.aws_secretsmanager_secret_version.my_credentials_version.secret_string)["aws_secret_access_key"]
  region     = "us-east-1" # Replace with your desired AWS region
}

# Your Terraform resources go here
resource "aws_instance" "example" {
  ami           = "ami-0c94855ba95c71c99" # Replace with your desired AMI
  instance_type = "t2.micro"
  # ... other configuration ...
}

