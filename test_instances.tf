data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_security_group" "production_eice" {
  name        = "${local.project_name}-production-eice-sg"
  description = "Allows EC2 Instance Connect Endpoint to reach Production test instances"
  vpc_id      = aws_vpc.production.id

  egress {
    description = "SSH to Production VPC instances"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [local.vpc_cidrs.production]
  }

  tags = {
    Name = "${local.project_name}-production-eice-sg"
  }
}
resource "aws_security_group" "production_test" {
  name        = "${local.project_name}-production-test-sg"
  description = "Controls access to the Production test instance"
  vpc_id      = aws_vpc.production.id

  ingress {
    description     = "SSH through Production EC2 Instance Connect Endpoint"
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    security_groups = [aws_security_group.production_eice.id]
  }

  ingress {
    description = "ICMP from Development for inspection testing"
    protocol    = "icmp"
    from_port   = -1
    to_port     = -1
    cidr_blocks = [local.vpc_cidrs.development]
  }

  egress {
    description = "Allow return and test traffic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name}-production-test-sg"
  }
}
resource "aws_ec2_instance_connect_endpoint" "production" {
  subnet_id          = aws_subnet.production_workload_a.id
  security_group_ids = [aws_security_group.production_eice.id]
  preserve_client_ip = false

  tags = {
    Name = "${local.project_name}-production-eice"
  }
}
resource "aws_instance" "production_test" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.production_workload_a.id
  private_ip                  = "172.20.10.10"
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.production_test.id]
  key_name                    = aws_key_pair.palo_alto.key_name

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    encrypted             = true
    delete_on_termination = true

    tags = {
      Name = "${local.project_name}-production-test-root"
    }
  }

  tags = {
    Name = "${local.project_name}-production-test"
    Tier = "Production"
  }
}
resource "aws_security_group" "development_eice" {
  name        = "${local.project_name}-development-eice-sg"
  description = "Allows EC2 Instance Connect Endpoint to reach Development test instances"
  vpc_id      = aws_vpc.development.id

  egress {
    description = "SSH to Development VPC instances"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [local.vpc_cidrs.development]
  }

  tags = {
    Name = "${local.project_name}-development-eice-sg"
  }
}
resource "aws_security_group" "development_test" {
  name        = "${local.project_name}-development-test-sg"
  description = "Controls access to the Development test instance"
  vpc_id      = aws_vpc.development.id

  ingress {
    description     = "SSH through Development EC2 Instance Connect Endpoint"
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    security_groups = [aws_security_group.development_eice.id]
  }

  ingress {
    description = "ICMP from Production for inspection testing"
    protocol    = "icmp"
    from_port   = -1
    to_port     = -1
    cidr_blocks = [local.vpc_cidrs.production]
  }

  egress {
    description = "Allow return and test traffic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name}-development-test-sg"
  }
}
resource "aws_ec2_instance_connect_endpoint" "development" {
  subnet_id          = aws_subnet.development_workload_a.id
  security_group_ids = [aws_security_group.development_eice.id]
  preserve_client_ip = false

  tags = {
    Name = "${local.project_name}-development-eice"
  }
}
resource "aws_instance" "development_test" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.development_workload_a.id
  private_ip                  = "172.21.10.10"
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.development_test.id]
  key_name                    = aws_key_pair.palo_alto.key_name

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    encrypted             = true
    delete_on_termination = true

    tags = {
      Name = "${local.project_name}-development-test-root"
    }
  }

  tags = {
    Name = "${local.project_name}-development-test"
    Tier = "Development"
  }
}