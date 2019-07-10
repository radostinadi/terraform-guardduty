### Create  S3 bucket for GuardDuty Findigs
resource "aws_s3_bucket" "guardduty_security_bucket" {
  bucket_prefix = "${var.guardduty_bucket_prefix}"
  region        = "${var.aws_region}"
  acl           = "private"

  lifecycle {
    prevent_destroy = false
  }
}

### IAM Policy to read/write to the GuardDuty Bucket
resource "aws_s3_bucket_object" "guardduty_iplist" {
  key        = "${var.guardduty_assets}/guardduty_iplist.txt"
  bucket     = "${aws_s3_bucket.guardduty_security_bucket.id}"
  source     = "${path.module}/guardduty_iplist.txt"
  content_type = "text/plain"
  etag       = "${md5(file("${path.module}/guardduty_iplist.txt"))}"
}
resource "aws_guardduty_ipset" "guardduty_iplist" {
  activate    = "${var.enable_guardduty_ipset}"
  detector_id = "${aws_guardduty_detector.guardduty.id}"
  format      = "TXT"
  location    = "https://s3.amazonaws.com/${aws_s3_bucket_object.guardduty_iplist.bucket}/${aws_s3_bucket_object.guardduty_iplist.key}"
  name        = "guardduty_iplist"
}
