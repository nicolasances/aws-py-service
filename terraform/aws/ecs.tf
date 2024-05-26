########################################################
# 1. Task Definition
########################################################
resource "aws_ecs_task_definition" "toto_aws_py_taskdef" {
  family = "toto-aws-py"
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([
    {
      name      = "toto-aws-py"
      image     = "300889533047.dkr.ecr.eu-west-1.amazonaws.com/aws-py-service"
      cpu       = 1
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}