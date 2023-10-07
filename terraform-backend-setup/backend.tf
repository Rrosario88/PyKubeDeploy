provider "aws" {
  region = "us-east-1" 
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "tform_states" 

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name           = "terraform-up-and-running-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
