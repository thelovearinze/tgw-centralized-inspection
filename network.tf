locals {
  availability_zones = {
    az_a = "eu-west-1a"
    az_b = "eu-west-1b"
  }

  vpc_cidrs = {
    production  = "172.20.0.0/16"
    development = "172.21.0.0/16"
    shared      = "172.22.0.0/16"
    inspection  = "172.23.0.0/16"
  }

  on_premises_cidr = "172.24.0.0/16"
}
resource "aws_vpc" "production" {
  cidr_block           = local.vpc_cidrs.production
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.project_name}-production-vpc"
    Tier = "Production"
  }
}
resource "aws_vpc" "development" {
  cidr_block           = local.vpc_cidrs.development
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.project_name}-development-vpc"
    Tier = "Development"
  }
}
resource "aws_vpc" "shared" {
  cidr_block           = local.vpc_cidrs.shared
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.project_name}-shared-vpc"
    Tier = "Shared"
  }
}
resource "aws_vpc" "inspection" {
  cidr_block           = local.vpc_cidrs.inspection
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.project_name}-inspection-vpc"
    Tier = "Security"
  }
}