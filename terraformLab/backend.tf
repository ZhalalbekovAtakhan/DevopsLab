terraform {
  backend "s3" {
    bucket = "terraform-state-bucket1"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
