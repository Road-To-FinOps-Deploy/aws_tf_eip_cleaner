# Lambda Preventers
```
The script schedules the review of any eips that are unattached 

```

## Usage


module "aws_tf_eip_cleaner" {
  source = "/aws_tf_eip_cleaner"
}

## Optional Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| eip\_cleanup\_cron | Rate expression for when to run the review of eips| string | `"cron(0 7 ? * MON-FRI *)"` | no 
| function\_prefix | Prefix for the name of the lambda created | string | `""` | no |


## Testing 

Configure your AWS credentials using one of the [supported methods for AWS CLI
   tools](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html), such as setting the
   `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. If you're using the `~/.aws/config` file for profiles then export `AWS_SDK_LOAD_CONFIG` as "True".
1. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
1. Install [Golang](https://golang.org/) and make sure this code is checked out into your `GOPATH`.
cd test
go mod init github.com/sg/sch
go test -v -run TestTerraformAwsExample