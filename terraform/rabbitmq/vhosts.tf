resource "rabbitmq_vhost" "vhosts" {
  for_each = var.vhosts
  name     = each.value
}
