
# Creating VPC
resource "aws_vpc" "my_vpc"{
cidr_block = "10.0.0.0/16"
instance_tenancy = "default"
enable_dns_hostnames = true
tags = {
Name = "my-vpc"
}
}

# Creating internet gate way
resource "aws_internet_gateway" "my_igw"{
vpc_id = aws_vpc.my_vpc.id
tags = {
Name = "my-igw"
}
}

# Creating public subnet
resource "aws_subnet" "public_subnet"{
vpc_id = aws_vpc.my_vpc.id
cidr_block = "10.0.0.0/24"
availability_zone = "eu-west-2a"
map_public_ip_on_launch = true
tags = {
Name = "public-subnet"
}
}

# Creating private subnet
resource "aws_subnet" "private_subnet"{
vpc_id = aws_vpc.my_vpc.id
cidr_block = "10.0.4.0/22"
availability_zone = "eu-west-2a"
tags = {
Name = "private-subnet"
}
}


# Allocate EIP for NAT gateway
resource "aws_eip" "my_eip" {
vpc = true
tags = {
Name = "my-eip"
}
}

# Create NAT gateway
resource "aws_nat_gateway" "my_nat" {
allocation_id = aws_eip.my_eip.id
subnet_id = aws_subnet.public_subnet.id
tags = {
Name = "my-nat"
}
}

# Create route table for private subnet
resource "aws_route_table" "private_rt" {
vpc_id = aws_vpc.my_vpc.id
route {
cidr_block = "0.0.0.0/0"
nat_gateway_id = aws_nat_gateway.my_nat.id
}
tags = {
Name = "private-rt"
}
}

# Associate route table with private subnet
resource "aws_route_table_association" "private_rta"{
subnet_id = aws_subnet.private_subnet.id
route_table_id = aws_route_table.private_rt.id
}

# Create route table for public subnet
resource "aws_route_table" "public_rt" {
vpc_id = aws_vpc.my_vpc.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.my_igw.id
}
tags = {
Name = "public-rt"
}
}

# Associate route table with public subnet
resource "aws_route_table_association" "public_rta"{
subnet_id = aws_subnet.public_subnet.id
route_table_id = aws_route_table.public_rt.id
}













