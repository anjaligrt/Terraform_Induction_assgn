# input_var.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  tags = {
     Name = var.instance_name
   }
}


# variables.tf
variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}


/*
Terraform configurations can include variables to make your configuration more dynamic and flexible.

**Terraform variables** allow you to write configuration that is flexible and easier to re-use.
- Add a variable to define the instance name.
- Create a new file called *variables.tf* with a block defining a new instance_name variable.

**Apply your configuration**
- Apply the configuration. Respond to the confirmation prompt with a yes.

Now apply the configuration again, this time overriding the default instance name by passing in a variable using the -var flag. Terraform will update the instance's Name tag with the new name. Respond to the confirmation prompt with yes.
  - terraform apply -var "instance_name=YetAnotherName"

*/
