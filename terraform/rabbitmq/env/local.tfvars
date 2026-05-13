vhosts = {
  shazam = "shazam"
}

queues = {
  "songs-classifier" = {
    vhost = "shazam"
    settings = {
      durable     = true
      auto_delete = false
      arguments = {
        "x-queue-type" = "quorum"
      }
    }
  }
}

exchanges = {
  "songs" = {
    vhost = "shazam",
    settings = {
      type        = "topic"
      durable     = true
      auto_delete = false
    }
  }
}

bindings = {
  "songs-songs.classified" = {
    source           = "songs"
    vhost            = "shazam"
    destination      = "songs-classifier"
    destination_type = "queue"
    routing_key      = "songs.classified"
  }
}