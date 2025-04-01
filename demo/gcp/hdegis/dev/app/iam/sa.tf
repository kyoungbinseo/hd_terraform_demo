resource "google_service_account" "collect" {
  project      = var.project
  account_id   = var.service_account_collect.account_id
  display_name = var.service_account_collect.display_name
  description  = var.service_account_collect.description
}
resource "google_project_iam_member" "collect_roles" {
  for_each = toset(var.service_account_collect.roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.collect.email}"
}


resource "google_service_account" "runjob" {
  project      = var.project
  account_id   = var.service_account_runjob.account_id
  display_name = var.service_account_runjob.display_name
  description  = var.service_account_runjob.description
}
resource "google_project_iam_member" "runjob_roles" {
  for_each = toset(var.service_account_runjob.roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.runjob.email}"
}