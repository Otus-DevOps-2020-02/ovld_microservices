terraform {
  required_version = "~> 0.12.0"
}

provider "google" {
  version = "~> 2.5.0"
  project = "docker-275214"
  region  = "us-central1"
}

module "network" {
  source          = "./modules/network"
  region          = "us-central1"
  net_name        = "kubernetes-the-hard-way"
  subnet_name     = "kubernetes"
  subnet_cidr     = "10.240.0.0/24"
  router_name     = "kubernetes-router"
  router_nat_name = "kubernetes-router-nat"
}

module "bastion" {
  source          = "./modules/bastion"
  zone = "us-central1-a"
  net_name        = "kubernetes-the-hard-way"
  subnet_name     = module.network.google_compute_subnetwork_name
}

module "k-controller" {
  source          = "./modules/k-controller"
  zone            = "us-central1-a"
  net_name        = "kubernetes-the-hard-way"
  subnet_name     = module.network.google_compute_subnetwork_name
}

module "k-worker" {
  source          = "./modules/k-worker"
  zone            = "us-central1-a"
  net_name        = "kubernetes-the-hard-way"
  subnet_name     = module.network.google_compute_subnetwork_name
}
