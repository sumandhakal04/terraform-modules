resource "aws_s3_bucket" "bucket-1" {
  bucket = var.bucket_name
  acl    = "private"
  lifecycle_rule {
    id = "bucket-1-lifecycle"
    enabled = true
    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning {
    enabled = true
  }

  force_destroy = true

  tags = {
    Name       = "${var.bucket_name}"
    Environment = "${var.environment}"
  }
}
