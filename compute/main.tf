#--- compute/main.tf

data "aws_ami" "amazon_ami" {
  most_recent = true

  filter {
    name = "owner-alias"
    values = ["amazon"]
  }


  filter {
    name = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "aws_auth" {
  key_name = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

data "template_file" "user-init" {
  count = 2
}

resource "aws_instance" "web_server" {
  count = "${var.instance_count}"

  instance_type = "${var.instance_type}"
  ami = "${data.aws_ami.amazon_ami.id}"

  tags = {
    Name = "Web_server_${count.index + 1}"
  }

  key_name = "${aws_key_pair.aws_auth.id}"
  vpc_security_group_ids = ["${var.security_group}"]
  subnet_id = "${element(var.subnets, count.index)}"
  user_data = "${data.template_file.user-init.*.rendered[count.index]}"
}
