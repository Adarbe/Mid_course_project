#### Provider ####

provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region = "us-east-1"
}

#data "aws_availability_zones" "available" {}



