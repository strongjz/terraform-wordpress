#--------------------------------------------------------------
# This module creates all Wordpress Database resources
#--------------------------------------------------------------

#instance
resource "aws_instance" "wordpressdatabase" {
  ami = "${data.aws_ami.centos_linux.id}"

  instance_type          = "${var.wordpressdatabase_instance_type}"
  vpc_security_group_ids = ["${aws_security_group.wordpressdatabase.id}"]
  subnet_id              = "${element(split(",", var.database_subnet_ids),0)}"
  private_ip             = "${cidrhost(element(split(",", var.database_subnets),0), count.index + 10)}"
}

#security group
resource "aws_security_group" "wordpressdatabase" {
  name        = "${var.env}_${var.name}_wordpressdatabase_sec_group"
  description = "Allows wordpressdatabase connections"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.wordpress.id}"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${split(",", var.vpn_subnets)}"]
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags {
    Name      = "${var.env}_${var.name}_db_sec_group"
    Env       = "${var.env}"
    Terraform = "true"
  }
}
