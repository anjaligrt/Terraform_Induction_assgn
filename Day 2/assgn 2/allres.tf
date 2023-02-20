


provider "aws" {
  region = "ap-south-1"
}

# create vpc 
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Project VPC"
  }
}

# create subnets
#   public subnet
resource "aws_subnet" "public_subnets" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Public Subnet"
  }

}

/*
private subnet
resource "aws_subnet" "private_subnets" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "1b"

  tags = {
    Name = "Private Subnet"
  }
}
*/

# create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Project VPC IG"
  }
}

# create the 2nd route table
resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "2nd Route Table"
  }
}

# Associating Public Subnets to the Second Route Table
resource "aws_route_table_association" "public_subnet_asso" {
  subnet_id      = aws_subnet.public_subnets.id
  route_table_id = aws_route_table.second_rt.id
}

# create security group
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  vpc_id      = aws_vpc.main.id
  description = "Allow TLS inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}



# create EC2 instance
resource "aws_instance" "ec2_example" {
  #for_each = {
  #  ami = "ami-0f8ca728008ff5af4"
  #}
  #image = each.key
  #image_id = each.value
  count                  = 1
  ami                    = "ami-0f8ca728008ff5af4"
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  subnet_id              = aws_subnet.public_subnets.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true


  tags = {
    Name = "MyEC2"
  }
}

data "aws_instance" "myawsinstance" {
  filter {
    name   = "tag:Name"
    values = ["MyEC2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  depends_on = [
    aws_instance.ec2_example
  ]
}

# Output of Instance Id
output "theId" {
  value = data.aws_instance.myawsinstance.id

}

# Output of instance ip
output "instance_ip" {
  value = data.aws_instance.myawsinstance.public_ip
}

# create s3 bucket

resource "aws_s3_bucket" "demos3" {
  bucket = data.aws_instance.myawsinstance.id
  #acl = "private"


  tags = {
    Name = "My-bucket"
  }
}

