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
}

variable "server_password" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "palworld_server_name" {
  type = string
  default = "palworld-server"
}

variable "palworld_server_description" {
  type    = string
  default = ""
}

variable "palworld_server_tz" {
  type    = string
  default = "JST"
}
