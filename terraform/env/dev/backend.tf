terraform {
  backend "s3" {
    bucket  = "amz-task-terraform-state1"
    key     = "dev/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}