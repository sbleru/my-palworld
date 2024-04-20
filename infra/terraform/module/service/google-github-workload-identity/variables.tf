variable "project_id" {
  description = "Google CloudプロジェクトID"
  type        = string
  default     = "boreal-atom-412606"
}

variable "github_repos" {
  description = "アクセスを許可するGitHubリポジトリ"
  type        = list(string)
}

variable "service_account_name" {
  description = "サービスアカウント名"
  type        = string
  default     = "github"
}

variable "service_account_roles" {
  description = "サービスアカウントに付与するIAMロール"
  type        = list(string)
  default = [
    "roles/viewer",
    "roles/cloudbuild.builds.editor",
    "roles/storage.admin",
    "roles/run.developer",
    "roles/iam.serviceAccountUser",
  ]
}
