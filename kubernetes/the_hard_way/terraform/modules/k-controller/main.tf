resource "google_compute_instance" "controller" {
  count = 3
  name         = "controller-${count.index}"
  machine_type = "n1-standard-1"
  zone         = var.zone
  tags         = ["kubernetes-the-hard-way", "controller"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = 200
    }
  }

  network_interface {
    network = var.net_name
    subnetwork = var.subnet_name
    network_ip = "10.240.0.1${count.index}"
  }

  can_ip_forward = true

  metadata = {
    ssh-keys = "${var.user}:${file(var.ssh_pub_key_path)}"
  }

  service_account {
    scopes = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
  }
  allow_stopping_for_update = true

}
