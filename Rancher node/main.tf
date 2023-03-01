# creating EC2 aws using Terraform
provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "main" {
  owners = "${var.owner_id}"
  filter {
    name = "tag:Name"
    values = ["Project VPC"]
  }
}

data "aws_subnet" "selected" {
  owners = "${var.owner_id}"
  filter {
  name = "tag:Name"
  values = ["My Public Subnet"]
  }
}

data "aws_security_group" "sg_name"{
  owners = "${var.owner_id}"
  filter {
    name = "tag:Name"
    values = ["allow_tls"]
  }
}

data "aws_ami" "vol_name" {
  owners = "${var.owner_id}"
  filter {
    name = "vol_name"
    values = ["my_vol"]
  }
}

# create EC2 instance
resource "aws_instance" "ec2_terraform_example" {
  count             = 1
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  key_name          = var.key_name
  vpc_id            = data.aws_vpc.main.vpc_id
  subnet_id         = data.aws_subnet.selected.subnet_id
  security_groups   = data.aws_security_group.sg_name.id
  volume_tags       = data.aws_ami.vol_name.vol_name


  tags = {
    Name = "${var.inst_name}"
  }
  user_data = file("script.sh")
}
