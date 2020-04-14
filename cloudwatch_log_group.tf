resource "aws_cloudwatch_log_group" "lambda" {
  count               = var.cloudwatch_logs ? 1 : 0
  name                = "/aws/lambda/${var.function_name}"
  tags                = var.tags
  retention_in_days   = var.cloudwatch_logs_retention_days
}
