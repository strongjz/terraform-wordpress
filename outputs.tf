output "openvpn_public_ip" {
  value = "${module.network.openvpn_public_ip}"
}

output "wordpress_ips" {
  value = ["${module.wordpress.wordpress_ips}"]
}

output "wordpress_public_ips" {
  value = ["${module.wordpress.wordpress_public_ips}"]
}

output "database_public_ip" {
  value = "${module.wordpress.database_public_ip}"
}
