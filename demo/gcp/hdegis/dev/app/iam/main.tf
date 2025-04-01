
# create for terraform backend
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.44.0"
    }
  }
  backend gcs {
    # backend에는 variables 적용 불가
    bucket      = "gcs-dev-hdegis-app-terraform" # GCS 버킷 이름
    prefix      = "iam" # tfstate 저장 경로
  }
}

provider "google" {
  project     = var.project
  region      = var.region
}