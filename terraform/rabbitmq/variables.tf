variable "endpoint" {
  description = "RabbitMQ management API endpoint"
  type        = string
  default     = "http://127.0.0.1:15672"
}

variable "username" {
  description = "RabbitMQ management API username"
  type        = string
  sensitive   = true
  default     = "guest"
}

variable "password" {
  description = "RabbitMQ management API password"
  type        = string
  sensitive   = true
  default     = "guest"
}

variable "vhosts" {
  type = map(string)
}

variable "queues" {
  type = map(object({
    vhost = string
    settings = object({
      durable     = bool
      auto_delete = bool
      arguments   = map(string)
    })
  }))

  description = "RabbitMQ queues for this environment"
}

variable "exchanges" {
  type = map(object({
    vhost = string
    settings = object({
      type        = string
      durable     = bool
      auto_delete = bool
    })
  }))

  description = "RabbitMQ exchanges for this environment"
}

variable "bindings" {
  type = map(object({
    vhost            = string
    source           = string
    destination      = string
    destination_type = string
    routing_key      = string
  }))

  description = "RabbitMQ bindings for this environment"
}