terraform {
  required_version = "~> 0.12.0"
}

provider "google" {
  version = "~> 2.5.0"
  project = var.project
  region  = var.region
}

module "docker" {
  source       = "./modules/docker"
  zone         = var.zone
  image        = var.image
  nodes_count  = var.nodes_count
  machine_type = var.machine_type
}
