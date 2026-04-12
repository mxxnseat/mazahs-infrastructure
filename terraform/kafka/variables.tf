variable "bootstrap_servers" {
  type        = list(string)
  description = "Kafka bootstrap servers"
}

variable "tls_enabled" {
  type        = bool
  description = "Enable TLS for Kafka connection"
  default     = false
}

variable "topics" {
  type = map(object({
    partitions         = number
    replication_factor = number
    config             = optional(map(string), {})
  }))
  description = "Kafka topics for this environment"
}
