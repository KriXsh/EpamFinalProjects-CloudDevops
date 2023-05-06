 #1 : Create a VPC
resource "aws_vpc" "MyVPCNEW"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "MyVPCNEW"
    }
}

 #2: Create a public subnet
resource "aws_subnet" "PublicSubnet1"{
    vpc_id = aws_vpc.MyVPCNEW.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.1.0/24"
}

 #3 : create a private subnet
resource "aws_subnet" "PrivSubnet1"{
    vpc_id = aws_vpc.MyVPCNEW.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true

}


# 4 : create IGW
resource "aws_internet_gateway" "myIgw"{
    vpc_id = aws_vpc.MyVPCNEW.id
}

# 5 : route Tables for public subnet
resource "aws_route_table" "PublicRT1"{
    vpc_id = aws_vpc.MyVPCNEW.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myIgw.id
    }
}
 

 #7 : route table association public subnet 
resource "aws_route_table_association" "PublicRT1Association"{
    subnet_id = aws_subnet.PublicSubnet1.id
    route_table_id = aws_route_table.PublicRT1.id
}