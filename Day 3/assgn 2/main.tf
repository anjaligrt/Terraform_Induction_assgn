provider "aws" {
  region = "ap-south-1"
}

module "mymodule1" {
  source = ".//module"
}
