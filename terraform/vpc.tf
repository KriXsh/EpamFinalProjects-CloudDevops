#step1 create a vpc

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
     tags = {
        Name ="MyterraformVPC"
     }
  
}

#terraform code to launch EC2 instance
/*resource "aws_instance" "web" {
    ami ="al2023-ami-2023.0.20230419.0-kernel-6.1-x86_64" #amazon linux AMI
    instance_type="t2.micro"

    tags = {
      Name="krish-terraform-ec2"
    }
  
}
#SEQURITY group using terraform
resource "aws_security_group" "TF-krish" {
  name        = "security group using terraform"
  description = "security group using terraform"
  vpc_id      ="vpc-0444877119e90f85d"
# we are seting 3 rules in ingress http ssh and 
  
ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}*/

#step2 create a public subnet
resource "aws_subnet" "PublicSubnet" {
        vpc_id= aws_vpc.myvpc.id
        cidr_block = "10.0.3.0/24"
        

  
}
/*resource "aws_subnet" "PublicSubnet2" {
        vpc_id= aws_vpc.myvpc.id
        cidr_block = "10.0.4.0/24"

  
}
*/

#step3 create a private subnet 
resource "aws_subnet" "PrivateSubnet" {
        vpc_id = aws_vpc.myvpc.id
        cidr_block = "10.0.1.0/24"

  
}
/*
resource "aws_subnet" "PrivateSubnet2" {
        vpc_id= aws_vpc.myvpc.id
        cidr_block = "10.0.2.0/24"

  
}*/

#step-4
#create  internet gateway
resource "aws_internet_gateway" "igw" {
   vpc_id = aws_vpc.myvpc.id
}
#step-5 create a route table
 resource "aws_route_table" "PublicRT" {
   vpc_id = aws_vpc.myvpc.id
   route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
   }
 }

 #step-6 route table associate public subnet
 resource "aws_route_table_association" "PublicRTassociation" {
  subnet_id = aws_subnet.PrivateSubnet.id
  route_table_id = aws_route_table.PublicRT.id
   
 }
