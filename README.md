# Infrastructure

Infrastructure and local development setup for the Shazam-like audio recognition system.

This repository contains the local development environment and database schema used by the backend services. It provides Docker-based dependencies such as PostgreSQL and Redis, as well as Atlas schema definitions for managing the database structure.

---

## Overview

This repository is responsible for:

- running local infrastructure dependencies
- provisioning PostgreSQL and Redis for development
- storing the database schema definition
- managing database structure with Atlas

## Docs

The docs can be found in /docs

```bash
docs/
├── development.md

```

---

## Services

The local development environment includes:

- **PostgreSQL** — stores songs and generated audio fingerprints
- **Redis** — used for queue-based background processing
- **Kafka** - user as message bus between services
- **Debezium** - CDC

Defined in:

```text
dev/docker-compose.yml
```

---

## Usage in the System

This infrastructure is used by the [backend](https://github.com/mxxnseat/mazahs-backend) services:

- **Searcher** — reads jobs from Redis and stores generated fingerprints in PostgreSQL
- **API** — reads and manages song metadata
- **WebSocket server** — performs real-time matching against stored hashes

---

## Notes

- PostgreSQL and Redis are intended for local development in this setup
- Atlas schema file is the source of truth for database structure
- Make sure Docker is running before starting the environment
