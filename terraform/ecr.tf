# ecr.tf
resource "aws_ecr_repository" "cb-app" {
  name = "cb-app"
}
