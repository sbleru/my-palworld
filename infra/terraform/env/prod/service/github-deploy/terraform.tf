terraform {
  required_version = "~> 1.8.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "my-palworld-tfstate"
    prefix = "v1/service/github-deploy"
  }
}

provider "google" {
  project = var.google_project_id
  region  = var.google_primary_region

  default_labels = {
    "terraform" = "true"
  }
}
