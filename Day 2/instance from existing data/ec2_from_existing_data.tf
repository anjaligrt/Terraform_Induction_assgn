provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "example" {
  owners = ["099720109477"]        # owner id of aws

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230208"]
  }
}

output "ami_id" {
  value = data.aws_ami.example.id #fechted the ami id 

}

#creating ec2 instance from exixting data
resource "aws_instance" "web" {
  ami           = data.aws_ami.example.id
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld" #name of the ec2 machine
  }
}
