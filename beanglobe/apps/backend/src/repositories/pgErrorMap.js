// repositories/pgErrorMap.js
// Translates node-postgres errors into domain errors (D-024, D-028).
// Imported by repositories ONLY. Nothing outside repositories/ may know SQLSTATEs.

import pg from 'pg';
import { ConflictError, InternalError } from '../lib/errors.js';

const { DatabaseError } = pg;

const CONNECTION_ERROR_CODES = new Set([
    'ECONNREFUSED',
    'ECONNRESET',
    'ECONNABORTED',
    'ETIMEDOUT',
    'EHOSTUNREACH',
    'ENETUNREACH',
    'EAI_AGAIN',
]);

const CONSTRAINT_MAP = {
    bookings_no_overlap: {
        sqlstate: '23P01',
        errorClass: ConflictError,
        code: 'SLOT_TAKEN',
        message: 'Booking overlaps with an existing booking.',
        clientMessage: 'This time slot is already booked.',
    },
    bookings_status_transition_check: {
        sqlstate: '23514',
        errorClass: ConflictError,
        code: 'INVALID_STATUS_TRANSITION',
        message: 'Invalid booking status transition.',
        clientMessage: 'This booking cannot be moved to the selected status.',
    },
};

export function translate(err) {

    if (!(err instanceof DatabaseError)) {
        if (
            typeof err?.code === 'string' &&
            CONNECTION_ERROR_CODES.has(err.code)
        ) {
            return new InternalError({
                code: 'DB_UNAVAILABLE',
                message: 'Database connection is unavailable.',
                clientMessage: 'The service is temporarily unavailable.',
                cause: err,
            });
        }

        return new InternalError({
            code: 'INTERNAL_ERROR',
            message: 'Unexpected internal error.',
            clientMessage: 'Unexpected server error.',
            cause: err,
        });
    }

    const constraintOfError =
        Object.hasOwn(CONSTRAINT_MAP, err.constraint)
            ? CONSTRAINT_MAP[err.constraint]
            : undefined;

    if (
        constraintOfError !== undefined &&
        err.code === constraintOfError.sqlstate
    ) {
        return new constraintOfError.errorClass({
            code: constraintOfError.code,
            message: constraintOfError.message,
            clientMessage: constraintOfError.clientMessage,
            cause: err,
        });
    }

    return new InternalError({
        code: 'UNMAPPED_DB_ERROR',
        message: 'Unmapped PostgreSQL error.',
        clientMessage: 'Unexpected server error.',
        cause: err,
    });
}