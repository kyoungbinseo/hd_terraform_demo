output "repository_ids" {
  description = "The IDs of the created Artifact Registry repositories"
  value       = { for k, repo in google_artifact_registry_repository.repositories : k => repo.repository_id }
}

output "repository_urls" {
  description = "The URLs of the created Artifact Registry repositories"
  value       = { for k, repo in google_artifact_registry_repository.repositories : k => "${repo.location}-docker.pkg.dev/${var.project}/${repo.repository_id}" }
}