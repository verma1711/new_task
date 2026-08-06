output "autoscaling_group_name" {
  value = aws_autoscaling_group.main.name
}

output "launch_template_id" {
  value = aws_launch_template.main.id
}

output "ec2_role_name" {
  value = aws_iam_role.ec2_role.name
}