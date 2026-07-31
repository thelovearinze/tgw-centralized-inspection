resource "aws_key_pair" "palo_alto" {
  key_name   = "${local.project_name}-key"
  public_key = file(pathexpand(var.ssh_public_key_path))

  tags = {
    Name = "${local.project_name}-key"
  }
}
resource "aws_network_interface" "palo_alto_data_a" {
  subnet_id         = aws_subnet.inspection_firewall_data_a.id
  private_ips       = ["172.23.30.10"]
  security_groups   = [aws_security_group.palo_alto_data.id]
  source_dest_check = false

  tags = {
    Name = "${local.project_name}-palo-alto-data-a"
    Role = "GWLB-Data"
  }
}
resource "aws_network_interface" "palo_alto_management_a" {
  subnet_id       = aws_subnet.inspection_management_a.id
  private_ips     = ["172.23.40.10"]
  security_groups = [aws_security_group.palo_alto_management.id]

  tags = {
    Name = "${local.project_name}-palo-alto-management-a"
    Role = "Management"
  }
}
resource "aws_eip" "palo_alto_management_a" {
  domain            = "vpc"
  network_interface = aws_network_interface.palo_alto_management_a.id

  depends_on = [
    aws_internet_gateway.inspection
  ]

  tags = {
    Name = "${local.project_name}-palo-alto-management-a-eip"
    Role = "Temporary-Lab-Management"
  }
}
resource "aws_instance" "palo_alto_a" {
  ami           = var.palo_alto_ami_id
  instance_type = var.palo_alto_instance_type
  key_name      = aws_key_pair.palo_alto.key_name

  network_interface {
    network_interface_id = aws_network_interface.palo_alto_data_a.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.palo_alto_management_a.id
    device_index         = 1
  }

  user_data = <<-EOF
    type=dhcp-client
    hostname=tgw-inspection-fw-a
    op-command-modes=mgmt-interface-swap
    plugin-op-commands=aws-gwlb-inspect:enable
    dhcp-send-hostname=no
    dhcp-send-client-id=no
    dhcp-accept-server-hostname=no
    dhcp-accept-server-domain=no
  EOF

  user_data_replace_on_change = true

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 60
    encrypted             = true
    delete_on_termination = true

    tags = {
      Name = "${local.project_name}-palo-alto-a-root"
    }
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "${local.project_name}-palo-alto-a"
    Role = "Inspection-Firewall"
  }
}