# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.21" # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIARQHR5SWESYMM3BER"
  secret_key = "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"
}

# Resource Block
resource "aws_instance" "webserver" {
  ami  = "ami-0f8ca728008ff5af4"
  instance_type = "t2.micro"
}
