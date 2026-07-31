resource "aws_subnet" "production_workload_a" {
  vpc_id            = aws_vpc.production.id
  cidr_block        = "172.20.10.0/24"
  availability_zone = local.availability_zones.az_a

  tags = {
    Name = "${local.project_name}-production-workload-a"
    Tier = "Workload"
  }
}
resource "aws_subnet" "production_workload_b" {
  vpc_id            = aws_vpc.production.id
  cidr_block        = "172.20.20.0/24"
  availability_zone = local.availability_zones.az_b

  tags = {
    Name = "${local.project_name}-production-workload-b"
    Tier = "Workload"
  }
}
resource "aws_subnet" "production_tgw_a" {
  vpc_id            = aws_vpc.production.id
  cidr_block        = "172.20.100.0/28"
  availability_zone = local.availability_zones.az_a

  tags = {
    Name = "${local.project_name}-production-tgw-a"
    Tier = "Transit"
  }
}
resource "aws_subnet" "production_tgw_b" {
  vpc_id            = aws_vpc.production.id
  cidr_block        = "172.20.100.16/28"
  availability_zone = local.availability_zones.az_b

  tags = {
    Name = "${local.project_name}-production-tgw-b"
    Tier = "Transit"
  }
}
resource "aws_subnet" "development_workload_a" {
  vpc_id            = aws_vpc.development.id
  cidr_block        = "172.21.10.0/24"
  availability_zone = local.availability_zones.az_a

  tags = {
    Name = "${local.project_name}-development-workload-a"
    Tier = "Workload"
  }
}
resource "aws_subnet" "development_workload_b" {
  vpc_id            = aws_vpc.development.id
  cidr_block        = "172.21.20.0/24"
  availability_zone = local.availability_zones.az_b

  tags = {
    Name = "${local.project_name}-development-workload-b"
    Tier = "Workload"
  }
}
resource "aws_subnet" "development_tgw_a" {
  vpc_id            = aws_vpc.development.id
  cidr_block        = "172.21.100.0/28"
  availability_zone = local.availability_zones.az_a

  tags = {
    Name = "${local.project_name}-development-tgw-a"
    Tier = "Transit"
  }
}
resource "aws_subnet" "development_tgw_b" {
  vpc_id            = aws_vpc.development.id
  cidr_block        = "172.21.100.16/28"
  availability_zone = local.availability_zones.az_b

  tags = {
    Name = "${local.project_name}-development-tgw-b"
    Tier = "Transit"
  }
}
resource "aws_subnet" "shared_services_a" {
  vpc_id            = aws_vpc.shared.id
  cidr_block        = "172.22.10.0/24"
  availability_zone = local.availability_zones.az_a

  tags = {
    Name = "${local.project_name}-shared-services-a"
    Tier = "Shared-Services"
  }
}
resource "aws_subnet" "shared_services_b" {
  vpc_id            = aws_vpc.shared.id
  cidr_block        = "172.22.20.0/24"
  availability_zone = local.availability_zones.az_b

  tags = {
    Name = "${local.project_name}-shared-services-b"
    Tier = "Shared-Services"
  }
}
resource "aws_subnet" "shared_tgw_a" {
  vpc_id            = aws_vpc.shared.id
  cidr_block        = "172.22.100.0/28"
  availability_zone = local.availability_zones.az_a

  tags = {
    Name = "${local.project_name}-shared-tgw-a"
    Tier = "Transit"
  }
}
resource "aws_subnet" "shared_tgw_b" {
  vpc_id            = aws_vpc.shared.id
  cidr_block        = "172.22.100.16/28"
  availability_zone = local.availability_zones.az_b

  tags = {
    Name = "${local.project_name}-shared-tgw-b"
    Tier = "Transit"
  }
}
resource "aws_subnet" "inspection_tgw_a" {
  vpc_id            = aws_vpc.inspection.id
  cidr_block        = "172.23.10.0/28"
  availability_zone = local.availability_zones.az_a

  tags = {
    Name = "${local.project_name}-inspection-tgw-a"
    Tier = "Transit"
  }
}
resource "aws_subnet" "inspection_tgw_b" {
  vpc_id            = aws_vpc.inspection.id
  cidr_block        = "172.23.10.16/28"
  availability_zone = local.availability_zones.az_b

  tags = {
    Name = "${local.project_name}-inspection-tgw-b"
    Tier = "Transit"
  }
}
resource "aws_subnet" "inspection_gwlbe_a" {
  vpc_id            = aws_vpc.inspection.id
  cidr_block        = "172.23.20.0/24"
  availability_zone = local.availability_zones.az_a

  tags = {
    Name = "${local.project_name}-inspection-gwlbe-a"
    Tier = "GWLB-Endpoint"
  }
}
resource "aws_subnet" "inspection_gwlbe_b" {
  vpc_id            = aws_vpc.inspection.id
  cidr_block        = "172.23.21.0/24"
  availability_zone = local.availability_zones.az_b

  tags = {
    Name = "${local.project_name}-inspection-gwlbe-b"
    Tier = "GWLB-Endpoint"
  }
}
resource "aws_subnet" "inspection_firewall_data_a" {
  vpc_id            = aws_vpc.inspection.id
  cidr_block        = "172.23.30.0/24"
  availability_zone = local.availability_zones.az_a

  tags = {
    Name = "${local.project_name}-inspection-firewall-data-a"
    Tier = "Firewall-Data"
  }
}
resource "aws_subnet" "inspection_firewall_data_b" {
  vpc_id            = aws_vpc.inspection.id
  cidr_block        = "172.23.31.0/24"
  availability_zone = local.availability_zones.az_b

  tags = {
    Name = "${local.project_name}-inspection-firewall-data-b"
    Tier = "Firewall-Data"
  }
}
resource "aws_subnet" "inspection_management_a" {
  vpc_id            = aws_vpc.inspection.id
  cidr_block        = "172.23.40.0/24"
  availability_zone = local.availability_zones.az_a

  tags = {
    Name = "${local.project_name}-inspection-management-a"
    Tier = "Firewall-Management"
  }
}
resource "aws_subnet" "inspection_management_b" {
  vpc_id            = aws_vpc.inspection.id
  cidr_block        = "172.23.41.0/24"
  availability_zone = local.availability_zones.az_b

  tags = {
    Name = "${local.project_name}-inspection-management-b"
    Tier = "Firewall-Management"
  }
}
resource "aws_subnet" "inspection_public_egress_a" {
  vpc_id            = aws_vpc.inspection.id
  cidr_block        = "172.23.50.0/24"
  availability_zone = local.availability_zones.az_a

  tags = {
    Name = "${local.project_name}-inspection-public-egress-a"
    Tier = "Public-Egress"
  }
}
resource "aws_subnet" "inspection_public_egress_b" {
  vpc_id            = aws_vpc.inspection.id
  cidr_block        = "172.23.51.0/24"
  availability_zone = local.availability_zones.az_b

  tags = {
    Name = "${local.project_name}-inspection-public-egress-b"
    Tier = "Public-Egress"
  }
}