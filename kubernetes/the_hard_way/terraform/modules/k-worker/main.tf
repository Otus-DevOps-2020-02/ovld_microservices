resource "google_compute_instance" "worker" {
  count = 3
  name         = "worker-${count.index}"
  machine_type = "n1-standard-1"
  zone         = var.zone
  tags         = ["kubernetes-the-hard-way", "worker"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = 200
    }
  }

  network_interface {
    network = var.net_name
    subnetwork = var.subnet_name
    network_ip = "10.240.0.2${count.index}"
  }

  can_ip_forward = true

  metadata = {
    ssh-keys = "${var.user}:${file(var.ssh_pub_key_path)}"
    pod-cidr="10.200.${count.index}.0/24"
  }

  service_account {
    scopes = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
  }
  allow_stopping_for_update = true

}
