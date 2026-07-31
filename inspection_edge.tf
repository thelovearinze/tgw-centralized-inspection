resource "aws_internet_gateway" "inspection" {
  vpc_id = aws_vpc.inspection.id

  tags = {
    Name = "${local.project_name}-inspection-igw"
  }
}
resource "aws_route_table" "inspection_management" {
  vpc_id = aws_vpc.inspection.id

  tags = {
    Name = "${local.project_name}-inspection-management-rt"
    Tier = "Firewall-Management"
  }
}
resource "aws_route" "inspection_management_internet" {
  route_table_id         = aws_route_table.inspection_management.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.inspection.id
}
resource "aws_route_table_association" "inspection_management_a" {
  subnet_id      = aws_subnet.inspection_management_a.id
  route_table_id = aws_route_table.inspection_management.id
}
resource "aws_route_table_association" "inspection_management_b" {
  subnet_id      = aws_subnet.inspection_management_b.id
  route_table_id = aws_route_table.inspection_management.id
}