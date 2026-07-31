variable "aws_region" {
  description = "AWS Region where the lab will be deployed."
  type        = string
  default     = "eu-west-1"

  validation {
    condition     = var.aws_region == "eu-west-1"
    error_message = "This lab is currently approved only for eu-west-1."
  }
}
variable "palo_alto_ami_id" {
  description = "Verified Palo Alto VM-Series PAYG AMI subscribed through AWS Marketplace."
  type        = string
  default     = "ami-040ae7eff80a9cb8c"

  validation {
    condition     = can(regex("^ami-[0-9a-f]+$", var.palo_alto_ami_id))
    error_message = "The Palo Alto AMI ID must be a valid AMI identifier."
  }
}
variable "palo_alto_instance_type" {
  description = "EC2 instance type for the Palo Alto VM-Series lab firewall."
  type        = string
  default     = "m5.xlarge"

  validation {
    condition     = var.palo_alto_instance_type == "m5.xlarge"
    error_message = "This lab currently permits only the validated m5.xlarge instance type."
  }
}
variable "management_source_cidr" {
  description = "Public IPv4 CIDR permitted to manage the Palo Alto firewall."
  type        = string
  sensitive   = true

  validation {
    condition     = can(cidrhost(var.management_source_cidr, 0))
    error_message = "Management source must be a valid IPv4 CIDR."
  }
}
variable "ssh_public_key_path" {
  description = "Local path to the SSH public key registered with EC2."
  type        = string
  default     = "~/.ssh/tgw-inspection-key.pub"
}