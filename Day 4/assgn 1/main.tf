# Import existing infrastructure for aws_instance


provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "ec2_example" {

}




--------------------------
  
terraform import aws_instance.ec2_example i-0b388083bba645b46
terraform show

# can reate resource from imported insfrastructure
# resource "aws_instance" "ec2_example" {
#     ami                                  = "ami-0f8ca728008ff5af4"
#     arn                                  = "arn:aws:ec2:ap-south-1:103586567561:instance/i-0b388083bba645b46"
#     associate_public_ip_address          = true
#     availability_zone                    = "ap-south-1b"
#     tags                                 = {
#         "Name" = "MyEC2"
#     }
#     tags_all                             = {
#         "Name" = "MyEC2"
#     }
#   ....
#
