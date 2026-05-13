resource "rabbitmq_exchange" "exchanges" {
  for_each = var.exchanges

  name  = each.key
  vhost = each.value.vhost
  settings {
    type        = each.value.settings.type
    durable     = each.value.settings.durable
    auto_delete = each.value.settings.auto_delete
  }

  depends_on = [rabbitmq_vhost.vhosts]
}