# tf plan -var-file secret.tfvars -generate-config-out=generated_firewall.tf

# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
# resource "google_compute_firewall" "server_policy" {
#   description             = null
#   destination_ranges      = []
#   direction               = "INGRESS"
#   disabled                = false
#   name                    = "palworld-server"
#   network                 = "https://www.googleapis.com/compute/v1/projects/boreal-atom-412606/global/networks/default"
#   priority                = 1000
#   project                 = "boreal-atom-412606"
#   source_ranges           = ["0.0.0.0/0"]
#   source_service_accounts = []
#   source_tags             = []
#   target_service_accounts = []
#   target_tags             = ["palworld"]
#   allow {
#     ports    = ["8211"]
#     protocol = "udp"
#   }
#   log_config {
#     metadata = "INCLUDE_ALL_METADATA"
#   }
#   timeouts {
#     create = null
#     delete = null
#     update = null
#   }
# }
