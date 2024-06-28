terraform {
  backend "s3" {
    bucket = "bbog-ca-tf-states"
    key    = "jdhg_ecs_fargate.tfstate"
    region = "us-east-1"
  }
}
