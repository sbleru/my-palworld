module "palworld_server" {
  source = "../../../../module/service/server-compute-engine"

  project_id = var.project_id

  server_name = "palworld-server"

  zone = "asia-northeast1-a"

  boot_disk_image = "debian-cloud/debian-11"

  machine_type = "e2-standard-4"

  startup_script = templatefile("${path.module}/startup.sh", {
    server_name        = var.palworld_server_name
    server_description = var.palworld_server_description
    admin_password     = var.admin_password
    server_password    = var.server_password
    tz                 = var.palworld_server_tz
  })
}
