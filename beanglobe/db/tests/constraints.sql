--TESTING THE PRODUCTS AND COFFEE DETAILS DATABASE

INSERT INTO public.products (id, product_type, name)
VALUES
    (2, 'machine', 'Test Machine'),
    (3, 'coffee', 'Test Coffee'),
    (4, 'coffee', 'Test Coffee 2'),
    (5, 'coffee', 'Test Coffee 3');

INSERT INTO public.coffee_details (
    product_id,
    product_type,
    form,
    roast,
    origin,
    process,
    tasting_notes,
    aroma,
    flavor,
    aftertaste,
    acidity,
    sweetness,
    mouthfeel,
    floral,
    fruity,
    sour_fermented,
    green_vegetative,
    roasted,
    nutty_cocoa,
    spicy,
    sweet
)
VALUES (
    2,
    'coffee',
    'whole_bean',
    'medium',
    'Brazil',
    'natural',
    'test',
    5, 5, 5, 5, 5, 5,
    5, 5, 5, 5, 5, 5, 5, 5
);

INSERT INTO public.coffee_details (
    product_id,
    product_type,
    form,
    roast,
    origin,
    process,
    tasting_notes,
    aroma,
    flavor,
    aftertaste,
    acidity,
    sweetness,
    mouthfeel,
    floral,
    fruity,
    sour_fermented,
    green_vegetative,
    roasted,
    nutty_cocoa,
    spicy,
    sweet
)
VALUES (
    3,
    'coffee',
    'whole_bean',
    'medium',
    'Ethiopia',
    'washed',
    'floral and citrus',
    8, 8, 7, 9, 8, 7,
    8, 9, 5, 2, 3, 7, 2, 4
);

INSERT INTO public.coffee_details (
    product_id,
    product_type,
    form,
    roast,
    origin,
    process,
    tasting_notes,
    aroma,
    flavor,
    aftertaste,
    acidity,
    sweetness,
    mouthfeel,
    floral,
    fruity,
    sour_fermented,
    green_vegetative,
    roasted,
    nutty_cocoa,
    spicy,
    sweet
)
VALUES (
    3,
    'coffee',
    'ground',
    'dark',
    'Brazil',
    'natural',
    'another test',
    5, 5, 5, 5, 5, 5,
    5, 5, 5, 5, 5, 5, 5, 5
);

INSERT INTO public.coffee_details (
    product_id,
    product_type,
    form,
    roast,
    origin,
    process,
    tasting_notes,
    aroma,
    flavor,
    aftertaste,
    acidity,
    sweetness,
    mouthfeel,
    floral,
    fruity,
    sour_fermented,
    green_vegetative,
    roasted,
    nutty_cocoa,
    spicy,
    sweet
)
VALUES (
    4,
    'coffee',
    'whole_bean',
    'medium',
    'Ethiopia',
    'natural',
    'test',
    16,
    5, 5, 5, 5, 5,
    5, 5, 5, 5, 5, 5, 5, 5
);

INSERT INTO public.coffee_details (
    product_id,
    product_type,
    form,
    roast,
    origin,
    process,
    tasting_notes,
    aroma,
    flavor,
    aftertaste,
    acidity,
    sweetness,
    mouthfeel,
    floral,
    fruity,
    sour_fermented,
    green_vegetative,
    roasted,
    nutty_cocoa,
    spicy,
    sweet
)
VALUES (
    5,
    'coffee',
    'whole_bean',
    'medium',
    'Brazil',
    'unknown',
    'test',
    5, 5, 5, 5, 5, 5,
    5, 5, 5, 5, 5, 5, 5, 5
);

INSERT INTO public.products (id, product_type, name)
VALUES (6, 'coffee', 'Valid Coffee');
INSERT INTO public.coffee_details (
    product_id,
    product_type,
    form,
    roast,
    origin,
    process,
    tasting_notes,
    aroma,
    flavor,
    aftertaste,
    acidity,
    sweetness,
    mouthfeel,
    floral,
    fruity,
    sour_fermented,
    green_vegetative,
    roasted,
    nutty_cocoa,
    spicy,
    sweet
)
VALUES (
    6,
    'coffee',
    'whole_bean',
    'medium',
    'Ethiopia',
    'natural',
    'blueberry, floral, chocolate',
    8, 9, 8, 7, 8, 7,
    9, 10, 2, 1, 3, 7, 2, 8
);


--TESTING THE MACHINE DETAILS DATABASE--------------------------------------------------------------------------------------------------

INSERT INTO public.products (id, product_type, name)
VALUES (7, 'coffee', 'Test Coffee');

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
    7,
    'machine',
    'semi_automatic',
    ARRAY['whole_bean', 'ground'],
    true,
    true,
    false,
    9
);

-- 1. coffee producthoz próbálunk machine_details-t
INSERT INTO public.products (id, product_type, name)
VALUES (7, 'coffee', 'Test Coffee');

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
    7,
    'machine',
    'semi_automatic',
    ARRAY['whole_bean', 'ground'],
    true,
    true,
    false,
    9
);

-- 2. Érvénytelen accepted_form
INSERT INTO public.products (id, product_type, name)
VALUES (8, 'machine', 'Test Machine');

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
    8,
    'machine',
    'semi_automatic',
    ARRAY['pods'],
    true,
    true,
    false,
    9
);

INSERT INTO public.products (id, product_type, name)
VALUES
    (7, 'coffee', 'Test Coffee'),
    (8, 'machine', 'Test Machine');

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
    8,
    'machine',
    'semi_automatic',
    ARRAY['pods'],
    true,
    true,
    false,
    9
);

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
    8,
    'machine',
    'semi_automatic',
    ARRAY[]::TEXT[],
    true,
    true,
    false,
    9
);

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
    8,
    'machine',
    'capsule',
    ARRAY['whole_bean'],
    false,
    false,
    false,
    9
);

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
    8,
    'machine',
    'semi_automatic',
    ARRAY['ground', 'whole_bean'],
    true,
    true,
    false,
    9
);

