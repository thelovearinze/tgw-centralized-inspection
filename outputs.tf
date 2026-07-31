output "transit_gateway_id" {
  description = "ID of the central Transit Gateway."
  value       = aws_ec2_transit_gateway.core.id
}
output "transit_gateway_attachment_ids" {
  description = "Transit Gateway attachment IDs by VPC."
  value = {
    production  = aws_ec2_transit_gateway_vpc_attachment.production.id
    development = aws_ec2_transit_gateway_vpc_attachment.development.id
    shared      = aws_ec2_transit_gateway_vpc_attachment.shared.id
    inspection  = aws_ec2_transit_gateway_vpc_attachment.inspection.id
  }
}
output "transit_gateway_route_table_ids" {
  description = "Transit Gateway route-table IDs by role."
  value = {
    spoke      = aws_ec2_transit_gateway_route_table.spoke.id
    inspection = aws_ec2_transit_gateway_route_table.inspection.id
    hybrid     = aws_ec2_transit_gateway_route_table.hybrid.id
  }
}
output "vpc_ids" {
  description = "VPC IDs by environment."
  value = {
    production  = aws_vpc.production.id
    development = aws_vpc.development.id
    shared      = aws_vpc.shared.id
    inspection  = aws_vpc.inspection.id
  }
}
