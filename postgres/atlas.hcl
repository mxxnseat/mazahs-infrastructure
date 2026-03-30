env "local" {
  src = "file://schema.pg.hcl"
  url = getenv("DATABASE_URL")
  dev = getenv("ATLAS_DEV_URL")
}