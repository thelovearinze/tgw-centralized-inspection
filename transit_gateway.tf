resource "aws_ec2_transit_gateway" "core" {
  description                     = "Central transit hub for the inspection lab"
  amazon_side_asn                 = 64512
  auto_accept_shared_attachments  = "disable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  dns_support                     = "enable"
  vpn_ecmp_support                = "enable"
  multicast_support               = "disable"

  tags = {
    Name = "${local.project_name}-tgw"
  }
}