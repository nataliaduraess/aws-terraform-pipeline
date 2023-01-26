resource "aws_iam_role" "glue_job" {
  name               = "${var.project_name}-${var.environment}-glue-job-role"
  path               = "/"
  description        = "Provides write permissions to CloudWatch Logs and S3 Full Access"
  assume_role_policy = file("permissions/role_glueJobs.json")
}

resource "aws_iam_policy" "glue_job_policy" {
  name        = "${var.project_name}-${var.environment}-glue-job-policy"
  path        = "/"
  description = "Provides write permissions to CloudWatch Logs and S3 Full Access"
  policy      = file("permissions/policy_glueJobs.json")
}

resource "aws_glue_job" "glue_job" {
  name              = "jobGlue"
  role_arn          = aws_iam_role.glue_job.arn
  glue_version      = "3.0"
  worker_type       = "Standard"
  number_of_workers = 5
  timeout           = 5

  command {
    script_location = "${var.project_name}-scripts-${var.environment}/jobs/jobGlue.py"
    python_version  = "3"
  }
}  