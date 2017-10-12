#--------------------------------------------------------------
# This module creates the S3 resource for Cloud trail
#--------------------------------------------------------------

variable "name" {}

variable "aws_region" {}

resource "aws_s3_bucket" "cloudtrail" {
  bucket        = "${var.name}-cloudtrail-${var.aws_region}"
  force_destroy = true
  policy        = "${data.aws_iam_policy_document.cloudtrail.json}"
}

resource "aws_s3_bucket" "wordpressdemo" {
  bucket        = "terraform-wordpress-demo"
  force_destroy = true
}

resource "aws_s3_bucket_object" "wordpress" {
  bucket = "${aws_s3_bucket.wordpressdemo.bucket}"
  key    = "wordpress-nginx/"
  source = "${file("./files/wordpress-nginx.zip")}"
}

data "aws_iam_policy_document" "cloudtrail" {
  statement {
    sid = "AWSCloudTrailAclCheck"

    actions = [
      "s3:GetBucketAcl",
    ]

    principals {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com",
      ]
    }

    effect = "Allow"

    resources = [
      "arn:aws:s3:::${var.name}-cloudtrail-${var.aws_region}",
    ]
  }

  statement {
    sid = "AWSCloudTrailWrite"

    actions = [
      "s3:PutObject",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:s3:::${var.name}-cloudtrail-${var.aws_region}/*",
    ]

    principals {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com",
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }
  }
}
