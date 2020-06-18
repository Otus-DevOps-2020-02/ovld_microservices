resource "google_compute_network" "net" {
  name = var.net_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  network       = google_compute_network.net.id
  ip_cidr_range = var.subnet_cidr
  region        = var.region
}

resource "google_compute_router" "router" {
  name    = var.router_name
  region  = google_compute_subnetwork.subnet.region
  network = google_compute_network.net.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = var.router_nat_name
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_firewall" "internal" {
  name    = "kubernetes-the-hard-way-allow-internal"
  network = google_compute_network.net.name

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }

  source_ranges = ["${var.subnet_cidr}", "10.200.0.0/16"]
}

resource "google_compute_firewall" "external" {
  name    = "kubernetes-the-hard-way-allow-external"
  network = google_compute_network.net.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "static" {
  name = "kubernetes-the-hard-way"
  region = var.region
}
