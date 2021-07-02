# Resource: aws_s3_bucket (Provides a S3 bucket resource)
# S3 bucket for storing memtier output files.

resource "aws_s3_bucket" "mybucket" {
  bucket = format("%s-s3-bucket-%s", var.base_name, random_string.s3_bucket_name.result)
  acl    = "public-read-write"

  tags = {
    Name = format("%s-s3-bucket-%s", var.base_name, random_string.s3_bucket_name.result),
    Owner = var.owner
  }
}