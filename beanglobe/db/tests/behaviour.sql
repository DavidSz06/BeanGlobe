-- Behaviour tests.
-- Run after schema.sql and seed.sql.
-- Requires the seeded shops (see seeds/seed.sql).
-- Intended for psql or Supabase CLI.
-- Run with -v ON_ERROR_STOP=1 so the first failure aborts the file.

BEGIN;


-- A test user is created inside the transaction (and rolled back with it),
-- so the file has no precondition on the database's existing auth state.
-- The on_auth_user_created trigger fills public.profiles from this row.
INSERT INTO auth.users (id, email)
VALUES (
    '00000000-0000-0000-0000-0000000000aa',
    'behaviour-test@example.invalid'
);

INSERT INTO public.bookings (
    profile_id,
    shop_id,
    service,
    starts_at,
    ends_at
)
VALUES (
    '00000000-0000-0000-0000-0000000000aa',
    1,
    'consultation',
    '2027-01-10 09:00:00+02',
    '2027-01-10 09:30:00+02'
);


DO $$
BEGIN
    INSERT INTO public.bookings (
        profile_id,
        shop_id,
        service,
        starts_at,
        ends_at,
        status
    )
    VALUES (
        '00000000-0000-0000-0000-0000000000aa',
        1,
        'workshop',
        '2027-01-10 09:15:00+02',
        '2027-01-10 09:45:00+02',
        'pending'
    );

    RAISE EXCEPTION
        'TEST FAILED: overlapping booking was accepted';
EXCEPTION
    WHEN exclusion_violation THEN
        NULL;
END
$$;


-- Adjacent slot must succeed.
INSERT INTO public.bookings (
    profile_id,
    shop_id,
    service,
    starts_at,
    ends_at,
    status
)
VALUES (
    '00000000-0000-0000-0000-0000000000aa',
    1,
    'workshop',
    '2027-01-10 09:30:00+02',
    '2027-01-10 10:00:00+02',
    'pending'
);


-- Create cancelled booking through a valid state transition.
INSERT INTO public.bookings (
    profile_id,
    shop_id,
    service,
    starts_at,
    ends_at
)
VALUES (
    '00000000-0000-0000-0000-0000000000aa',
    1,
    'repair',
    '2027-01-10 10:00:00+02',
    '2027-01-10 10:30:00+02'
);

UPDATE public.bookings
SET status = 'cancelled'
WHERE shop_id = 1
  AND starts_at = '2027-01-10 10:00:00+02';


-- Overlap with cancelled booking must succeed.
INSERT INTO public.bookings (
    profile_id,
    shop_id,
    service,
    starts_at,
    ends_at,
    status
)
VALUES (
    '00000000-0000-0000-0000-0000000000aa',
    1,
    'consultation',
    '2027-01-10 10:15:00+02',
    '2027-01-10 10:45:00+02',
    'pending'
);


-- Invalid initial state.
DO $$
BEGIN
    INSERT INTO public.bookings (
        profile_id,
        shop_id,
        service,
        starts_at,
        ends_at,
        status
    )
    VALUES (
        '00000000-0000-0000-0000-0000000000aa',
        1,
        'repair',
        '2027-01-10 11:00:00+02',
        '2027-01-10 11:30:00+02',
        'cancelled'
    );

    RAISE EXCEPTION
        'TEST FAILED: non-pending initial status was accepted';
EXCEPTION
    WHEN check_violation THEN
        NULL;
END
$$;


-- Create booking for state transition test.
INSERT INTO public.bookings (
    profile_id,
    shop_id,
    service,
    starts_at,
    ends_at
)
VALUES (
    '00000000-0000-0000-0000-0000000000aa',
    1,
    'consultation',
    '2027-01-10 12:00:00+02',
    '2027-01-10 12:30:00+02'
);


UPDATE public.bookings
SET status = 'confirmed'
WHERE shop_id = 1
  AND starts_at = '2027-01-10 12:00:00+02';


UPDATE public.bookings
SET status = 'completed'
WHERE shop_id = 1
  AND starts_at = '2027-01-10 12:00:00+02';


-- completed -> pending must fail.
DO $$
BEGIN
    UPDATE public.bookings
    SET status = 'pending'
    WHERE shop_id = 1
      AND starts_at = '2027-01-10 12:00:00+02';

    RAISE EXCEPTION
        'TEST FAILED: completed -> pending was accepted';
EXCEPTION
    WHEN check_violation THEN
        NULL;
END
$$;


