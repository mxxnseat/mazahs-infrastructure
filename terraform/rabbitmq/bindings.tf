resource "rabbitmq_binding" "bindings" {
  for_each = var.bindings

  source           = each.value.source
  vhost            = each.value.vhost
  destination      = each.value.destination
  destination_type = each.value.destination_type
  routing_key      = each.value.routing_key

  depends_on = [ rabbitmq_exchange.exchanges, rabbitmq_queue.queues, rabbitmq_vhost.vhosts ]
}