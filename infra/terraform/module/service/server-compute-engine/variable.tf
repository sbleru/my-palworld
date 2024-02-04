variable "project_id" {
  type = string
}

variable "server_name" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "e2-standard-4"
}

variable "zone" {
  type    = string
  default = "asia-northeast1-a"
}

variable "boot_disk_image" {
  type    = string
  default = "debian-cloud/debian-11"
}

variable "device_name" {
  type = string
}

variable "startup_script" {
  type = string
}