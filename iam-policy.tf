### IAM Policy needed to enable GuardDuty
resource "aws_iam_policy" "iam_enable_guardduty" {
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

data "aws_iam_policy_document" "guardduty-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "guardduty_manage_role" {
  name               = "guardduty_manage_role",
  assume_role_policy = "${data.aws_iam_policy_document.guardduty-assume-role-policy.json}"
}

resource "aws_iam_policy_attachment" "guardduty-policy-attach" {
  name       = "guardduty-policy-attach"
  roles       = ["${aws_iam_role.guardduty_manage_role.name}"],
  policy_arn = "${aws_iam_policy.iam_enable_guardduty.arn}"
}

### IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
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