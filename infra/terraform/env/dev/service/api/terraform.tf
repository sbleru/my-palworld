# NOTE: 変数化不可のためハードコーディング
terraform {
  required_version = "~> 1.7.4"
  backend "gcs" {
    bucket = "dev-my-palworld-tfstate"
    prefix = "v1/service/discorad-bot-api"
  }
}

provider "google" {
  project = var.project_id
  region  = var.primary_region
}
