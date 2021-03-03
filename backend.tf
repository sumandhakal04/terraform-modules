terraform {
  backend "s3" {
    bucket = var.terraform_state_files_bucket
    key    = "tf-state-files"
    region = var.global_region
  }
}