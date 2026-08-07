// The database connection (Postgres / Supabase).
// Creates and exports the connection/pool used by the repositories layer.
// NOTE: ORM-vs-raw-SQL is undecided — that choice changes this file's internals,
// not its role. Nothing above the repositories should import this directly.
//
// TODO: build Socratically.
