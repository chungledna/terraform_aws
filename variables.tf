#---- variables.tf

variable "region" {
  description = "Region we will deploy this infastructure"
  default = "us-east-1"
}

variable "ssh_access_ip" {
  description = "List of cidr_block that allow to remote to AWS resource"
  default = "192.168.1.1/32"
}

variable "key_name" {
  default = "test.pem"
}

variable "public_key_path" {
  default = "~/.ssh/id_rs.pub"
}

variable "server_instance_type" {}

variable "instance_count" {
  default = 1
}
