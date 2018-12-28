# main.tf
provider "aws" {
  region = "${var.region}"
}

module "networking" {
  source = "./networking"
  ssh_access_ip = "${var.ssh_access_ip}"
}
