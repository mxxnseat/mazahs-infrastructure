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
  -d '{
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

      "snapshot.mode": "initial"
    }
  }'
echo "Done"