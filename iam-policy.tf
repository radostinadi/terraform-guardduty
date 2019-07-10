### IAM Policy needed to enable GuardDuty
resource "aws_iam_policy" "iam_enable_guardduty" {
  count       = "${var.manage_guardduty_role ? 1 : 0}"
  name        = "IAM-enable-guardduty"
  path        = "/"
  description = "IAM Permissions to enable GuardDuty"
  policy      = "${file("${path.module}/template/guardduty_manage_policy.json")}"
}
### IAM Policy to manage the Guardduty Security Bucket
resource "aws_iam_policy" "guardduty_security_bucket" {
  count       = "${var.manage_guardduty_role ? 1 : 0}"
  name        = "guardduty-security-bucket"
  description = "Allows full access to the contents of the guardduty bucket"
  policy = "${file("${path.module}/template/s3_bucket_policy.json")}"
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
  count       = "${var.manage_guardduty_role ? 1 : 0}"
  name        = "guardduty_manage_role",
  assume_role_policy = "${data.aws_iam_policy_document.guardduty-assume-role-policy.json}"
}
resource "aws_iam_role_policy_attachment" "useS3bucket" {
  count       = "${var.manage_guardduty_role ? 1 : 0}"
  role        = "${aws_iam_role.guardduty_manage_role.name}",
  policy_arn  = "${aws_iam_policy.guardduty_security_bucket.arn}"
}
resource "aws_iam_role_policy_attachment" "guardduty-policy-attach" {
  count       = "${var.manage_guardduty_role ? 1 : 0}"
  role        = "${aws_iam_role.guardduty_manage_role.name}"
  policy_arn  = "${aws_iam_policy.iam_enable_guardduty.arn}"
}
### IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  count       = "${var.manage_guardduty_role ? 1 : 0}"
  name        = "lambda_exec_role"
  assume_role_policy = "${file("${path.module}/template/lambda_assumerole_policy.json")}"
} 
 