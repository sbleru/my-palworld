variable "prefix" {
  type    = string
  default = "dev"
}

variable "primary_region" {
  type    = string
  default = "asia-northeast1"
}

variable "project_id" {
  type    = string
  default = "boreal-atom-412606"
}

variable "app_id" {
  type      = string
  sensitive = true
}

variable "discord_token" {
  type      = string
  sensitive = true
}

variable "discord_public_key" {
  type      = string
  sensitive = true
}
