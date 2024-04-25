# サービスアカウントへsecretへのアクセス権限を付与
resource "google_secret_manager_secret_iam_member" "api" {
  for_each  = nonsensitive(toset([for s in var.env_secrets : s.name]))
  project   = var.project_id
  secret_id = each.value
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.api.email}"
}

# TODO outputからnameとか指定する
resource "google_compute_instance_iam_member" "this" {
  project       = var.project_id
  zone          = "asia-northeast1-a"
  instance_name = "palworld-server"
  role          = "roles/compute.instanceAdmin.v1"
  member        = "serviceAccount:${google_service_account.api.email}"
}
