# ---- networking/variables.tf
variable "vpc_cidr_block" {
  description = "VPC block cidr"
  default = "10.90.0.0/16"
}

variable "ssh_access_ip" {}
