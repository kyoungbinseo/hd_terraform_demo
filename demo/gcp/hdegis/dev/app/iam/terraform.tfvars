
project      = "pjt-dev-hdegis-app-454401"
region       = "asia-northeast3"


service_account_collect = {
  account_id   = "sa-dev-hdegis-app-collect"
  display_name = "sa-dev-hdegis-app-collect"
  description  = "(개발) 수집서버 서비스 계정"
  roles = [
    "roles/run.invoker",
    "roles/logging.admin",
    "roles/monitoring.admin",
    "roles/storage.admin",
    "roles/aiplatform.admin"
  ]
}

service_account_runjob = {
  account_id   = "sa-dev-hdegis-app-runjob"
  display_name = "sa-dev-hdegis-app-runjob"
  description  = "(개발) Cloud Run Job Backend 서비스 계정"
  roles = [
    "roles/logging.admin",
    "roles/monitoring.admin",
    "roles/storage.admin",
    "roles/aiplatform.admin"
  ]
}