variable region {
  type        = string
  description = "project region"
}

variable net_name {
  type        = string
  description = "google_compute_network name"
}

variable subnet_name {
  type        = string
  description = "google_compute_subnetwork name"
}

variable subnet_cidr {
  type        = string
  description = "google_compute_subnetwork ip_cidr_range"
}

variable router_name {
  type        = string
  description = "google_compute_router name"
}

variable router_nat_name {
  type        = string
  description = "google_compute_router_nat name"
}
