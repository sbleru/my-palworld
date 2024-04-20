output "service_account_account_id" {
  description = "The unique id of the service account."
  value       = google_service_account.default.account_id
}

output "service_account_email" {
  description = "The email address of the service account."
  value       = google_service_account.default.email
}
