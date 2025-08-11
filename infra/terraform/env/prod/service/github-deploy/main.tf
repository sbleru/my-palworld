# Google Cloud Workload Identity関連リソース
module "google" {
  source = "../../../../module/service/google-github-workload-identity"

  project_id = var.google_project_id
  github_repos = [
    "sbleru/my-palworld",
  ]
  service_account_name = "github-deploy"
}
