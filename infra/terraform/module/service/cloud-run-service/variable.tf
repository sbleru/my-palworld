variable "primary_region" {
  description = "region"
  type        = string
}

variable "project_id" {
  description = "project id"
  type        = string
}

variable "web_api_name" {
  description = "Cloud Run service name"
  type        = string
}

variable "service_account_name" {
  description = "service account name"
  type        = string
}

variable "image" {
  description = "Docker image"
  type        = string
}

variable "envs" {
  description = "環境変数"
  type = set(
    object({
      key   = string
      value = string
    })
  )
  default = []
}

variable "env_secrets" {
  description = "シークレット変数"
  type = set(
    object({
      name         = string
      key          = string
      secret       = string
      secret_value = string
    })
  )
  default = []
  # sensitive = true
}

variable "cpu" {
  description = "CPU"
  type        = string
  default     = "1000m"
}

variable "memory" {
  description = "Memory"
  type        = string
  default     = "512Mi"
}

variable "max_scale" {
  description = "最大スケール数"
  type        = string
  default     = "100"
}

variable "cpu_boost" {
  description = "CPU boost"
  type        = string
  default     = "true"
}

variable "db_connection_name" {
  description = "Cloud SQL 接続インスタンス名"
  type        = string
  default     = ""
}
