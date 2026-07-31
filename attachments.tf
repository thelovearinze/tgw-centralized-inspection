resource "aws_ec2_transit_gateway_vpc_attachment" "production" {
  transit_gateway_id = aws_ec2_transit_gateway.core.id
  vpc_id             = aws_vpc.production.id

  subnet_ids = [
    aws_subnet.production_tgw_a.id,
    aws_subnet.production_tgw_b.id
  ]

  dns_support                                     = "enable"
  ipv6_support                                    = "disable"
  appliance_mode_support                          = "disable"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name = "${local.project_name}-production-attachment"
    Tier = "Production"
  }
}
resource "aws_ec2_transit_gateway_vpc_attachment" "development" {
  transit_gateway_id = aws_ec2_transit_gateway.core.id
  vpc_id             = aws_vpc.development.id

  subnet_ids = [
    aws_subnet.development_tgw_a.id,
    aws_subnet.development_tgw_b.id
  ]

  dns_support                                     = "enable"
  ipv6_support                                    = "disable"
  appliance_mode_support                          = "disable"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name = "${local.project_name}-development-attachment"
    Tier = "Development"
  }
}
resource "aws_ec2_transit_gateway_vpc_attachment" "shared" {
  transit_gateway_id = aws_ec2_transit_gateway.core.id
  vpc_id             = aws_vpc.shared.id

  subnet_ids = [
    aws_subnet.shared_tgw_a.id,
    aws_subnet.shared_tgw_b.id
  ]

  dns_support                                     = "enable"
  ipv6_support                                    = "disable"
  appliance_mode_support                          = "disable"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name = "${local.project_name}-shared-attachment"
    Tier = "Shared"
  }
}
resource "aws_ec2_transit_gateway_vpc_attachment" "inspection" {
  transit_gateway_id = aws_ec2_transit_gateway.core.id
  vpc_id             = aws_vpc.inspection.id

  subnet_ids = [
    aws_subnet.inspection_tgw_a.id,
    aws_subnet.inspection_tgw_b.id
  ]

  dns_support                                     = "enable"
  ipv6_support                                    = "disable"
  appliance_mode_support                          = "enable"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name = "${local.project_name}-inspection-attachment"
    Tier = "Security"
  }
}
