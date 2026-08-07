// EXPRESS APP SETUP (does not start the server — see server.js).
// Responsibilities, in order:
//   1. Global middleware: express.json() (raw body -> req.body), rateLimit.
//   2. Mount the aggregated router from routes/index.js.
//   3. Register errorHandler LAST, so thrown errors become consistent JSON responses.
// Exports the app.
//
// TODO: build Socratically.
