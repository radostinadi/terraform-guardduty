# terraform-guardduty

Terraform module to enable the AWS GuardDuty service. The module creates the following resources:

- Create AWS Policy to enable GuardDuty and attach to a Role
- Create AWS Policy for S3logging bucket 
- Enable AWS GuardDuty
- Set up CloudWatch to capture GuardDuty Events
- Create an SNS topic for GuardDuty and manage subscription


## Usage

The following requirements need to be met in order to use the module:

- Valid AWS credentials
- Terraform installation

Sample usage:

```hcl
module "terraform-guardduty" {
  source = "../../modules/terraform-guardduty"
  aws_sns_topic = <TOPIC NAME>
}
```

## Variables
The following variables can be configured:

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_region | Name of the AWS region | string | "eu-west-1" | no |
| aws\_account\_id | AWS Account ID | string | n/a | yes |
| aws\_sns\_topic | The name of the SNS topic to send AWS GuardDuty findings. | string | n/a | yes |
| bucket\_prefix | Bucket for the S3 bucket created for GuardDuty logs | string | "GuardDuty" | no |
| guardduty\_manage\_role | Name of the Role which will manage the GuardDuty service | string | "GuardDuty_enable_role"  | no |
| guardduty\_notification\_endpoint | SNS Notification Endpoint | string | n/a  | yes |
| guardduty\_subscription\_protocol | Protocol for the SNS Subscription | string | n/a  | yes |

```hcl
aws_region
aws_account_id
aws_sns_topic 
guardduty_manage_role
bucket_prefix
guardduty_notification_recipient
guardduty_subscription_protocol
```

