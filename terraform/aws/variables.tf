########################################################
# 1. AWS Core Variables
########################################################
variable "aws_access_key" {
  description = "Access Key"
  type = string
  sensitive = true
}

variable "aws_secret_access_key" {
  description = "Secret Access Key"
  type = string
  sensitive = true
}

variable "aws_account_id" {
  description = "Account ID"
  type = string
}

########################################################
# 2. Toto Environment & Core Variables
########################################################
variable "toto_environment" {
  description = "Toto Environment (dev, prod, etc..)"
  type = string
}

########################################################
# 3. Environment Core info
#    These need to be created by toto-aws-terra,
#    when creating the repo, not by the service itself.
########################################################
variable "toto_vpc_id" {
  description = "ID of the VPC that host Toto Services"
  type = string
}
variable "ecs_subnet_1" {
  description = "ARN of one of the two subnets to be used"
  type = string
}
variable "ecs_subnet_2" {
  description = "ARN of the other of the two subnets to be used"
  type = string
}
variable "ecs_security_group" {
  description = "value"
  type = string
}
variable "alb_listener_arn" {
  description = "Listener ARN of the ALB"
  type = string
}

########################################################
# 4. Microservice Variables
########################################################
variable "container_image_tag" {
  description = "Tag of the Image that needs to be deployed"
  type = string
}