provider "aws" {
  region = "us-east-1"
}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.5.0"

  bucket = "terraform-module-demo-4290"
}

output "bucket_arn" {
  value       = module.s3-bucket.s3_bucket_arn
  description = "s3 bucket arn"
}
