#---- networking/outputs.tf

output "public_subnets" {
  value = "${aws_subnet.public_subnet.*.id}"
}

output "public_sg" {
  value = "${aws_security_group.bastion_sg.id}"
}

output "subnet_ips" {
  value = "${aws_subnet.public_subnet.*.cidr_block}"
}
