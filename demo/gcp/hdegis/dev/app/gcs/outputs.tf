output "bucket_names" {
  description = "Created bucket names"
  value       = { for bucket in var.buckets : bucket.name => google_storage_bucket.buckets[bucket.name].name }
}

output "bucket_urls" {
  description = "Bucket URLs"
  value       = { for bucket in var.buckets : bucket.name => google_storage_bucket.buckets[bucket.name].url }
}

output "bucket_details" {
  description = "Detailed information about the buckets"
  value = { 
    for bucket in var.buckets : bucket.name => {
      name        = google_storage_bucket.buckets[bucket.name].name
      location    = google_storage_bucket.buckets[bucket.name].location
      url         = google_storage_bucket.buckets[bucket.name].url
      description = bucket.description
    }
  }
}