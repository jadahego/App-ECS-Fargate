
output "alb_hostname" {
  value = "${aws_alb.alb-jdhg.dns_name}:3000"
}
