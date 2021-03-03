data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_acm_certificate" "amazon_issued" {
  domain   = "tf.example.com"
  statuses = ["ISSUED"]
}