## S3 Outputs ##
output "bucket_arn" {
  value = module.website-bucket.bucket_arn
}

output "bucket_id" {
  description = "ID of the bucket"
  value       = module.website-bucket.bucket_id
}

output "bucket_regional_domain_name" {
  description = "The bucket domain name including the region name."
  value       = module.website-bucket.bucket_regional_domain_name    
}

## ACM Outputs ##
output "acm_arn" {
  value = module.website-acm-certificate.acm_arn
}

## CDN Outputs ##
output "cdn_domain_name" {
  value = module.website-cdn.cdn_name
}

## DynamoDB Outputs ##
output "table_arn" {
  value = module.website-dynamodb
}

## Lambda Outputs ##
output "lambda_arn" {
  value = module.website-lambda.lambda_arn
}
output "lambda_invoke_arn" {
  value = module.website-lambda.lambda_invoke_arn
}
output "lambda_function_name" {
  value = module.website-lambda.lambda_function_name
}