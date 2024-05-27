########################################################
# 1. Task Definition
########################################################
resource "aws_ecs_task_definition" "toto_aws_py_taskdef" {
  family = "toto-aws-py"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = format("arn:aws:iam::%s:role/toto-ecs-task-execution-role-%s", var.aws_account_id, var.toto_environment)
  task_role_arn = format("arn:aws:iam::%s:role/toto-ecs-task-role-%s", var.aws_account_id, var.toto_environment)
  cpu = 1024
  memory = 2048
  network_mode = "awsvpc"
  container_definitions = jsonencode([
    {
      name      = "toto-aws-py"
      image     = format("%s.dkr.ecr.eu-west-1.amazonaws.com/aws-py-service", var.aws_account_id)
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