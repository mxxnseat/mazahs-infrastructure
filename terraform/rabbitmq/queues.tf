resource "rabbitmq_queue" "queues" {
  for_each = var.queues

  name  = each.key
  vhost = each.value.vhost
  settings {
    durable     = each.value.settings.durable
    auto_delete = each.value.settings.auto_delete
    arguments   = each.value.settings.arguments
  }

  depends_on = [rabbitmq_vhost.vhosts]
}