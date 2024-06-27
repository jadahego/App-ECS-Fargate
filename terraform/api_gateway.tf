# apigateway.tf

# Recursos de API Gateway
resource "aws_api_gateway_rest_api" "voting_api" {
  name        = "Voting API"
  description = "API for the Voting application"
}

resource "aws_api_gateway_resource" "vote" {
  rest_api_id = aws_api_gateway_rest_api.voting_api.id
  parent_id   = aws_api_gateway_rest_api.voting_api.root_resource_id
  path_part   = "vote"
}

resource "aws_api_gateway_method" "vote_post" {
  rest_api_id   = aws_api_gateway_rest_api.voting_api.id
  resource_id   = aws_api_gateway_resource.vote.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "vote_get" {
  rest_api_id   = aws_api_gateway_rest_api.voting_api.id
  resource_id   = aws_api_gateway_resource.vote.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "vote_post" {
  rest_api_id             = aws_api_gateway_rest_api.voting_api.id
  resource_id             = aws_api_gateway_resource.vote.id
  http_method             = aws_api_gateway_method.vote_post.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = aws_ecs_service.voting_service.endpoint
}

resource "aws_api_gateway_integration" "vote_get" {
  rest_api_id             = aws_api_gateway_rest_api.voting_api.id
  resource_id             = aws_api_gateway_resource.vote.id
  http_method             = aws_api_gateway_method.vote_get.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = aws_ecs_service.voting_service.endpoint
}

resource "aws_api_gateway_deployment" "voting_api_deployment" {
  depends_on = [
    aws_api_gateway_integration.vote_post,
    aws_api_gateway_integration.vote_get,
  ]
  rest_api_id = aws_api_gateway_rest_api.voting_api.id
  stage_name  = "v2"
}

