
output "sa_collect_id" {
  value = google_service_account.collect.account_id
}
output "sa_collect_email" {
  value = google_service_account.collect.email
}

output "sa_runjob_id" {
  value = google_service_account.runjob.account_id
}
output "sa_runjob_email" {
  value = google_service_account.runjob.email
}