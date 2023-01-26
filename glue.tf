resource "aws_iam_role" "glue_job" {
  name               = "${var.project_name}-${var.environment}-glue-job-role"
  path               = "/"
  description        = "Provides write permissions to CloudWatch Logs and S3 Full Access"
  assume_role_policy = file("permissions/role_glueJobs.json")
}
