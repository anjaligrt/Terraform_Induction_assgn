terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
     # version = "~> 4.16"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"
}

resource "aws_instance" "appserver" {
  ami           = "ami-0f8ca728008ff5af4"         # update ami_ID to "ami-0e07dcaca348a0e68"
  instance_type = "t2.micro"
  tags = {
    Name = "inst_updation"
  }
}
