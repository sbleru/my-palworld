variable "prefix" {
  description = "prefix"
  type        = string
  default     = "prod"
}

variable "primary_region" {
  description = "region"
  type        = string
  default     = "asia-northeast1"
}

variable "project_id" {
  description = "project id"
  type        = string
  default     = "boreal-atom-412606"
}

variable "discord_app_id" {
  description = "discord app id"
  type        = string
  sensitive   = true
}

variable "discord_token" {
  description = "discord token"
  type        = string
  sensitive   = true
}

variable "discord_public_key" {
  description = "discord public key"
  type        = string
  sensitive   = true
}
