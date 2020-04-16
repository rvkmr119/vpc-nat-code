# vpc creattion
resource "aws_vpc" "bvpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags = {
      Name = "${var.vpc_name}-1"
    }
}

#Subenet creation
resource "aws_subnet" "pub_sub-1" {
  vpc_id = "${aws_vpc.bvpc.id}"
  cidr_block = "${var.pub_sub1_cidr}"
  availability_zone = "${var.az[0]}"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.pub_sub_name}-1"
  }
}

resource "aws_subnet" "pub_sub-2" {
  vpc_id = "${aws_vpc.bvpc.id}"
  cidr_block = "${var.pub_sub2_cidr}"
  availability_zone = "${var.az[1]}"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.pub_sub_name}-2"
  }
}

resource "aws_subnet" "pri_sub-1" {
  vpc_id = "${aws_vpc.bvpc.id}"
  cidr_block = "${var.pri_sub1_cidr}"
  availability_zone = "${var.az[2]}"
  tags = {
    Name = "${var.pri_sub_name}-1"
  }
}

resource "aws_subnet" "pri_sub-2" {
  vpc_id = "${aws_vpc.bvpc.id}"
  cidr_block = "${var.pri_sub2_cidr}"
  availability_zone = "${var.az[2]}"
  tags = {
    Name = "${var.pri_sub_name}-2"
  }
}

#IGW creation
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.bvpc.id}"
  tags = {
    Name = "${var.igname}"
  }
}

#Elastic ip creation
resource "aws_eip" "eip" {
  vpc = "true"
  depends_on = ["aws_internet_gateway.igw"]
}

#NAT Gateway creation
resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id = "${aws_subnet.pub_sub-1.id}"
  depends_on = ["aws_internet_gateway.igw"]
  tags = {
    Name = "${var.ngw}"
  }
}

#Routing Table Creation for public subnet
resource "aws_route_table" "public-RT" {
  vpc_id = "${aws_vpc.bvpc.id}"
  route {
    cidr_block = "${var.route_cidr}"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags = {
    Name = "${var.public_route_name}"
  }
}


#Routing Table Creation for private subnet
resource "aws_route_table" "private-RT" {
  vpc_id = "${aws_vpc.bvpc.id}"
  route {
    cidr_block = "${var.route_cidr}"
    gateway_id = "${aws_nat_gateway.ngw.id}"
  }
  tags = {
    Name = "${var.private_route_name}"
  }
}

#RoutinG table association for public subnets
resource "aws_route_table_association" "to_pub_sub-1" {
  subnet_id = aws_subnet.pub_sub-1.id
  route_table_id = "${aws_route_table.public-RT.id}"
}

resource "aws_route_table_association" "to_pub_sub-2" {
  subnet_id = aws_subnet.pub_sub-2.id
  route_table_id = "${aws_route_table.public-RT.id}"
}

#RoutinG table association for private subnets
resource "aws_route_table_association" "to_pri_sub-1" {
  subnet_id = aws_subnet.pri_sub-1.id
  route_table_id = "${aws_route_table.private-RT.id}"
}

resource "aws_route_table_association" "to_pri_sub-2" {
  subnet_id = aws_subnet.pri_sub-2.id
  route_table_id = "${aws_route_table.private-RT.id}"
}
