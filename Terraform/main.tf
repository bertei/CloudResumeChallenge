##Statefile is stored in a manually created bucket for testing purposes.
terraform {
  backend "s3" {
    bucket  = "website-statefiles"
    key     = "terraform.tfstate"
    region  = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "website-bucket" {
  source = "github.com/bertei/CloudResume-TerraformModules.git//s3"

  bucket_name = "bernatei-website"
}

module "website-acm-certificate" {
  source = "github.com/bertei/CloudResume-TerraformModules.git//acm"
}

module "website-cdn" {
  source = "github.com/bertei/CloudResume-TerraformModules.git//cdn"

  ##Variables defined by outputs
  domain_name = module.website-bucket.bucket_regional_domain_name
  bucket_id   = module.website-bucket.bucket_id
  bucket_arn  = module.website-bucket.bucket_arn
  acm_arn     = module.website-acm-certificate.acm_arn

  custom_error_response = [
    {
      error_code         = 403
      response_code      = 403
      response_page_path = "/error.html"
    },
    {
      error_code         = 404
      response_code      = 404
      response_page_path = "/error.html"
    }
  ]

  #depends_on = [
  #  module.website-bucket,
  #  module.website-acm-certificate
  #]
}

module "website-dynamodb" {
  source  = "github.com/bertei/CloudResume-TerraformModules.git//dynamodb"

  table_name = "ViewCounter"
}

module "website-lambda" {
  source  = "github.com/bertei/CloudResume-TerraformModules.git//lambda"

  lambda_function_name = "Website-Lambda"
  lambda_role_name     = "ViewCounter-Role"

  ##Variables defined by outputs
  table_arn            = module.website-dynamodb.table_arn
}

module "website-apigw" {
  source  = "github.com/bertei/CloudResume-TerraformModules.git//apigw"

  apigw_name  = "Website-API"

  ##Variable defined by outputs
  lambda_invoke_arn    = module.website-lambda.lambda_invoke_arn
  lambda_function_name = module.website-lambda.lambda_function_name

  depends_on = [ 
    module.website-lambda
   ]
}

#Used for testing purposes locally. Not using it online because i purchased/created the HZ via console.
#I won't import it. But i was able to create the A record hardcoding the zone_id. Not uploading it for security purposes.
#module "website-r53" {
#  source = "/Users/bernardo.teisceira/Desktop/Personal-repos/CloudResume-TerraformModules/r53"
#
#  cdn_name = module.website-cdn.cdn_name
#}

