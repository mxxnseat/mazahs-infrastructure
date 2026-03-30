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

---

## Services

The local development environment includes:

- **PostgreSQL** — stores songs and generated audio fingerprints
- **Redis** — used for queue-based background processing

Defined in:

```text
dev/docker-compose.yml
```

---

## Local Development Setup

Start the local infrastructure with Docker Compose:

```bash
docker compose -f dev/docker-compose.yml up -d
```

This will start:

- **PostgreSQL** on `localhost:5432`
- **Redis** on `localhost:6379`

To stop the services:

```bash
docker compose -f dev/docker-compose.yml down
```

---

## Docker Services Configuration

### PostgreSQL

- Image: `postgres:18`
- Container name: `shazam-postgres`
- Port: `5432`

Default credentials:

```env
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=postgres
```

### Redis

- Image: `redis:8.6.2`
- Port: `6379`

---

## Environment Variables

Backend services that depend on this infrastructure should use:

```env
DATABASE_URL=postgres://postgres:postgres@localhost:5432/shazam
REDIS_HOST=localhost
REDIS_PORT=6379
```

Note: if you use the provided PostgreSQL container as-is, make sure the `shazam` database exists before running the backend services or migrations.

---

## Database Schema

Database schema is defined with Atlas in:

```text
postgres/schema.pg.hcl
```

The schema currently contains:

- `songs` table
- `song_hashes` table
- `songs_status` enum

### `songs`

Stores information about indexed songs.

Columns:

- `id` — primary key
- `name` — song name
- `url` — source URL
- `status` — processing status (`pending`, `ready`)

Indexes:

- `idx_songs_name`
- `idx_songs_status`

### `song_hashes`

Stores generated audio fingerprint hashes for each song.

Columns:

- `id` — primary key
- `song_id` — reference to song
- `anchor_time` — anchor time used for matching
- `hash` — fingerprint hash

Indexes:

- `idx_song_hashes_hash`

Constraints:

- foreign key from `song_hashes.song_id` to `songs.id`

---

## Schema Model

### Enum

```text
songs_status = ["pending", "ready"]
```

### Relationships

- one song can have many fingerprint hashes
- each fingerprint hash belongs to one song

---

## Repository Structure

```text
.
├── dev/
│   └── docker-compose.yml
└── postgres/
    └── schema.pg.hcl
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
