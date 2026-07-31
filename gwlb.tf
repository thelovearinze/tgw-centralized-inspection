resource "aws_lb" "inspection" {
  name               = "tgw-inspection-gwlb"
  load_balancer_type = "gateway"
  subnets            = [aws_subnet.inspection_firewall_data_a.id]

  enable_cross_zone_load_balancing = false

  tags = {
    Name = "${local.project_name}-gwlb"
  }
}
resource "aws_lb_target_group" "palo_alto" {
  name        = "tgw-inspection-palo-alto"
  port        = 6081
  protocol    = "GENEVE"
  target_type = "instance"
  vpc_id      = aws_vpc.inspection.id

  health_check {
    enabled             = true
    protocol            = "TCP"
    port                = "80"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  deregistration_delay = 30

  tags = {
    Name = "${local.project_name}-palo-alto-tg"
  }
}
resource "aws_lb_target_group_attachment" "palo_alto_a" {
  target_group_arn = aws_lb_target_group.palo_alto.arn
  target_id        = aws_instance.palo_alto_a.id
  port             = 6081
}
resource "aws_lb_listener" "inspection" {
  load_balancer_arn = aws_lb.inspection.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.palo_alto.arn
  }
}
resource "aws_vpc_endpoint_service" "inspection" {
  acceptance_required        = false
  gateway_load_balancer_arns = [aws_lb.inspection.arn]

  tags = {
    Name = "${local.project_name}-gwlb-endpoint-service"
  }
}
resource "aws_vpc_endpoint" "inspection_a" {
  vpc_id            = aws_vpc.inspection.id
  service_name      = aws_vpc_endpoint_service.inspection.service_name
  vpc_endpoint_type = "GatewayLoadBalancer"
  subnet_ids        = [aws_subnet.inspection_gwlbe_a.id]

  tags = {
    Name = "${local.project_name}-gwlbe-a"
  }
}