resource "aws_security_group" "palo_alto_management" {
  name        = "${local.project_name}-palo-alto-management-sg"
  description = "Restricts Palo Alto management access to the approved administrator CIDR"
  vpc_id      = aws_vpc.inspection.id

  ingress {
    description = "HTTPS management"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [var.management_source_cidr]
  }

  ingress {
    description = "SSH management"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.management_source_cidr]
  }

  egress {
    description = "Firewall licensing and update access"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name}-palo-alto-management-sg"
  }
}
resource "aws_security_group" "palo_alto_data" {
  name        = "${local.project_name}-palo-alto-data-sg"
  description = "Allows GWLB GENEVE traffic and target health checks"
  vpc_id      = aws_vpc.inspection.id

  ingress {
    description = "GWLB GENEVE encapsulation"
    protocol    = "udp"
    from_port   = 6081
    to_port     = 6081
    cidr_blocks = [local.vpc_cidrs.inspection]
  }

  ingress {
    description = "GWLB target health check"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = [local.vpc_cidrs.inspection]
  }

  egress {
    description = "Return inspected traffic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name}-palo-alto-data-sg"
  }
}