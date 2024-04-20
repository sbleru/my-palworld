# NOTE: 変数化不可のためハードコーディング
terraform {
  required_version = "~> 1.6.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  backend "gcs" {
    bucket = "dev-my-palworld-tfstate"
    prefix = "v1/service/palworld-server"
  }
}

provider "google" {
  project = var.project_id
  region  = var.primary_region
}
