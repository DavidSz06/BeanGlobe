// Loads and VALIDATES environment variables once, at startup.
// Fail fast: if a required var (DATABASE_URL, LLM_API_KEY, JWT_SECRET) is missing,
// crash here with a clear message rather than mysteriously later.
//
// TODO: build Socratically.
