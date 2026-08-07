# @beanglobe/backend

Layered Express API: `routes -> controllers -> services -> repositories`,
plus `middleware/` (cross-cutting) and `adapters/` (external boundaries).

Dependencies are added as we reach the files that need them (Socratic),
so this stays honestly minimal until then.
