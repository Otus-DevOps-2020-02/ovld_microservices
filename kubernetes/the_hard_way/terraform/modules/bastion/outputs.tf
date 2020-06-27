output "bastion_external_ip" {
  value = google_compute_address.bastion_ip.address
}
