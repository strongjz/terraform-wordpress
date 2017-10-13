output "wordpress_ips" {
  value = ["${aws_instance.wordpress.*.private_ip}"]
}

output "wordpress_public_ips" {
  value = ["${aws_instance.wordpress.*.public_ip}"]
}

output "database_public_ip" {
  value = "${aws_instance.wordpressdatabase.public_ip}"
}
