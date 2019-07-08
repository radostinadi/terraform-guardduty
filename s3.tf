### Create  S3 bucket for GuardDuty Findigs
resource "aws_s3_bucket" "guardduty_security_bucket" {
  bucket_prefix = "${var.bucket_prefix}"
  region        = "${var.aws_region}"
  acl           = "private"

  lifecycle {
    prevent_destroy = true
  }
}

### IAM Policy to read/write to the GuardDuty Bucket
resource "aws_iam_policy" "guardduty_security_bucket" {
  name        = "guardduty-security-bucket"
  path        = "/security/"
  description = "Allows full access to the contents of the guardduty bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListAllMyBuckets",
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "${aws_s3_bucket.guardduty_security_bucket.arn}",
        "${aws_s3_bucket.guardduty_security_bucket.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "useS3bucket" {
  role      = "${aws_iam_role.guardduty_manage_role.name}",
  policy_arn = "${aws_iam_policy.guardduty_security_bucket.arn}"
}


