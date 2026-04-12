topics = {
  "connect-configs" = {
    partitions         = 1
    replication_factor = 1
    config = {
      "cleanup.policy" = "compact"
    }
  }

  "connect-offsets" = {
    partitions         = 25
    replication_factor = 1
    config = {
      "cleanup.policy" = "compact"
    }
  }

  "connect-status" = {
    partitions         = 5
    replication_factor = 1
    config = {
      "cleanup.policy" = "compact"
    }
  }

  "dbserver1.public.songs" = {
    partitions         = 5
    replication_factor = 1
    config = {
      "retention.ms"     = "604800000"
      "segment.ms"       = "86400000"
      "cleanup.policy"   = "delete"
      "compression.type" = "gzip"
    }
  }
}