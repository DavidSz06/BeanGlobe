//errors.js

export class AppError extends Error {
    constructor({ code, message, clientMessage, details = null, cause = undefined } = {}) {
        if (
            code === undefined ||
            message === undefined ||
            clientMessage === undefined
        ) {
            throw new TypeError("code, message and clientMessage are required", cause === undefined ? {} : { cause });

        }

        super(message, cause === undefined ? {} : { cause });

        this.name = this.constructor.name;
        this.code = code;
        this.clientMessage = clientMessage;
        this.details = details;
    }
}

export class NotFoundError extends AppError {}

export class ConflictError extends AppError {}

export class ValidationError extends AppError {}

export class InternalError extends AppError {
    constructor({ code, message, clientMessage = "Unexpected server error.", details = null, cause = undefined } = {}) {
        super({ code, message, clientMessage, details, cause });
    }
}