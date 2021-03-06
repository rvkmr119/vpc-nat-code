region = "us-east-2"
instance_type = "t2.micro"
amitype = "ami-097834fcb3081f51a"
sgs = "new-sgs"
private_key = "temp"
vpc_cidr_block = "10.0.0.0/16"
vpc_name = "T-custom-VPC"
pub_sub1_cidr = "10.0.1.0/24"
pub_sub2_cidr = "10.0.2.0/24"
pri_sub1_cidr = "10.0.3.0/24"
pri_sub2_cidr = "10.0.4.0/24"
pub_sub_name = "T-Public-subnet"
pri_sub_name = "T-Private-subnet"
igname = "T-VPC-IGW"
ngw = "T-NAT-GW"
route_cidr = "0.0.0.0/0"
public_route_name = "T-Public-subnet-Main-route"
private_route_name = "T-Private-subnet-Main-route"
