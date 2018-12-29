# main.tf
provider "aws" {
  region = "${var.region}"
}

module "networking" {
  source = "./networking"
  ssh_access_ip = "${var.ssh_access_ip}"
}

module "compute" {
  source = "./compute"
  instance_count = "${var.instance_count}"
  key_name = "${var.key_name}"
  public_key_path = "${var.public_key_path}"
  instance_type = "${var.server_instance_type}"
  subnets = "${module.networking.public_subnets}"
  security_group = "${module.networking.public_sg}"
  subnet_ips = "${module.networking.subnet_ips}"
}
