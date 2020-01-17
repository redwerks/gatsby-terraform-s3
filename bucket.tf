
resource "aws_s3_bucket" "site_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"
  tags   = var.tags
  website {
    error_document = "404.html"
    index_document = "index.html"
  }
}
