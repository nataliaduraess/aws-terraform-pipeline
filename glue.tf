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
    script_location = "s3://data-platform-scripts-prod/jobs/jobGlue.py"
    python_version  = "3"
  }
}  

#resource "aws_glue_crawler" "glue_crawler_1" {
  #database_name = aws_glue_catalog_database.example.name
 #name          = "example"
  #role          = aws_iam_role.example.arn

  #s3_target {
    #path = "s3://data-platform-gold-prod/consume-data/"
  #}
#}