# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
resource "google_compute_instance" "server" {
  project = var.project_id

  name = var.server_name

  machine_type = var.machine_type

  zone = var.zone

  network_interface {
    network = "default"
    access_config {}
  }
  boot_disk {
    initialize_params {
      image = var.boot_disk_image
    }
  }
  service_account {
    scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }
  scheduling {
    automatic_restart = true
  }
  
  tags = [
    "palworld"
  ]

  metadata = {
    # startup_script = file("${path.module}/startup.sh")
    startup-script = var.startup_script
  }

  lifecycle {
    ignore_changes = [
      metadata["ssh-keys"]
    ]
  }
}

resource "google_compute_firewall" "server_firewall" {
  description             = null
  destination_ranges      = []
  direction               = "INGRESS"
  disabled                = false
  name                    = "${var.server_name}-firewall"
  network                 = data.google_compute_network.default.name
  priority                = 1000
  project                 = var.project_id
  source_ranges           = ["0.0.0.0/0"]
  # source_service_accounts = []
  # source_tags             = []
  # target_service_accounts = []
  target_tags             = ["palworld"]
  allow {
    ports    = ["8211"]
    protocol = "udp"
  }
  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
  timeouts {
    create = null
    delete = null
    update = null
  }
}

data "google_compute_network" "default" {
  name = "default"
}