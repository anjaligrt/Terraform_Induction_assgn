# Fetching aws ec2 instance data using Data source

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "ec2_example" {
  ami           = "ami-0f8ca728008ff5af4"
  instance_type = "t2.micro"

  tags = {
    Name = "MyEC2"
  }
}

data "aws_instance" "myawsinstance" {
  filter {
    name   = "tag:Name"
    values = ["MyEC2"]
  }

  depends_on = [
    "aws_instance.ec2_example"
  ]
}

output "fetched_from_aws" {
  value = data.aws_instance.myawsinstance.ami

}
