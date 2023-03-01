# tf-vpc

Terraform program to create a VPC with DNS hostnames enabled, with one public subnet and one private subnet, and with a NAT gateway to enable internet access for instances in the private subnet in AWS


The aws_subnet resource is used to create one public subnet and one private subnet within the VPC. 

The map_public_ip_on_launch attribute is set to true in the public subnet resource to enable instances launched in that subnet to have public IP addresses. 

The aws_route_table_association resource is used to associate the route table with the public and private subnets.

The aws_nat_gateway resource is used to create a NAT gateway that enables instances in the private subnet to access the internet. 

The aws_eip resource is used to allocate an Elastic IP address
