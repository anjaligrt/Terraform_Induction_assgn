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
  region = "ap-south-1"
}

# Resource Block
resource "aws_instance" "webserver" {
  ami           = "ami-0e07dcaca348a0e68"
  instance_type = "t2.micro"
  tags = {
    Name = "terraform_ec2_inst"
  }
}


# Using Environment Variables

