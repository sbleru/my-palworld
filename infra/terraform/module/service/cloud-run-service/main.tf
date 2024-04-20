resource "google_cloud_run_service" "api" {

  project = var.project_id

  name     = var.web_api_name
  location = var.primary_region

  template {
    spec {
      service_account_name = google_service_account.api.email

      containers {
        image = var.image

        dynamic "env" {
          for_each = var.envs
          content {
            name  = env.value.key
            value = env.value.value
          }
        }

        dynamic "env" {
          # can't iterate over sensitive variables in dynamic blocks.
          # https://developer.hashicorp.com/terraform/language/functions/nonsensitive
          for_each = nonsensitive(var.env_secrets)

          content {
            name = env.value.name

            value_from {
              secret_key_ref {
                key  = env.value.key
                name = env.value.secret
              }
            }
          }
        }

        resources {
          limits = {
            cpu    = var.cpu
            memory = var.memory
          }
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = var.max_scale
        "run.googleapis.com/cloudsql-instances" = var.db_connection_name != "" ? var.db_connection_name : null
        "run.googleapis.com/startup-cpu-boost"  = var.cpu_boost
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  # revision名はterraformで管理しない
  # see https://www.notion.so/balusco/Cloud-Run-SRE-ZOZO-TECH-BLOG-633ca3c6968440e6ae36f1858e1d1b4a
  autogenerate_revision_name = true

  # Cloud Run サービスは、アプリケーション側でgcloud cliで更新するため、一部更新を無視する
  lifecycle {
    ignore_changes = [
      template[0].metadata[0].annotations["run.googleapis.com/client-version"],
      template[0].metadata[0].annotations["run.googleapis.com/client-name"],
    ]
  }

  # 本来はterraformが依存関係を自動で解決してくれるはずだが、明示的に依存関係を定義しないとapplyできなかったため定義。
  depends_on = [
    google_secret_manager_secret_iam_member.api,
    google_secret_manager_secret_version.secret_version
  ]
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "web_api_noauth" {
  location = google_cloud_run_service.api.location
  project  = google_cloud_run_service.api.project
  service  = google_cloud_run_service.api.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

# Cloud Run サービスアカウントを作成
resource "google_service_account" "api" {
  account_id   = var.service_account_name
  display_name = var.service_account_name
}
