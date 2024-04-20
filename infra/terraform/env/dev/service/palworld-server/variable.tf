
variable "primary_region" {
  description = "region"
  type        = string
  default     = "asia-northeast1"
}

variable "project_id" {
  description = "project id"
  type        = string
}

variable "server_password" {
  description = "server password"
  type        = string
}

variable "admin_password" {
  description = "admin password"
  type        = string
}

variable "palworld_server_name" {
  description = "server name"
  type        = string
  default     = "palworld-server"
}

variable "palworld_server_description" {
  description = "Server description"
  type        = string
  default     = ""
}

variable "palworld_server_tz" {
  description = "Server timezone"
  type        = string
  default     = "JST"
}
