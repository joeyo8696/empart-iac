resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name = "${var.ecs_task_definition_name}-logs"

  tags = {
    Environment = var.environment
    Application = var.ecs_task_definition_name
  }
}
