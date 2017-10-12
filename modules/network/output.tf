# VPC
output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_cidr" {
  value = "${module.vpc.vpc_cidr}"
}

output "vpc_s3_endpoint" {
  value = "${module.vpc.vpc_s3_endpoint}"
}

# Subnets
output "public_subnet_ids" {
  value = "${module.public_subnet.subnet_ids}"
}

output "private_subnet_ids" {
  value = "${module.private_subnet.subnet_ids}"
}

# NAT
output "nat_gateway_ids" {
  value = "${module.nat.nat_gateway_ids}"
}

# OpenVPN
output "openvpn_private_ip" {
  value = "${module.openvpn.private_ip}"
}

output "openvpn_public_ip" {
  value = "${module.openvpn.public_ip}"
}
