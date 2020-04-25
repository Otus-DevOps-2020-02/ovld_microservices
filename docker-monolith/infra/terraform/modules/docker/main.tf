resource "google_compute_instance" "docker" {
  count        = var.nodes_count
  name         = "docker-n${count.index}"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["docker"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

}

resource "google_compute_firewall" "puma" {
  name    = "puma"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
}
