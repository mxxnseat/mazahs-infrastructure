schema "public" {
    comment = "The public schema"
}

enum "songs_status" {
    schema = schema.public

    values = ["pending", "ready"]
}

table "songs" {
    schema = schema.public
    column "id" {
        null = false
        type = bigint
        identity {
            generated = "ALWAYS"
        }
    }
    column "name" {
        null = false
        type = character_varying
    }
    column "url" {
        null = false
        type = text
    }
    column "status" {
        null = false
        type = enum.songs_status
        default = "pending"
    }
    primary_key {
        columns = [column.id]
    }

    index "idx_songs_name" {
        columns = [column.name]
    }

    index "idx_songs_status" {
        columns = [column.status]
    }
}

table "song_hashes" {
    schema = schema.public
    column "id" {
        type = bigint
        null = false

        identity {
            generated = "ALWAYS"
        }
    }
    column "song_id" {
        type = bigint
        null = false
    }
    column "anchor_time" {
        type = bigint
        null = false
    }
    column "hash" {
        type = integer
        null = false
    }
    index "idx_song_hashes_hash" {
        columns = [column.hash]
    }
    primary_key {
        columns = [column.id]
    }
    foreign_key "fk_song_id" {
        columns     = [column.song_id]
        ref_columns = [table.songs.column.id]
    }
}
