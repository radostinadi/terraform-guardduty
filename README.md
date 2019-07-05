# terraform-guardduty

Terraform module to enable the AWS GuardDuty service

## Usage

```hcl
module "terraform-guardduty" {
  source = "../../modules/terraform-guardduty"

  sns_topic_name = <TOPIC NAME>
}
```
