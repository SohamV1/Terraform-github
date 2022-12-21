resource "aws_s3_bucket" "b" {
  bucket = "lambda-s3-bucket-4290"

  tags = {
    Name = "lambda-s3-bucket-4290"
  }
}