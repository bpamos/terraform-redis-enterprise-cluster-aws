# random string for the bucket name ending (s3 buckets cant have the same name)
resource "random_string" "s3_bucket_name" {
  length = 8
  number = true
  special = false
  upper = false
}