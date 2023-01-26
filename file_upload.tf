resource "aws_s3_object" "raw-database" {
  bucket = "${var.project_name}-bronze-${var.environment}"
  key    = "./raw-database/title_basics.csv"
  source = "./raw-database/title_basics.csv"
  etag   = filemd5("raw-database/title_basics.csv")
  depends_on = [aws_s3_bucket.buckets-natalia]
}