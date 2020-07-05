data "archive_file" "eips_zip" {
  type        = "zip"
  source_file = "${path.module}/source/eips_cleanup.py"
  output_path = "${path.module}/source/eips.zip"
}

resource "aws_lambda_function" "EIPS_cleanup" {
  filename         = "${path.module}/source/eips.zip"
  function_name    = "${var.function_prefix}_eip_cleanup"
  role             = aws_iam_role.iam_role_for_eip_cleanup.arn
  handler          = "eips_cleanup.lambda_handler"
  source_code_hash = data.archive_file.eips_zip.output_base64sha256
  runtime          = "python3.6"
  memory_size      = "512"
  timeout          = "150"
}

resource "aws_lambda_permission" "allow_cloudwatch_EIPS_cleanup" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.EIPS_cleanup.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.EIPS_cleanup_cloudwatch_rule.arn
}

resource "aws_cloudwatch_event_rule" "EIPS_cleanup_cloudwatch_rule" {
  name                = "EIPS_cleanup_lambda_trigger"
  schedule_expression = var.eip_cleanup_cron
}

resource "aws_cloudwatch_event_target" "EIPS_cleanup_lambda" {
  rule      = aws_cloudwatch_event_rule.EIPS_cleanup_cloudwatch_rule.name
  target_id = "EIPS_cleanup_lambda_target"
  arn       = aws_lambda_function.EIPS_cleanup.arn
}

