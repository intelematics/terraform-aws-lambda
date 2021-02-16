# Locals
locals {
  publish                  = var.lambda_at_edge ? true : var.publish
  timeout                  = var.lambda_at_edge ? min(var.timeout, 5) : var.timeout
  s3_lifecycle_delete_days = 30
}


# Required variables.
variable "function_name" {
  type = string
}
variable "handler" {
  type = string
}
variable "runtime" {
  type = string
}
variable "source_path" {
  description = "The absolute path to a local file or directory containing your Lambda source code"
  type        = string
}
variable "s3_bucket_lambda_package" {
  description = "s3 bucket to upload lambda package, and deploy lambda code from there, rather than direct post via api - enables fatter lambdas"
  type        = string
  default     = null
}

# Optional variables specific to this module.

variable "build_command" {
  description = "The command to run to create the Lambda package zip file"
  type        = string
  default     = "python3 build.py '$filename' '$runtime' '$source' '20200512-'"
}

variable "build_paths" {
  description = "The files or directories used by the build command, to trigger new Lambda package builds whenever build scripts change"
  type        = list(string)
  default     = ["build.py"]
}

variable "cloudwatch_logs" {
  description = "Set this to false to disable logging your Lambda output to CloudWatch Logs"
  type        = bool
  default     = true
}

variable "cloudwatch_logs_retention_days" {
  description = "Number of days to retain CloudWatch Logs"
  type        = number
  default     = 3653
}

variable "lambda_at_edge" {
  description = "Set this to true if using Lambda@Edge, to enable publishing, limit the timeout, and allow edgelambda.amazonaws.com to invoke the function"
  type        = bool
  default     = false
}

variable "policy" {
  description = "An additional policy to attach to the Lambda function role"
  type = object({
    json = string
  })
  default = null
}

variable "trusted_entities" {
  description = "Lambda function additional trusted entities for assuming roles (trust relationship)"
  type = list(string)
  default = []
}

# Optional attributes to pass through to the resource.

variable "description" {
  type    = string
  default = null
}

variable "permissions_boundary_arn" {
  type    = string
  default = null
}

variable "layers" {
  type    = list(string)
  default = null
}

variable "kms_key_arn" {
  type    = string
  default = null
}

variable "memory_size" {
  type    = number
  default = null
}

variable "publish" {
  type    = bool
  default = false
}
variable "reserved_concurrent_executions" {
  type    = number
  default = null
}

variable "tags" {
  type    = map(string)
  default = null
}

variable "timeout" {
  type    = number
  default = 3
}

# Optional blocks to pass through to the resource.

variable "dead_letter_config" {
  type = object({
    target_arn = string
  })
  default = null
}

variable "environment" {
  type = object({
    variables = map(string)
  })
  default = null
}

variable "tracing_config" {
  type = object({
    mode = string
  })
  default = null
}


variable "vpc_config" {
  type = object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  })
  default = null
}

variable "maximum_event_age_in_seconds" {
  type = number
  default = 60
}
variable "maximum_retry_attempts" {
  type = number
  default = 2
}
