variable zone {
  type        = string
  description = "project zone"
}
variable net_name {
  type        = string
  description = "google_compute_network name"
}

variable subnet_name {
  type        = string
  description = "google_compute_subnetwork name"
}

variable user {
  type        = string
  description = "user"
  default     = "vld"
}
variable ssh_pub_key_path {
  type        = string
  description = "public_key"
  default     = "~/.ssh/id_rsa.pub"
}
