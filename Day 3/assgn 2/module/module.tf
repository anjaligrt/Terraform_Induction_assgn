provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "ec2_example3" {
  ami                    = "ami-0f8ca728008ff5af4"
  instance_type          = "t2.micro"
  key_name               = "aws_key"
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "Assgn3.2_Module EC2"
  }

  # Remote-exec Provisioner running bash script on remote machine
  provisioner "remote-exec" {
    script = "./testscript.sh"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("/home/anjoo/Documents/Anju/aws-creds/aws_key")
    timeout     = "4m"
  }

}

# creating security group
resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
}

# creating key pair
resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtzTQ2ckNNOxLKvCf4tvNUxMm0iteEugnfCCbZeQEv8cb4XhnAc/aBpDPxMF6BIgQGACLM0gzV+0XLlcdZYXMrX0p/K3rwjAHaESCwkhzCFQNexbfZcU7VBbqkDhgQPb8bVCTSG5+xghPCKPrFjb3rtHqP16r0ppOyYg0AhvQspgtRqOwJKqSYvkiP573z4PK6CP+sUJ2UBc6UsJktO10q9NSmHDFizTDte9zAf/+S0fOfCPoEvlCwHejH0E5sttsPES2cnsTXk0Lr3mDXuvNt4StFO+jsiUhc19L17aVWvMa7oFmhAuj8bql2J7eY4sbapWjcEggliDdLnL5k409H anjoo@GS-6083"
}
