module "api" {
  source = "../../../../module/service/cloud-run-service"

  web_api_name = "${var.prefix}-api"

  primary_region = var.primary_region

  service_account_name = "${var.prefix}-api"

  project_id = var.project_id

  image = "gcr.io/${var.project_id}/api:latest"

  envs = []

  env_secrets = [
    {
      name         = "DISCORD_APP_ID"
      key          = "latest"
      secret       = "DISCORD_APP_ID"
      secret_value = var.discord_app_id
    },
    {
      name         = "DISCORD_TOKEN"
      key          = "latest"
      secret       = "DISCORD_TOKEN"
      secret_value = var.discord_token
    },
    {
      name         = "DISCORD_PUBLIC_KEY"
      key          = "latest"
      secret       = "DISCORD_PUBLIC_KEY"
      secret_value = var.discord_public_key
    }
  ]
}

# moved {
#   from = "discorad_bot_api"
#   to   = "api"
# }

# # module.discorad_bot_api.google_cloud_run_service.api
# moved {
#   from = module.discorad_bot_api.google_cloud_run_service.api
#   to   = module.api.google_cloud_run_service.api
# }

# # module.discorad_bot_api.google_secret_manager_secret.secret
# moved {
#   from = module.discorad_bot_api.google_secret_manager_secret.secret
#   to   = module.api.google_secret_manager_secret.secret
# }

# # module.discorad_bot_api.google_secret_manager_secret.secret
# moved {
#   from = module.discorad_bot_api.google_secret_manager_secret.secret
#   to   = module.api.google_secret_manager_secret.secret
# }

# # module.discorad_bot_api.google_secret_manager_secret.secret
# moved {
#   from = module.discorad_bot_api.google_secret_manager_secret.secret
#   to   = module.api.google_secret_manager_secret.secret
# }
# # module.discorad_bot_api.google_secret_manager_secret_iam_member.api
# moved {
#   from = module.discorad_bot_api.google_secret_manager_secret_iam_member.api
#   to   = module.api.google_secret_manager_secret_iam_member.api
# }
# # module.discorad_bot_api.google_secret_manager_secret_iam_member.api
# moved {
#   from = module.discorad_bot_api.google_secret_manager_secret_iam_member.api
#   to   = module.api.google_secret_manager_secret_iam_member.api
# }
# # module.discorad_bot_api.google_secret_manager_secret_iam_member.api
# moved {
#   from = module.discorad_bot_api.google_secret_manager_secret_iam_member.api
#   to   = module.api.google_secret_manager_secret_iam_member.api
# }
# # module.discorad_bot_api.google_secret_manager_secret_version.secret_version
# moved {
#   from = module.discorad_bot_api.google_secret_manager_secret_version.secret_version
#   to   = module.api.google_secret_manager_secret_version.secret_version
# }
# # module.discorad_bot_api.google_secret_manager_secret_version.secret_version
# moved {
#   from = module.discorad_bot_api.google_secret_manager_secret_version.secret_version
#   to   = module.api.google_secret_manager_secret_version.secret_version
# }
# # module.discorad_bot_api.google_secret_manager_secret_version.secret_version
# moved {
#   from = module.discorad_bot_api.google_secret_manager_secret_version.secret_version
#   to   = module.api.google_secret_manager_secret_version.secret_version
# }
# # module.discorad_bot_api.google_service_account.api
# moved {
#   from = module.discorad_bot_api.google_service_account.api
#   to   = module.api.google_service_account.api
# }
