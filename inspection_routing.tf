resource "aws_route_table" "inspection_tgw_a" {
  vpc_id = aws_vpc.inspection.id

  tags = {
    Name = "${local.project_name}-inspection-tgw-a-rt"
    Role = "Pre-Firewall"
  }
}
resource "aws_route" "inspection_tgw_a_to_gwlbe" {
  route_table_id         = aws_route_table.inspection_tgw_a.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = aws_vpc_endpoint.inspection_a.id
}
resource "aws_route_table_association" "inspection_tgw_a" {
  subnet_id      = aws_subnet.inspection_tgw_a.id
  route_table_id = aws_route_table.inspection_tgw_a.id
}
resource "aws_route_table" "inspection_gwlbe_a" {
  vpc_id = aws_vpc.inspection.id

  tags = {
    Name = "${local.project_name}-inspection-gwlbe-a-rt"
    Role = "Post-Firewall"
  }
}
resource "aws_route" "inspection_gwlbe_a_to_production" {
  route_table_id         = aws_route_table.inspection_gwlbe_a.id
  destination_cidr_block = local.vpc_cidrs.production
  transit_gateway_id     = aws_ec2_transit_gateway.core.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.inspection
  ]
}
resource "aws_route" "inspection_gwlbe_a_to_development" {
  route_table_id         = aws_route_table.inspection_gwlbe_a.id
  destination_cidr_block = local.vpc_cidrs.development
  transit_gateway_id     = aws_ec2_transit_gateway.core.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.inspection
  ]
}
resource "aws_route" "inspection_gwlbe_a_to_shared" {
  route_table_id         = aws_route_table.inspection_gwlbe_a.id
  destination_cidr_block = local.vpc_cidrs.shared
  transit_gateway_id     = aws_ec2_transit_gateway.core.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.inspection
  ]
}
resource "aws_route_table_association" "inspection_gwlbe_a" {
  subnet_id      = aws_subnet.inspection_gwlbe_a.id
  route_table_id = aws_route_table.inspection_gwlbe_a.id
}