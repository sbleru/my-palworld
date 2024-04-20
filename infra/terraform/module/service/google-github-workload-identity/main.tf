locals {
  services = toset([
    "iamcredentials.googleapis.com"
  ])
}

# workload identityを利用したデプロイに関わるリソース
resource "google_iam_workload_identity_pool" "default" {
  project                   = var.project_id
  workload_identity_pool_id = "github-actions-pool"
  display_name              = "GitHub Actions Pool"
  description               = "Managed by Terraform"
}

resource "google_iam_workload_identity_pool_provider" "default" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.default.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions-provider"
  display_name                       = "GitHub Actions Provider"
  description                        = "Managed by Terraform"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# サービスアカウント
resource "google_service_account" "default" {
  account_id   = var.service_account_name
  display_name = var.service_account_name
}

# Workload Identityにリポジトリを紐づけ
resource "google_service_account_iam_member" "default" {
  for_each = toset(var.github_repos)

  service_account_id = google_service_account.default.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.default.name}/attribute.repository/${each.key}"
}

# サービスアカウントにロールを付与
resource "google_project_iam_member" "default" {
  for_each = toset(var.service_account_roles)

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.default.email}"
}

# 必要なAPIを有効化
#　https://scrapbox.io/pokutuna/GCP_API_%E3%82%92_Terraform_%E3%81%8B%E3%82%89%E6%9C%89%E5%8A%B9%E3%81%AB%E3%81%99%E3%82%8B
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "service" {
  for_each = local.services
  project  = var.project_id
  service  = each.value
}
