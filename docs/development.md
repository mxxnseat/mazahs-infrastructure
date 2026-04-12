## Local Development Setup

### Pre-requesites:

1. Install the [debezium-connector-postgres](https://debezium.io/documentation/reference/3.4/install.html) into the dev/connect/plugins

Start the local infrastructure with Docker Compose:

```bash
docker compose -f dev/docker-compose.yml up -d
```

To stop the services:

```bash
docker compose -f dev/docker-compose.yml down
```
