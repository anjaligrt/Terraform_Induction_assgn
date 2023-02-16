# output_var.tf
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

resource "aws_instance" "app_server1" {
  ami           = "ami-0f8ca728008ff5af4"
  instance_type = "t2.micro"

  tags = {
     Name = var.instance_name1
   }
}

# variables.tf
variable "instance_name1" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance1"
}


# output.tf
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server1.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server1.public_ip
}



/*
Initialize your configuration and apply the configuration.
  
Create a file called outputs.tf in your directory.
You must apply this configuration before you can use these output values. Apply your configuration now. Respond to the confirmation prompt with yes.

Terraform prints output values to the screen when you apply your configuration. Query the outputs with the terraform output command.

You can use Terraform outputs to connect your Terraform projects with other parts of your infrastructure, or with other Terraform projects.
  
*/
