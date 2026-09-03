-- Constraint tests.
-- Run after schema.sql and seed.sql.
-- Intended for psql or Supabase CLI.
-- Run with -v ON_ERROR_STOP=1 so the first failure aborts the file.

BEGIN;


-- A test user is created inside the transaction (and rolled back with it),
-- so the file has no precondition on the database's existing auth state.
-- The on_auth_user_created trigger fills public.profiles from this row.
INSERT INTO auth.users (id, email)
VALUES (
    '00000000-0000-0000-0000-0000000000aa',
    'constraint-test@example.invalid'
);

INSERT INTO public.products (
    id,
    product_type,
    name
)
VALUES
    (900, 'machine', 'Constraint Test Machine'),
    (901, 'coffee', 'Constraint Test Coffee'),
    (902, 'coffee', 'Constraint Test Coffee 2'),
    (903, 'coffee', 'Constraint Test Coffee 3');


INSERT INTO public.retailers (
    id,
    name,
    website_url,
    affiliate_id
)
VALUES (
    900,
    'Constraint Test Retailer',
    'https://example.com',
    'constraint_test'
);


-- machine_details with a coffee product
DO $$
BEGIN
    INSERT INTO public.machine_details (
        product_id,
        product_type,
        machine_type,
        accepted_forms,
        has_milk_frother,
        has_pid,
        has_dual_boiler,
        pump_pressure_bar
    )
    VALUES (
        901,
        'machine',
        'semi_automatic',
        ARRAY['ground', 'whole_bean'],
        true,
        true,
        false,
        9
    );

    RAISE EXCEPTION 'TEST FAILED: coffee product accepted as machine';
EXCEPTION
    WHEN foreign_key_violation THEN
        NULL;
END
$$;


-- valid machine_details
INSERT INTO public.machine_details (
    product_id,
    product_type,
    machine_type,
    accepted_forms,
    has_milk_frother,
    has_pid,
    has_dual_boiler,
    pump_pressure_bar
)
VALUES (
    900,
    'machine',
    'semi_automatic',
    ARRAY['ground', 'whole_bean'],
    true,
    true,
    false,
    9
);


-- invalid accepted_forms
DO $$
BEGIN
    INSERT INTO public.machine_details (
        product_id,
        product_type,
        machine_type,
        accepted_forms,
        has_milk_frother,
        has_pid,
        has_dual_boiler,
        pump_pressure_bar
    )
    VALUES (
        900,
        'machine',
        'semi_automatic',
        ARRAY['pods'],
        true,
        true,
        false,
        9
    );

    RAISE EXCEPTION 'TEST FAILED: invalid accepted_form was accepted';
EXCEPTION
    WHEN check_violation THEN
        NULL;
END
$$;


-- empty accepted_forms
DO $$
BEGIN
    INSERT INTO public.machine_details (
        product_id,
        product_type,
        machine_type,
        accepted_forms,
        has_milk_frother,
        has_pid,
        has_dual_boiler,
        pump_pressure_bar
    )
    VALUES (
        900,
        'machine',
        'semi_automatic',
        ARRAY[]::TEXT[],
        true,
        true,
        false,
        9
    );

    RAISE EXCEPTION 'TEST FAILED: empty accepted_forms was accepted';
EXCEPTION
    WHEN check_violation THEN
        NULL;
END
$$;


-- capsule machine with whole_bean
DO $$
BEGIN
    INSERT INTO public.machine_details (
        product_id,
        product_type,
        machine_type,
        accepted_forms,
        has_milk_frother,
        has_pid,
        has_dual_boiler,
        pump_pressure_bar
    )
    VALUES (
        900,
        'machine',
        'capsule',
        ARRAY['whole_bean'],
        false,
        false,
        false,
        9
    );

    RAISE EXCEPTION 'TEST FAILED: invalid capsule machine was accepted';
EXCEPTION
    WHEN check_violation THEN
        NULL;
END
$$;


-- empty shop services
DO $$
BEGIN
    INSERT INTO public.shops (
        id,
        name,
        address,
        location,
        services
    )
    VALUES (
        900,
        'Invalid Test Shop',
        'Test Address',
        extensions.ST_Point(23.59, 46.77)::extensions.geography,
        ARRAY[]::TEXT[]
    );

    RAISE EXCEPTION 'TEST FAILED: empty services was accepted';
