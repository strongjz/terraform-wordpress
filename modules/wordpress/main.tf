#--------------------------------------------------------------
# This module creates all Wordpress resources
#--------------------------------------------------------------

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
}


#instance
resource "aws_instance" "wordpress" {
  count = 3
  ami   = "${data.aws_ami.amazon_linux.id}"

  instance_type          = "${var.wordpress_instance_type}"
  vpc_security_group_ids = ["${aws_security_group.wordpress.id}"]
  subnet_id              = "${element(split(",", var.private_subnet_ids),count.index)}"
  user_data              = "${file("./files/wordpress-userdata.sh")}"
  private_ip             = "${cidrhost(element(split(",", var.private_subnets),count.index), count.index + 10)}"

  tags {
    Name = "${var.name}-${count.index}"
    
  }
}

#security group
resource "aws_security_group" "wordpress" {
  name        = "${var.env}_${var.name}_wordpress_sec_group"
  description = "Allows wordpress connections"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"

    cidr_blocks = ["${split(",", var.vpn_subnets)}"]
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
    Name      = "${var.env}_${var.name}_sec_group"
    Env       = "${var.env}"
    Terraform = "true"
  }
}