---PRICES AND RETAILERS-------------------------------------------------------------------------------------------------

INSERT INTO public.products (id, product_type, name)
VALUES (10, 'coffee', 'Test Coffee');

INSERT INTO public.retailers (id, name, website_url, affiliate_id)
VALUES (1, 'Test Retailer', 'https://example.com', 'AFF123');

INSERT INTO public.prices (
    product_id,
    retailer_id,
    amount,
    currency,
    url
)
VALUES (
    10,
    1,
    29.99,
    'RON',
    'https://example.com/test-coffee'
);

INSERT INTO public.prices (
    product_id,
    retailer_id,
    amount,
    currency,
    url
)
VALUES (
    10,
    1,
    -5.00,
    'RON',
    'https://example.com/test-coffee'
);

INSERT INTO public.prices (
    product_id,
    retailer_id,
    amount,
    currency,
    url
)
VALUES (
    10,
    1,
    29.99,
    'RON',
    'https://example.com/test-coffee'
);

INSERT INTO public.prices (
    product_id,
    retailer_id,
    amount,
    currency,
    url
)
VALUES (
    10,
    1,
    29.99,
    'ron',
    'https://example.com/test'
);

--------------------------------SHOPS & SHOP HOURS ------------------------------------------------------------

INSERT INTO public.shops (
    id,
    name,
    address,
    location,
    services,
    is_demo
)
VALUES
(
    1,
    'Test Cafe A',
    'Test Address A',
    extensions.ST_SetSRID(
        extensions.ST_Point(23.5899, 46.7696),
        4326
    )::extensions.geography,
    ARRAY['cafe', 'service'],
    true
),
(
    2,
    'Test Cafe B',
    'Test Address B',
    extensions.ST_SetSRID(
        extensions.ST_Point(23.6100, 46.7700),
        4326
    )::extensions.geography,
    ARRAY['cafe', 'shop'],
    true
);

SELECT id, name
FROM public.shops
WHERE extensions.ST_DWithin(
    location,
    extensions.ST_SetSRID(
        extensions.ST_Point(23.5899, 46.7696),
        4326
    )::extensions.geography,
    1000
);

INSERT INTO public.shops (
    id,
    name,
    address,
    location,
    services
)
VALUES (
    3,
    'Invalid Shop',
    'Test Address',
    extensions.ST_SetSRID(
        extensions.ST_Point(23.5950, 46.7700),
        4326
    )::extensions.geography,
    ARRAY[]::TEXT[]
);

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

INSERT INTO public.shop_hours (
    shop_id,
    weekday,
    opens,
    closes
)
VALUES (
    1,
    1,
    '09:00',
    '18:00'
);

----------------------------------------------------REVIEWS & COLLECTIONS--------------------------------------------------------------

-- Test data
INSERT INTO public.products (id, product_type, name)
VALUES
    (20, 'coffee', 'Review Test Coffee'),
    (21, 'coffee', 'Rating Test Coffee'),
    (22, 'coffee', 'Update Test Coffee');

    INSERT INTO public.reviews (
    profile_id,
    product_id,
    rating,
    body
)
VALUES (
    'bb68c013-d690-43a1-b76f-fe9384c8ae88',
    20,
    5,
    'Great coffee.'
);

INSERT INTO public.reviews (
    profile_id,
    product_id,
    rating,
    body
)
VALUES (
    'bb68c013-d690-43a1-b76f-fe9384c8ae88',
    20,
    4,
    'Second review.'
);

INSERT INTO public.reviews (
    profile_id,
    product_id,
    rating,
    body
)
VALUES (
    'bb68c013-d690-43a1-b76f-fe9384c8ae88',
    21,
    6,
    'Invalid rating.'
);

INSERT INTO public.collections (
    profile_id,
    product_id,
    status
)
VALUES (
    'bb68c013-d690-43a1-b76f-fe9384c8ae88',
    20,
    'tried'
);

INSERT INTO public.collections (
    profile_id,
    product_id,
    status
)
VALUES (
    'bb68c013-d690-43a1-b76f-fe9384c8ae88',
    20,
    'want_to_try'
);

INSERT INTO public.reviews (
    profile_id,
    product_id,
    rating,
    body
)
VALUES (
    'bb68c013-d690-43a1-b76f-fe9384c8ae88',
    22,
    4,
    'Initial review.'
);

SELECT rating, updated_at
FROM public.reviews
WHERE profile_id = 'bb68c013-d690-43a1-b76f-fe9384c8ae88'
  AND product_id = 22;

  UPDATE public.reviews
SET rating = 5
WHERE profile_id = 'bb68c013-d690-43a1-b76f-fe9384c8ae88'
  AND product_id = 22;

  SELECT rating, updated_at
FROM public.reviews
WHERE profile_id = 'bb68c013-d690-43a1-b76f-fe9384c8ae88'
  AND product_id = 22;

  INSERT INTO public.reviews (
    profile_id,
    product_id,
    rating,
    body
)
VALUES (
    'bb68c013-d690-43a1-b76f-fe9384c8ae88',
    21,
    5,
    'Excellent coffee.'
);

INSERT INTO public.collections (
    profile_id,
    product_id,
    status
)
VALUES (
    'bb68c013-d690-43a1-b76f-fe9384c8ae88',
    21,
    'want_to_try'
);

--------------------------------------------------BOOKINGS------------------------------------------------------------------------