EXCEPTION
    WHEN check_violation THEN
        NULL;
END
$$;


-- invalid shop hours
DO $$
BEGIN
    INSERT INTO public.shop_hours (
        shop_id,
        weekday,
        opens,
        closes
    )
    VALUES (
        1,
        1,
        '18:00',
        '09:00'
    );

    RAISE EXCEPTION 'TEST FAILED: invalid shop hours were accepted';
EXCEPTION
    WHEN check_violation THEN
        NULL;
END
$$;


-- duplicate price
INSERT INTO public.prices (
    product_id,
    retailer_id,
    amount,
    currency,
    url
)
VALUES (
    901,
    900,
    20.00,
    'RON',
    'https://example.com/first'
);


DO $$
BEGIN
    INSERT INTO public.prices (
        product_id,
        retailer_id,
        amount,
        currency,
        url
    )
    VALUES (
        901,
        900,
        25.00,
        'RON',
        'https://example.com/second'
    );

    RAISE EXCEPTION 'TEST FAILED: duplicate price was accepted';
EXCEPTION
    WHEN unique_violation THEN
        NULL;
END
$$;


-- negative price
DO $$
BEGIN
    INSERT INTO public.prices (
        product_id,
        retailer_id,
        amount,
        currency,
        url
    )
    VALUES (
        902,
        900,
        -5.00,
        'RON',
        'https://example.com/negative'
    );

    RAISE EXCEPTION 'TEST FAILED: negative amount was accepted';
EXCEPTION
    WHEN check_violation THEN
        NULL;
END
$$;


-- lowercase currency
DO $$
BEGIN
    INSERT INTO public.prices (
        product_id,
        retailer_id,
        amount,
        currency,
        url
    )
    VALUES (
        903,
        900,
        10.00,
        'ron',
        'https://example.com/lowercase'
    );

    RAISE EXCEPTION 'TEST FAILED: invalid currency was accepted';
EXCEPTION
    WHEN check_violation THEN
        NULL;
END
$$;


-- valid price
INSERT INTO public.prices (
    product_id,
    retailer_id,
    amount,
    currency,
    url
)
VALUES (
    903,
    900,
    10.00,
    'RON',
    'https://example.com/valid'
);


-- valid review
INSERT INTO public.reviews (
    profile_id,
    product_id,
    rating,
    body
)
VALUES (
    '00000000-0000-0000-0000-0000000000aa',
    901,
    5,
    'Valid test review.'
);


-- duplicate review
DO $$
BEGIN
    INSERT INTO public.reviews (
        profile_id,
        product_id,
        rating,
        body
    )
    VALUES (
        '00000000-0000-0000-0000-0000000000aa',
        901,
        4,
        'Duplicate test review.'
    );

    RAISE EXCEPTION 'TEST FAILED: duplicate review was accepted';
EXCEPTION
    WHEN unique_violation THEN
        NULL;
END
$$;


-- invalid rating
DO $$
BEGIN
    INSERT INTO public.reviews (
        profile_id,
        product_id,
        rating,
        body
    )
    VALUES (
        '00000000-0000-0000-0000-0000000000aa',
        902,
        6,
        'Invalid rating.'
    );

    RAISE EXCEPTION 'TEST FAILED: invalid rating was accepted';
EXCEPTION
    WHEN check_violation THEN
        NULL;
END
$$;


-- valid collection
INSERT INTO public.collections (
    profile_id,
    product_id,
    status
)
VALUES (
    '00000000-0000-0000-0000-0000000000aa',
    901,
    'tried'
);


-- duplicate collection
DO $$
BEGIN
    INSERT INTO public.collections (
        profile_id,
        product_id,
        status
    )
    VALUES (
        '00000000-0000-0000-0000-0000000000aa',
        901,
        'want_to_try'
    );

    RAISE EXCEPTION 'TEST FAILED: duplicate collection was accepted';
EXCEPTION
    WHEN unique_violation THEN
        NULL;
END
$$;


ROLLBACK;