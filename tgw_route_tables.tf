resource "aws_ec2_transit_gateway_route_table" "spoke" {
  transit_gateway_id = aws_ec2_transit_gateway.core.id

  tags = {
    Name = "${local.project_name}-spoke-tgw-rt"
    Role = "Pre-Inspection"
  }
}
resource "aws_ec2_transit_gateway_route_table" "inspection" {
  transit_gateway_id = aws_ec2_transit_gateway.core.id

  tags = {
    Name = "${local.project_name}-inspection-tgw-rt"
    Role = "Post-Inspection"
  }
}
resource "aws_ec2_transit_gateway_route_table" "hybrid" {
  transit_gateway_id = aws_ec2_transit_gateway.core.id

  tags = {
    Name = "${local.project_name}-hybrid-tgw-rt"
    Role = "Hybrid-Ingress"
  }
}
resource "aws_ec2_transit_gateway_route_table_association" "production_spoke" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.production.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke.id
}
resource "aws_ec2_transit_gateway_route_table_association" "development_spoke" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.development.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke.id
}
resource "aws_ec2_transit_gateway_route_table_association" "shared_spoke" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shared.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke.id
}
resource "aws_ec2_transit_gateway_route_table_association" "inspection" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.inspection.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inspection.id
}
resource "aws_ec2_transit_gateway_route_table_propagation" "production_to_inspection" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.production.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inspection.id
}
resource "aws_ec2_transit_gateway_route_table_propagation" "development_to_inspection" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.development.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inspection.id
}
resource "aws_ec2_transit_gateway_route_table_propagation" "shared_to_inspection" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shared.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inspection.id
}
resource "aws_ec2_transit_gateway_route" "spoke_to_inspection" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.inspection.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke.id
}