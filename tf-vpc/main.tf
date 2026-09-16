
terraform {
  required_providers {
    aws={
        source  = "hashicorp/aws"
        version = "6.64.0"
    }
  }
}
provider "aws"{
    region = "ap-south-1"
    
}

# create a VPC
resource "aws_vpc" "my-vpc"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my-vpc"
    }

}

# private subnet
resource "aws_subnet" "my-private-subnet_for_my-vpc"{
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-private-subnet_for_my-vpc"
  }
}

# public subnet
resource "aws_subnet" "my-public-subnet_for_my-vpc"{
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-public-subnet_for_my-vpc"
  }
}

#internet gateway route 
resource "aws_internet_gateway" "my-internet-gateway_for_my-vpc" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "my-internet-gateway_for_my-vpc"
    }
  
}

# routing table
resource "aws_route_table" "my-route-table_for_my-vpc" {
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-internet-gateway_for_my-vpc.id
    }
    tags = {
        Name = "my-route-table_for_my-vpc"
    }
    
}

# association of route table and subnet
resource "aws_route_table_association" "my-route-table_association_for_my-vpc_publicsubnet"{
    subnet_id = aws_subnet.my-public-subnet_for_my-vpc.id
    route_table_id = aws_route_table.my-route-table_for_my-vpc.id
}

resource "aws_instance" "web-server" {
  ami = "ami-098f18a6382fb4b2d"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.my-public-subnet_for_my-vpc.id
  associate_public_ip_address = true
  tags = {
    Name = "my-web-server-in-vpc"
  }
}