-- updated_at behaviour on bookings.
-- CURRENT_TIMESTAMP is the transaction start time, so a row inserted and
-- updated inside this transaction would keep identical timestamps regardless
-- of the trigger. The row is therefore inserted with backdated timestamps:
-- the update must advance updated_at while leaving created_at untouched.
INSERT INTO public.bookings (
    profile_id,
    shop_id,
    service,
    starts_at,
    ends_at,
    created_at,
    updated_at
)
VALUES (
    '00000000-0000-0000-0000-0000000000aa',
    1,
    'consultation',
    '2027-01-10 13:00:00+02',
    '2027-01-10 13:30:00+02',
    '2000-01-01 00:00:00+02',
    '2000-01-01 00:00:00+02'
);


DO $$
DECLARE
    created_before TIMESTAMPTZ;
    updated_before TIMESTAMPTZ;
    created_after TIMESTAMPTZ;
    updated_after TIMESTAMPTZ;
BEGIN
    SELECT created_at, updated_at
    INTO created_before, updated_before
    FROM public.bookings
    WHERE shop_id = 1
      AND starts_at = '2027-01-10 13:00:00+02';

    UPDATE public.bookings
    SET service = 'repair'
    WHERE shop_id = 1
      AND starts_at = '2027-01-10 13:00:00+02';

    SELECT created_at, updated_at
    INTO created_after, updated_after
    FROM public.bookings
    WHERE shop_id = 1
      AND starts_at = '2027-01-10 13:00:00+02';

    IF created_after <> created_before THEN
        RAISE EXCEPTION
            'TEST FAILED: created_at changed on update (% -> %)',
            created_before, created_after;
    END IF;

    IF updated_after <= updated_before THEN
        RAISE EXCEPTION
            'TEST FAILED: updated_at was not advanced by the trigger (% -> %)',
            updated_before, updated_after;
    END IF;
END
$$;
-- updated_at behaviour on prices.
-- Same backdating trick as above. public.prices has no created_at column,
-- so only the advance of updated_at is asserted.
INSERT INTO public.products (
    id,
    product_type,
    name
)
VALUES (910, 'coffee', 'Behaviour Test Coffee');


INSERT INTO public.retailers (
    id,
    name,
    website_url,
    affiliate_id
)
VALUES (
    910,
    'Behaviour Test Retailer',
    'https://example.com',
    'behaviour_test'
);


INSERT INTO public.prices (
    product_id,
    retailer_id,
    amount,
    currency,
    url,
    updated_at
)
VALUES (
    910,
    910,
    20.00,
    'RON',
    'https://example.com/behaviour',
    '2000-01-01 00:00:00+02'
);


DO $$
DECLARE
    updated_before TIMESTAMPTZ;
    updated_after TIMESTAMPTZ;
BEGIN
    SELECT updated_at
    INTO updated_before
    FROM public.prices
    WHERE product_id = 910
      AND retailer_id = 910;

    UPDATE public.prices
    SET amount = 25.00
    WHERE product_id = 910
      AND retailer_id = 910;

    SELECT updated_at
    INTO updated_after
    FROM public.prices
    WHERE product_id = 910
      AND retailer_id = 910;

    IF updated_after <= updated_before THEN
        RAISE EXCEPTION
            'TEST FAILED: prices.updated_at was not advanced by the trigger (% -> %)',
            updated_before, updated_after;
    END IF;
END
$$;


-- updated_at behaviour on reviews.
INSERT INTO public.reviews (
    profile_id,
    product_id,
    rating,
    body,
    created_at,
    updated_at
)
VALUES (
    '00000000-0000-0000-0000-0000000000aa',
    910,
    4,
    'Behaviour test review.',
    '2000-01-01 00:00:00+02',
    '2000-01-01 00:00:00+02'
);


DO $$
DECLARE
    created_before TIMESTAMPTZ;
    updated_before TIMESTAMPTZ;
    created_after TIMESTAMPTZ;
    updated_after TIMESTAMPTZ;
BEGIN
    SELECT created_at, updated_at
    INTO created_before, updated_before
    FROM public.reviews
    WHERE profile_id = '00000000-0000-0000-0000-0000000000aa'
      AND product_id = 910;

    UPDATE public.reviews
    SET rating = 5
    WHERE profile_id = '00000000-0000-0000-0000-0000000000aa'
      AND product_id = 910;

    SELECT created_at, updated_at
    INTO created_after, updated_after
    FROM public.reviews
    WHERE profile_id = '00000000-0000-0000-0000-0000000000aa'
      AND product_id = 910;

    IF created_after <> created_before THEN
        RAISE EXCEPTION
            'TEST FAILED: reviews.created_at changed on update (% -> %)',
            created_before, created_after;
    END IF;

    IF updated_after <= updated_before THEN
        RAISE EXCEPTION
            'TEST FAILED: reviews.updated_at was not advanced by the trigger (% -> %)',
            updated_before, updated_after;
    END IF;
END
$$;


ROLLBACK;
