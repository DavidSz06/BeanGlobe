// REPOSITORY (only layer that touches the DB): SQL for bookings and timeslots.
// repositories/bookingRepository.js
import { query } from './db.js';

export async function cancelBooking(pool, bookingId, profileId) {
  const result = await query(
    pool,
    "UPDATE public.bookings SET status = 'cancelled' WHERE id = $1 AND profile_id = $2",
    [bookingId, profileId],
  );
  return result.rowCount === 1;
}