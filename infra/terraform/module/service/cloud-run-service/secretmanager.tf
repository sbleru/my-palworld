# シークレットを作成
resource "google_secret_manager_secret" "secret" {
  for_each = nonsensitive(toset([for s in var.env_secrets : s.name]))

  secret_id = each.value

  replication {
    user_managed {
      replicas {
        location = var.primary_region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "secret_version" {
  for_each = nonsensitive({ for s in var.env_secrets : s.name => s })

  secret = google_secret_manager_secret.secret[each.key].name

  secret_data     = each.value.secret_value
  deletion_policy = "DISABLE"
}
