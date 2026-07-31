locals {
  project_name = "tgw-centralized-inspection"
  environment  = "lab"

  common_tags = {
    Project     = local.project_name
    Environment = local.environment
    ManagedBy   = "Terraform"
    Owner       = "Love-Arinze"
    DeleteAfter = "2026-08-07"
  }
}