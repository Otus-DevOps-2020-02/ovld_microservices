terraform {
  required_version = "~> 0.12.0"
}

provider "google" {
  version = "~> 2.5.0"
  project = "docker-275214"
  region  = "us-central1"
}


resource "google_container_cluster" "primary" {
  name     = "k8-terraform-cluster"
  location = "us-central1"

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "k8-terraform-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = "g1-small"
    disk_size_gb = 20
    disk_type    = "pd-standard"
    tags         = ["k8-terraform-node-pool"]
    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_compute_firewall" "k8-terraform-cluster" {
  name    = "k8-terraform-cluster"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }
  direction     = "INGRESS"
  priority      = 1000
  target_tags   = ["k8-terraform-node-pool"]
  source_ranges = ["0.0.0.0/0"]
}
