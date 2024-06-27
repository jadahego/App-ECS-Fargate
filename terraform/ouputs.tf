# outputs.tf

output "alb_hostname" {
  value = aws_alb.alb-jdhg.dns_name
}


output "api_url" {
  value = aws_api_gateway_deployment.voting_api_deployment.invoke_url
}

