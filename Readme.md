# EIP Cleanup of unattached IPs delete

## Summary


This module provides the following:
 - lambda
 - IAM

## Usage


module "aws_tf_eip_cleaner" {
  source = "/aws_tf_eip_cleaner"
  name               = "penny"
}
