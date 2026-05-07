terraform {
  backend "s3" {
    key = "devops-ec2-based/ec2.tfstate"
    bucket = "devops-tf-states-bucket"
    region = "us-east-1"
  }
}