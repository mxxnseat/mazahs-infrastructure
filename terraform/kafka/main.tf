terraform {
  required_providers {
    kafka = {
      source  = "Mongey/kafka"
      version = "~> 0.13"
    }
  }
}

provider "kafka" {
  bootstrap_servers = var.bootstrap_servers
  tls_enabled = var.tls_enabled
}
