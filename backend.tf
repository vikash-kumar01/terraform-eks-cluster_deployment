terraform {
  backend "s3" {
    bucket         = "terraform-tfstate-devops001"
    key            = "aws_eks_terraform.tfstate"
    region         = "us-east-1"
    #dynamodb_table = "eks_tfstate"
    #profile        = "aws_creds"
  }
}


