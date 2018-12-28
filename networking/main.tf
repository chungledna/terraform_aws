# ---- networking/main.tf
data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc_name" {
  cidr_block = "${var.vpc_cidr_block}"

  tags {
    Name = "vpc_name"
  }
}

resource "aws_internet_gateway" "igw_name" {
  vpc_id = "${aws_vpc.vpc_name.id}"
  tags {
    Name = "igw-name"
  }
}

# Public
resource "aws_route_table" "public_rt_name" {
  vpc_id = "${aws_vpc.vpc_name.id}"

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw_name.id}"
  }

  tags = {
    Name = "Public route table"
  }
}

resource "aws_subnet" "public_subnet" {
  count = 2
  vpc_id = "${aws_vpc.vpc_name.id}"
  map_public_ip_on_launch = true
  cidr_block = "${var.public_sub_cidrs[count.index]}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags = {
    Name = "Public subnet ${count.index +1}"
  }
}

resource "aws_route_table_association" "public_associa" {
  count = "${aws_subnet.public_subnet.count}"

  subnet_id = "${aws_subnet.public_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.public_rt_name.id}"

}

resource "aws_security_group" "public_security_group" {
  name = "public_security_group"
  description = "Public security group"
  vpc_id = "${aws_vpc.vpc_name.id}"

  #SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.ssh_access_ip}"]
  }

  tags = {
    Name = "Public_SG"
  }
}

# Private
resource "aws_route_table" "private_rt_name" {
  vpc_id = "${aws_vpc.vpc_name.id}"

  tags = {
    Name = "Private route table"
  }
}



resource "aws_subnet" "private_subnet" {
  count = 2
  vpc_id = "${aws_vpc.vpc_name.id}"
  map_public_ip_on_launch = false
  cidr_block = "${var.private_sub_cidrs[count.index]}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags = {
    Name = "Private subnet ${count.index +1}"
  }
}

resource "aws_route_table_association" "private_associa" {
  count = "${aws_subnet.private_subnet.count}"

  subnet_id = "${aws_subnet.private_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.private_rt_name.id}"

}

resource "aws_security_group" "private_security_group" {
  name = "private_security_group"
  description = "Private security group"
  vpc_id = "${aws_vpc.vpc_name.id}"

  #SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.public_security_group.id}"]
  }

  tags = {
    Name = "Private_SG"
  }
}
