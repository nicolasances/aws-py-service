########################################################
# 1. Route 53 Hosted Zone A Record
########################################################
resource "aws_route53_record" "dns_record" {
  zone_id = var.route53_zone_id
  name = "api.dev.toto.aws.to7o.com"
  type = "A"

  alias {
    name = var.alb_dns_name
    zone_id = var.alb_zone_id
    evaluate_target_health = false
  }
}