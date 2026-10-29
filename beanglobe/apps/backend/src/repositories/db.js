// The database connection (Postgres / Supabase).
// The only place where a database error is thrown (D-024, D-029).
// Side-effect free: no process.env, no file reads at import time (D-025).

import pg from 'pg';
import { translate } from './pgErrorMap.js';

const { Pool } = pg;

export function createPool({ connectionString, ca, logger }) {
  // 1. Create the pool with the D-029 settings:
  //    connectionString, max: 10, connectionTimeoutMillis: 10000, ssl: { ca }
  const pool = new Pool({connectionString, max: 10, connectionTimeoutMillis: 10000, ssl: {ca}});
  // 2. Idle-client errors: log and continue (D-029 (6))
  pool.on('error', (err) => { logger.error(err) });
  // 3. Hand the pool back to the caller
  return pool;
}

export async function query(pool, text, params = []) {
  try {
    return await pool.query(text, params);
  } catch (err) {
    throw translate(err);
  }
}