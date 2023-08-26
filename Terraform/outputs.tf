output "bucket_arn" {
  value = module.website-bucket.bucket_arn
}

output "bucket_domain" {
  description = "Domain name of the bucket"
  value       = module.website-bucket.bucket_domain
}