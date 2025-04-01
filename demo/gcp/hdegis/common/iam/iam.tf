## 폴더 레벨의 IAM role 생성
## IAM Group은 admin 웹콘솔로 생성 후 terraform 작업 진행

resource "google_folder_iam_member" "hdegis_group_id_admin_roles" {
  folder = var.folder_id  # hdegis 폴더 ID

  for_each = toset([
    "roles/resourcemanager.folderAdmin",
    "roles/resourcemanager.folderIamAdmin",
    "roles/resourcemanager.projectCreator",
    "roles/resourcemanager.projectIamAdmin",
    "roles/bigquery.admin",
    "roles/compute.xpnAdmin"
  ])

  role   = each.value
  member = var.group_it_admin_arn
}


resource "google_folder_iam_member" "hdegis_group_developer_roles" {
  folder = var.folder_id  # hdegis 폴더 ID

  for_each = toset([
    "roles/resourcemanager.folderViewer",
    "roles/resourcemanager.folderEditor",
    "roles/bigquery.admin"
  ])

  role   = each.value
  member = var.group_developer_arn
}