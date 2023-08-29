##Statefile is stored in a manually created bucket for testing purposes.
terraform {
  backend "s3" {
    #bucket  = "website-statefiles"
    key     = "s3/website/terraform.tfstate"
    region  = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "website-bucket" {
  source = "github.com/bertei/CloudResume-TerraformModules.git//s3"
  #source  = "/Users/bernardo.teisceira/Desktop/Personal-repos/CloudResume-TerraformModules/s3"

  bucket_name = "bernatei-website"
}