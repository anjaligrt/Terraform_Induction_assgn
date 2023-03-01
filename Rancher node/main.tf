# creating EC2 aws using Terraform
provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "main" {
  filter {
    name = "tag:Name"
    values = "${var.vpc_name}"
  }
}

data "aws_subnet" "selected" {
  filter {
  name = "tag:Name"
  values = "${var.subnet_name}"
  }
}

data "aws_security_group" "sg_name"{
  filter {
    name = "tag:Name"
    values = "${var.sg_name}"
  }
}

data "aws_ebs_volume" "ebs_volume" {
  #owners = "${var.owner_id}"
  most_recent = true
  filter {
    name = "tag:Name"
    values = "${var.vol.vol_name}"
  }
  filter {
    name = "volume_type"
    values = "${var.vol.vol_type}"
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
  subnet_id         = data.aws_subnet.selected.subnet_name
  security_groups   = data.aws_security_group.sg_name.sg_name
  volume_tags       = data.aws_ebs_volume.ebs_volume.vol_name


  tags = {
    Name = "${var.inst_name}"
  }
  user_data = file("script.sh")
}

# attach existing volume 
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id = data.aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.ec2_terraform_example.id
}
