#!/usr/bin/env bash
set -e

cat > /tmp/connect-distributed.properties <<EOF
bootstrap.servers=${CONNECT_BOOTSTRAP_SERVERS}
group.id=${CONNECT_GROUP_ID}

config.storage.topic=connect-configs
offset.storage.topic=connect-offsets
status.storage.topic=connect-status

config.storage.replication.factor=${CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR:-1}
offset.storage.replication.factor=${CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR:-1}
status.storage.replication.factor=${CONNECT_STATUS_STORAGE_REPLICATION_FACTOR:-1}

config.storage.partitions=${CONNECT_CONFIG_STORAGE_PARTITIONS:-1}
offset.storage.partitions=${CONNECT_OFFSET_STORAGE_PARTITIONS:-25}
status.storage.partitions=${CONNECT_STATUS_STORAGE_PARTITIONS:-5}

key.converter=${CONNECT_KEY_CONVERTER}
value.converter=${CONNECT_VALUE_CONVERTER}
key.converter.schemas.enable=${CONNECT_KEY_CONVERTER_SCHEMAS_ENABLE}
value.converter.schemas.enable=${CONNECT_VALUE_CONVERTER_SCHEMAS_ENABLE}

internal.key.converter=${CONNECT_INTERNAL_KEY_CONVERTER}
internal.value.converter=${CONNECT_INTERNAL_VALUE_CONVERTER}

rest.advertised.host.name=${CONNECT_REST_ADVERTISED_HOST_NAME}
plugin.path=${CONNECT_PLUGIN_PATH}

offset.flush.interval.ms=10000
EOF

exec ${KAFKA_HOME}/bin/connect-distributed.sh /tmp/connect-distributed.properties