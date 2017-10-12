#--------------------------------------------------------------
# This module creates all Wordpress resources
#--------------------------------------------------------------

data "aws_ami" "centos_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS 6 x86_64*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["paravirtual"]
  }

  owners = ["679593333241"] # CentOS
}

#instance
resource "aws_instance" "wordpress" {
  ami                    = "${data.aws_ami.centos_linux.id}"
  ebs_optimized          = true
  instance_type          = "${var.wordpress_instance_type}"
  vpc_security_group_ids = ["${aws_security_group.wordpress.id}"]
  subnet_id              = "${element(split(",", var.private_subnets),0)}"
  user_data              = "${file("./files/wordpress-userdata.sh")}"
  iam_instance_profile   = "${aws_iam_role.wordpress.name}"
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
    Name      = "${var.env}_${var.name}_db_sec_group"
    Env       = "${var.env}"
    Terraform = "true"
  }
}

#cloudwatch alarm

resource "aws_iam_instance_profile" "wordpress" {
  name  = "wordpress_profile"
  role = "${aws_iam_role.wordpress.name}"
}

#s3 iam permissions for ec2
resource "aws_iam_role" "wordpress" {
  name = "wordpress-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "wordpress" {
  name = "wordpress_role_policy"
  role = "${aws_iam_role.wordpress.id}"

  policy = "${data.aws_iam_policy_document.wordpress_policy.json}"
}

data "aws_iam_policy_document" "wordpress_policy" {
  statement {
    sid = "AWSwordpressWrite"

    actions = [
      "s3:*",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:s3:::terraform-wordpress-demo",
      "arn:aws:s3:::terraform-wordpress-demo/*",
    ]
  }
}
