## Local Development Setup

### Pre-requesites:

1. Install the [debezium-connector-postgres](https://debezium.io/documentation/reference/3.4/install.html) into the dev/connect/plugins
2. Install the [debezium-scripting](https://debezium.io/documentation/reference/3.4/transformations/content-based-routing.html) into the dev/connect/plugins
3. Install the [Groovy scripting](https://archive.apache.org/dist/groovy/5.0.5/distribution/apache-groovy-binary-5.0.5.zip) into the dev/connect/plugins

Start the local infrastructure with Docker Compose:

```bash
docker compose -f dev/docker-compose.yml up -d
```

To stop the services:

```bash
docker compose -f dev/docker-compose.yml down
```
