output "alb_url" {
  value = "http://${module.alb.alb_dns_name}"
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "autoscaling_group_name" {
  value = module.asg.autoscaling_group_name
}