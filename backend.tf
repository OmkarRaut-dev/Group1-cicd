terraform {
  backend "s3" {
    bucket         = "talent-academy-tf-by-omkar"
    key            = "talent-academy/bluegreendeploy/terraform.tfstates"
    region         = "eu-west-1"
    dynamodb_table = "terraform-lock"
  }
}