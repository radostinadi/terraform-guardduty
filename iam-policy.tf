### IAM Policy needed to enable GuardDuty
resource "aws_iam_policy" "iam_enable_guardduty" {
  count       = "${var.manage_guardduty_policy ? 1 : 0}"
  name        = "IAM-enable-guardduty"
  path        = "/"
  description = "IAM Permissions to enable GuardDuty"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "guardduty:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole"
            ],
            "Resource": "arn:aws:iam::${var.aws_account_id}:role/aws-service-role/guardduty.amazonaws.com/AWSServiceRoleForAmazonGuardDuty",
            "Condition": {
                "StringLike": {
                    "iam:AWSServiceName": "guardduty.amazonaws.com"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:PutRolePolicy",
                "iam:DeleteRolePolicy"
            ],
            "Resource": "arn:aws:iam::${var.aws_account_id}:role/aws-service-role/guardduty.amazonaws.com/AWSServiceRoleForAmazonGuardDuty"
        }
    ]
}
EOF
}
### IAM Policy to manage the Guardduty Security Bucket
resource "aws_iam_policy" "guardduty_security_bucket" {
  count       = "${var.manage_guardduty_policy ? 1 : 0}"
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
data "aws_iam_policy_document" "guardduty-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
  }
}
### AWS Role with permissions to manage Guardduty
resource "aws_iam_role" "guardduty_manage_role" {
  count       = "${var.manage_guardduty_policy ? 1 : 0}"
  name               = "guardduty_manage_role",
  assume_role_policy = "${data.aws_iam_policy_document.guardduty-assume-role-policy.json}"
}
resource "aws_iam_role_policy_attachment" "useS3bucket" {
  count       = "${var.manage_guardduty_policy ? 1 : 0}"
  role      = "${aws_iam_role.guardduty_manage_role.name}",
  policy_arn = "${aws_iam_policy.guardduty_security_bucket.arn}"
}
resource "aws_iam_role_policy_attachment" "guardduty-policy-attach" {
  count       = "${var.manage_guardduty_policy ? 1 : 0}"
  role       = "${aws_iam_role.guardduty_manage_role.name}"
  policy_arn = "${aws_iam_policy.iam_enable_guardduty.arn}"
}
### IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  count       = "${var.manage_guardduty_policy ? 1 : 0}"
  name = "lambda_exec_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
} 
 