##############################################################
# 1. Target Groups
#    This section creates the Target Group for this service.
##############################################################
resource "aws_lb_target_group" "service_tg" {
  name = format("%s-tg-%s", local.toto_microservice_name, var.toto_environment)
  port = 8080
  protocol = "HTTP"
  vpc_id = var.toto_vpc_id
  target_type = "ip"
}