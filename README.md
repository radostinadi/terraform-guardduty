# terraform-guardduty

Terraform module to enable the AWS GuardDuty service. The module creates the following resources:

- Create AWS Policy to enable GuardDuty and attach to a Role
- Create AWS Policy to create a S3 bucket for logs
- Enable AWS GuardDuty



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

```hcl
aws_region
aws_account_id
aws_sns_topic 
guardduty_manage_role
bucket_prefix
```

