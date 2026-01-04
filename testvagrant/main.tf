terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.0"
    }
  }
}

provider "scaleway" {
  region = "fr-par"
  zone   = "fr-par-1"
}

resource "scaleway_instance_server" "web" {
  name  = "cloud1-server"
  type  = "DEV1-S"
  image = "ubuntu_jammy"
}

