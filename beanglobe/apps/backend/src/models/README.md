# models/ (contingent)

Whether this folder holds CODE depends on the ORM decision:
- **Raw SQL**: schema lives in `db/schema.sql`; repositories return plain objects; this folder may stay empty.
- **ORM (Prisma/Sequelize)**: model definitions live here.

Decision deferred — revisit when we pick ORM vs raw SQL.
