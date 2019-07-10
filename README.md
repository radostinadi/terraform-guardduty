# terraform-guardduty

Terraform module to enable the AWS GuardDuty service. The module creates the following resources:

- Enable AWS GuardDuty
- Create an S3 bucket for GuardDuty Assets 
- Set up CloudWatch to capture GuardDuty Events
- Enable GuardDuty IPList (optional)
- Create AWS Policies to manage GuardDuty and attach them to a Role (optional)
- Create an SNS topic for GuardDuty and manage subscription (optional)



## Usage

The following requirements need to be met in order to use the module:

- Valid AWS credentials
- Terraform installation

Sample usage:

```hcl
module "terraform-guardduty" {
  source = "../../modules/terraform-guardduty"
  guardduty_enable_ipset = "true"
  create_sns_topic = "true"
  sns_topic_name = <TOPIC NAME>
  manage_guardduty_policy = "true"
}
```

## Variables
The following variables can be configured:

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_region | Name of the AWS region | string | "eu-west-1" | no |
| aws\_account\_id | AWS Account ID | string | n/a | yes |
| create\_sns\_topic | Whether an SNS topic will be created | string | "true"  | no |
| sns\_topic\_name | The name of the SNS topic to send AWS GuardDuty findings. | string | "GuardDuty_Notifications" | no |
| guardduty\_bucket\_prefix | Bucket for the S3 bucket created for GuardDuty assets | string | "GuardDuty" | no |
| guardduty\_enable\_ipset | Whether IPSet will be enabled for GuardDuty | string | "false"  | no |
| guardduty\_role\_name | Name of the Role which will manage the GuardDuty service | string | "GuardDuty_enable_role"  | no |
| guardduty\_notification\_endpoint | SNS Notification Endpoint | string | n/a  | yes |
| guardduty\_subscription\_protocol | Protocol for the SNS Subscription | string | n/a  | yes |

```hcl
aws_region
aws_account_id
create_sns_topic
sns_topic_name 
manage_guardduty_policy
guardduty_notification_recipient
guardduty_subscription_protocol
guardduty_role_name
guardduty_enable_ipset
guardduty_bucket_prefix

```

