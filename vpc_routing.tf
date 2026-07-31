resource "aws_route_table" "production_workload" {
  vpc_id = aws_vpc.production.id

  tags = {
    Name = "${local.project_name}-production-workload-rt"
    Tier = "Workload"
  }
}
resource "aws_route" "production_to_development" {
  route_table_id         = aws_route_table.production_workload.id
  destination_cidr_block = local.vpc_cidrs.development
  transit_gateway_id     = aws_ec2_transit_gateway.core.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.production
  ]
}
resource "aws_route" "production_to_shared" {
  route_table_id         = aws_route_table.production_workload.id
  destination_cidr_block = local.vpc_cidrs.shared
  transit_gateway_id     = aws_ec2_transit_gateway.core.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.production
  ]
}
resource "aws_route" "production_to_on_premises" {
  route_table_id         = aws_route_table.production_workload.id
  destination_cidr_block = local.on_premises_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.core.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.production
  ]
}
resource "aws_route_table_association" "production_workload_a" {
  subnet_id      = aws_subnet.production_workload_a.id
  route_table_id = aws_route_table.production_workload.id
}
resource "aws_route_table_association" "production_workload_b" {
  subnet_id      = aws_subnet.production_workload_b.id
  route_table_id = aws_route_table.production_workload.id
}
resource "aws_route_table" "development_workload" {
  vpc_id = aws_vpc.development.id

  tags = {
    Name = "${local.project_name}-development-workload-rt"
    Tier = "Workload"
  }
}
resource "aws_route" "development_to_production" {
  route_table_id         = aws_route_table.development_workload.id
  destination_cidr_block = local.vpc_cidrs.production
  transit_gateway_id     = aws_ec2_transit_gateway.core.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.development
  ]
}
resource "aws_route" "development_to_shared" {
  route_table_id         = aws_route_table.development_workload.id
  destination_cidr_block = local.vpc_cidrs.shared
  transit_gateway_id     = aws_ec2_transit_gateway.core.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.development
  ]
}
resource "aws_route" "development_to_on_premises" {
  route_table_id         = aws_route_table.development_workload.id
  destination_cidr_block = local.on_premises_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.core.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.development
  ]
}
resource "aws_route_table_association" "development_workload_a" {
  subnet_id      = aws_subnet.development_workload_a.id
  route_table_id = aws_route_table.development_workload.id
}
resource "aws_route_table_association" "development_workload_b" {
  subnet_id      = aws_subnet.development_workload_b.id
  route_table_id = aws_route_table.development_workload.id
}
resource "aws_route_table" "shared_services" {
  vpc_id = aws_vpc.shared.id

  tags = {
    Name = "${local.project_name}-shared-services-rt"
    Tier = "Shared-Services"
  }
}
resource "aws_route" "shared_to_production" {
  route_table_id         = aws_route_table.shared_services.id
  destination_cidr_block = local.vpc_cidrs.production
  transit_gateway_id     = aws_ec2_transit_gateway.core.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.shared
  ]
}
resource "aws_route" "shared_to_development" {
  route_table_id         = aws_route_table.shared_services.id
  destination_cidr_block = local.vpc_cidrs.development
  transit_gateway_id     = aws_ec2_transit_gateway.core.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.shared
  ]
}
resource "aws_route" "shared_to_on_premises" {
  route_table_id         = aws_route_table.shared_services.id
  destination_cidr_block = local.on_premises_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.core.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.shared
  ]
}
resource "aws_route_table_association" "shared_services_a" {
  subnet_id      = aws_subnet.shared_services_a.id
  route_table_id = aws_route_table.shared_services.id
}
resource "aws_route_table_association" "shared_services_b" {
  subnet_id      = aws_subnet.shared_services_b.id
  route_table_id = aws_route_table.shared_services.id
}