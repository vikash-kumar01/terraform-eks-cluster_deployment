terraform {
   backend "s3" {
       bucket = "terraform-tfstate-devops001"
       region = "us-east-1"
       key    = "terraform.tfstate"
   }
}
