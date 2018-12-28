# ---- networking/variables.tf
variable "vpc_cidr_block" {
  description = "VPC block cidr"
  default = "10.90.0.0/16"
}

variable "public_sub_cidrs" {
  type = "list"
  default = [
    "10.90.1.0/24",
    "10.90.2.0/24"
  ]
}

variable "public_sub_cidrs" {
  type = "list"
  default = [
    "10.90.3.0/24",
    "10.90.4.0/24"
  ]
}

variable "ssh_access_ip" {}
