output "bucket_name" {
  description = "Bucket name for our static website hosting"
  value = module.home_cadillacs_dinos_hosting.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 Static Website hosting endpoint"
  value = module.home_cadillacs_dinos_hosting.website_endpoint
}

output "cloudfront_url" {
  description = "The Cloudfront Distribution Domain Name"
  value = module.home_cadillacs_dinos_hosting.domain_name
}