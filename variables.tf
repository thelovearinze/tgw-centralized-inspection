variable "aws_region" {
  description = "AWS Region where the lab will be deployed."
  type        = string
  default     = "eu-west-1"

  validation {
    condition     = var.aws_region == "eu-west-1"
    error_message = "This lab is currently approved only for eu-west-1."
  }
}