variable "aws_profile" {}

variable "aws_region" {}

variable "shared_credentials_file" {
  default = "~/.aws/credentials"
}

variable "name" {
  default = ""
}

variable "all_users" {
  type = "list"
}

variable "user_map_groups" {
  type = "map"
}

variable "aws_account" {
  default = ""
}

#network

variable "name" {}

variable "vpc_cidr" {}

variable "azs" {}

variable "region" {}

variable "private_subnets" {}

variable "public_subnets" {}

variable "database_subnets" {}

variable "key_name" {}

variable "sub_domain" {}

variable "route_zone_id" {}

variable "openvpn_instance_type" {}

variable "openvpn_user" {}

variable "openvpn_admin_user" {}

variable "openvpn_admin_pw" {}

variable "openvpn_cidr" {}

variable "users" {}

variable "admin_ip" {}

variable "env" {}
