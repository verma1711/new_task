output "codebuild_project_name" {
  value = aws_codebuild_project.main.name
}

output "codebuild_role_arn" {
  value = aws_iam_role.codebuild_role.arn
}