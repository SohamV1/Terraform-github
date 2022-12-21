resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role_name"
  assume_role_policy = file("${path.module}/lambda_role.json")
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda_policy"
  role   = aws_iam_role.lambda_role.id
  policy = file("${path.module}/lambda_policy.json")

}

resource "aws_lambda_function" "my-lambda" {
  filename      = "lambda_function.zip"
  function_name = "my-lambda"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.7"
  handler       = "lambda_function"
}

resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = aws_s3_bucket.b.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.my-lambda.arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]

  }
}
resource "aws_lambda_permission" "test" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my-lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.b.id}"
}