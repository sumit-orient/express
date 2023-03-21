###Terrrafor Provider conf
provider "aws" {
  region  = var.region
}

### Terraform remote state bucket configuration
terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws        = ">= 3.56.0"
    local      = ">= 1.4"
    cloudinit  = ">= 2.0"
    http = {
      source  = "terraform-aws-modules/http"
      version = ">= 2.4.1"
    }

  }

  # Change backend['s3'].key value per cluster creation. This should match the name of the cluster. For example: <cluster-name>/state
  # Change backend['s3'].region value. This should match the region of the S3 bucket.
  # Change backend['s3'].prefix value. This should match the AWS profile configured on your local AWS-cli to access target account.
#   backend "s3" {
#     bucket  = "cognizer-stage-terraform"
#     key     = "cognizer-stage-terraform/cognizer-stage-state"
#     region  = "us-west-1"
#   }
}




