variable "project_id" {
  description = "project id"
  type        = string
}

variable "server_name" {
  description = "server name"
  type        = string
}

variable "machine_type" {
  description = "machine type"
  type        = string
  default     = "e2-standard-4"
}

variable "zone" {
  description = "zone"
  type        = string
  default     = "asia-northeast1-a"
}

variable "boot_disk_image" {
  description = "boot disk image"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "startup_script" {
  description = "startup script"
  type        = string
}
