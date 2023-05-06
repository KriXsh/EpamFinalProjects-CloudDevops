provider "aws" {
  region = "us-east-1"
}

# Define VPC and subnets in us-east-1a
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet_1" {
  cidr_block = "10.0.3.0/24"
  vpc_id     = aws_vpc.my_vpc.id
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_subnet_1" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.my_vpc.id
  availability_zone = "us-east-1a"
}

# Define subnets in us-east-1b
resource "aws_subnet" "public_subnet_2" {
  cidr_block = "10.0.4.0/24"
  vpc_id     = aws_vpc.my_vpc.id
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "private_subnet_2" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.my_vpc.id
  availability_zone = "us-east-1b"
}
