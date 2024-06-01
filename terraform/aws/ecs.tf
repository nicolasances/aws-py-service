########################################################
# 1. Task Definition
########################################################
resource "aws_ecs_task_definition" "service_task_def" {
  family = local.toto_microservice_name
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = format("arn:aws:iam::%s:role/toto-ecs-task-execution-role-%s", var.aws_account_id, var.toto_environment)
  task_role_arn = format("arn:aws:iam::%s:role/toto-ecs-task-role-%s", var.aws_account_id, var.toto_environment)
  cpu = 1024
  memory = 2048
  network_mode = "awsvpc"
  container_definitions = jsonencode([
    {
      name      = local.toto_microservice_name
      image     = format("%s.dkr.ecr.eu-west-1.amazonaws.com/aws-py-service:%s", var.aws_account_id, var.container_image_tag)
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]
    }
  ])
}

########################################################
# 2. Service
########################################################
resource "aws_ecs_service" "service" {
  name = "toto-py-service"
  cluster = format("arn:aws:ecs:eu-west-1:%s:cluster/toto-%s-cluster", var.aws_account_id, var.toto_environment)
  task_definition = aws_ecs_task_definition.toto_aws_py_taskdef.arn
  desired_count = 1
  capacity_provider_strategy {
    base = 0
    capacity_provider = "FARGATE"
    weight = 1
  }
}