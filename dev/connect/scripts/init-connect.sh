#!/bin/sh
set -e

echo "Waiting for Kafka Connect..."

until curl -s http://connect:8083/connectors; do
  sleep 2
done

echo "Kafka Connect is ready"
echo "Creating connector..."

curl -X POST http://connect:8083/connectors \
  -H 'Content-Type: application/json' \
  --data @- <<'EOF'
{
  "name": "postgres-cdc",
  "config": {
    "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
    "tasks.max": "1",

    "database.hostname": "postgres",
    "database.port": "5432",
    "database.user": "debezium",
    "database.password": "dbz",
    "database.dbname": "shazam",

    "topic.prefix": "dbserver1",
    "plugin.name": "pgoutput",

    "slot.name": "debezium_slot",
    "publication.name": "debezium_pub",
    "publication.autocreate.mode": "disabled",

    "table.include.list": "public.songs",
    "schema.include.list": "public",

    "snapshot.mode": "initial",

    "transforms": "rename,route,unwrap",

    "transforms.rename.type": "org.apache.kafka.connect.transforms.RegexRouter",
    "transforms.rename.regex": "dbserver1\\.public\\.(.*)",
    "transforms.rename.replacement": "$1",

    "transforms.route.type": "io.debezium.transforms.ContentBasedRouter",
    "transforms.route.language": "jsr223.groovy",
    "transforms.route.topic.expression": "value.op == 'r' ? topic + '.snapshot' : value.op == 'c' ? topic + '.created' : value.op == 'u' ? topic + '.updated' : value.op == 'd' ? topic + '.deleted' : topic",

    "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
    "transforms.unwrap.delete.tombstone.handling.mode": "rewrite"
  }
}
EOF

echo "Done"