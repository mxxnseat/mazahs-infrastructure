#!/bin/bash

set -e

export POSTGRES_DB=shazam
export PGPASSWORD=postgres

echo "Initializing PostgreSQL database..."

DB_EXISTS=$(psql \
  -h postgres \
  -U postgres \
  -tAc "SELECT 1 FROM pg_database WHERE datname='$POSTGRES_DB';")

if [ "$DB_EXISTS" = "1" ]; then
    echo "Database exists. Drop existing database..."
    psql -U postgres -h postgres -c "drop database ${POSTGRES_DB};";
fi

echo "Creating database..."
psql -U postgres -h postgres -c "create database ${POSTGRES_DB};";
echo "Database ${POSTGRES_DB} created."

export DATABASE_URL="postgresql://postgres:postgres@postgres:5432/${POSTGRES_DB}?sslmode=disable"
export ATLAS_DEV_URL=${DATABASE_URL}

atlas schema apply \
    --config file:///workspace/postgres/atlas.hcl \
    --to file:///workspace/postgres/schema.pg.hcl  \
    --env local \
    --auto-approve

echo "PostgreSQL database initialized successfully."

echo "Setting up publication for Debezium..."
psql -U postgres -h postgres -d ${POSTGRES_DB} <<EOF
DO \$\$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'debezium') THEN
      CREATE ROLE debezium WITH LOGIN PASSWORD 'dbz';
   END IF;
END
\$\$;

GRANT CONNECT ON DATABASE ${POSTGRES_DB} TO debezium;
GRANT USAGE ON SCHEMA public TO debezium;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO debezium;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO debezium;
ALTER ROLE debezium REPLICATION;

CREATE PUBLICATION debezium_pub FOR TABLE public.songs;
EOF

echo "Publication for Debezium set up successfully."

echo "Apply kafka terraform"
export TF_VAR_bootstrap_servers='["kafka:9092"]'

terraform -chdir=./terraform/kafka init
terraform -chdir=./terraform/kafka apply -var-file=env/local.tfvars -auto-approve