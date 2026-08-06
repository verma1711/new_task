output "pipeline_name" {
  value = aws_codepipeline.main.name
}

output "github_connection_arn" {
  value = aws_codestarconnections_connection.github.arn
}

output "artifact_bucket_name" {
  value = aws_s3_bucket.artifacts.bucket
}