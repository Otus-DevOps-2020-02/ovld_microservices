resource "google_compute_instance" "bastion" {
  name         = "kubernetes-bastion"
  machine_type = "g1-small"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    network = var.net_name
    subnetwork = var.subnet_name
    network_ip = "10.240.0.3"
    access_config {
      nat_ip = google_compute_address.bastion_ip.address
    }
  }
  metadata = {
    ssh-keys = "${var.user}:${file(var.ssh_pub_key_path)}"
  }

  service_account {
    scopes = ["cloud-platform"]
  }
  allow_stopping_for_update = true


  connection {
    type        = "ssh"
    host        = google_compute_address.bastion_ip.address
    user        = var.user
    agent       = false
    private_key = file("/home/${var.user}/.ssh/id_rsa")
  }

  provisioner "file" {
    source      = "/home/${var.user}/.ssh/id_rsa"
    destination = "/home/${var.user}/.ssh/id_rsa"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/${var.user}/.ssh/id_rsa"
    ]
  }

}

resource "google_compute_address" "bastion_ip" {
  name = "kubernetes-bastion-ip"
}
