INSERT INTO public.products (
    id,
    product_type,
    name,
    brand,
    image_url
)
VALUES
    (1, 'coffee', 'Qualità Rossa', 'Lavazza', NULL),
    (2, 'coffee', 'Arabica Selection', 'Lavazza', NULL),
    (3, 'coffee', 'Illy Classico', 'Illy', NULL),
    (4, 'coffee', 'Kimbo Espresso Napoletano', 'Kimbo', NULL),
    (5, 'machine', 'Dedica EC685', 'De''Longhi', NULL),
    (6, 'machine', 'Magnifica S', 'De''Longhi', NULL),
    (7, 'machine', 'Barista Express', 'Sage', NULL),
    (8, 'machine', 'Essenza Mini', 'Nespresso', NULL);


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
VALUES
(
    1, 'coffee', 'whole_bean', 'medium', 'Brazil',
    'natural',
    'Chocolate, roasted nuts, caramel',
    8, 9, 8, 5, 8, 8,
    1, 3, 1, 0, 8, 7, 3, 8
),
(
    2, 'coffee', 'whole_bean', 'light', 'Ethiopia',
    'washed',
    'Floral, citrus, stone fruit',
    9, 9, 8, 10, 8, 6,
    10, 10, 3, 2, 2, 3, 1, 4
),
(
    3, 'coffee', 'ground', 'medium', 'Brazil',
    'washed',
    'Chocolate, caramel, almond',
    8, 8, 8, 5, 9, 8,
    1, 2, 1, 0, 5, 8, 2, 9
),
(
    4, 'coffee', 'ground', 'dark', 'Brazil',
    'natural',
    'Dark chocolate, roasted, spice',
    8, 9, 9, 3, 7, 9,
    0, 1, 1, 0, 10, 7, 7, 7
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
VALUES
(
    5,
    'machine',
    'semi_automatic',
    ARRAY['ground', 'whole_bean'],
    true,
    false,
    false,
    15
),
(
    6,
    'machine',
    'superautomatic',
    ARRAY['whole_bean'],
    true,
    false,
    false,
    15
),
(
    7,
    'machine',
    'semi_automatic',
    ARRAY['ground', 'whole_bean'],
    true,
    true,
    false,
    15
),
(
    8,
    'machine',
    'capsule',
    ARRAY['capsule'],
    false,
    false,
    false,
    19
);


INSERT INTO public.retailers (
    id,
    name,
    website_url,
    affiliate_id
)
VALUES
    (1, 'eMAG', 'https://www.emag.ro', 'emag_demo'),
    (2, 'Coffee Friend', 'https://www.coffeefriend.ro', 'coffeefriend_demo'),
    (3, 'Altex', 'https://altex.ro', 'altex_demo');


INSERT INTO public.prices (
    product_id,
    retailer_id,
    amount,
    currency,
    url
)
VALUES
    (1, 1, 29.99, 'RON', 'https://example.com/lavazza-rossa'),
    (1, 2, 31.50, 'RON', 'https://example.com/lavazza-rossa'),
    (2, 1, 42.99, 'RON', 'https://example.com/lavazza-arabica'),
    (2, 2, 44.90, 'RON', 'https://example.com/lavazza-arabica'),
    (3, 1, 39.99, 'RON', 'https://example.com/illy-classico'),
    (3, 3, 41.49, 'RON', 'https://example.com/illy-classico'),
    (4, 1, 34.99, 'RON', 'https://example.com/kimbo-napoletano'),
    (4, 2, 36.90, 'RON', 'https://example.com/kimbo-napoletano'),
    (5, 1, 799.99, 'RON', 'https://example.com/dedica-ec685'),
    (5, 3, 829.99, 'RON', 'https://example.com/dedica-ec685'),
    (6, 1, 1499.99, 'RON', 'https://example.com/magnifica-s'),
    (6, 3, 1549.99, 'RON', 'https://example.com/magnifica-s'),
    (7, 1, 2499.99, 'RON', 'https://example.com/barista-express'),
    (7, 2, 2599.99, 'RON', 'https://example.com/barista-express'),
    (8, 1, 499.99, 'RON', 'https://example.com/essenza-mini'),
    (8, 3, 479.99, 'RON', 'https://example.com/essenza-mini');


INSERT INTO public.shops (
    id,
    name,
    address,
    phone,
    description,
    location,
    services,
    owner_id,
    is_demo
)
VALUES
(
    1,
    'Coffee Point Centru',
    'Strada Memorandumului 10, Cluj-Napoca',
    '+40 264 000 001',
    'Specialty coffee shop in the city center.',
    extensions.ST_Point(23.5899, 46.7696)::extensions.geography,
    ARRAY['cafe', 'service'],
    NULL,
    true
),
(
    2,
    'Brew Lab',
    'Strada Horea 18, Cluj-Napoca',
    '+40 264 000 002',
    'Coffee equipment and tasting space.',
    extensions.ST_Point(23.6015, 46.7750)::extensions.geography,
    ARRAY['cafe', 'shop'],
    NULL,
    true
),
(
    3,
    'Bean Workshop',
    'Calea Turzii 45, Cluj-Napoca',
    '+40 264 000 003',
    'Coffee service and machine workshop.',
    extensions.ST_Point(23.6025, 46.7540)::extensions.geography,
    ARRAY['service', 'shop'],
    NULL,
    true
);


INSERT INTO public.shop_hours (
    shop_id,
    weekday,
    opens,
    closes
)
VALUES
    (1, 1, '08:00', '18:00'),
    (1, 2, '08:00', '18:00'),
    (1, 3, '08:00', '18:00'),
    (1, 4, '08:00', '18:00'),
    (1, 5, '08:00', '18:00'),
    (1, 6, '09:00', '14:00'),

    (2, 1, '09:00', '19:00'),
    (2, 2, '09:00', '19:00'),
    (2, 3, '09:00', '19:00'),
    (2, 4, '09:00', '19:00'),
    (2, 5, '09:00', '19:00'),
    (2, 6, '10:00', '15:00'),

    (3, 1, '09:00', '17:00'),
    (3, 2, '09:00', '17:00'),
    (3, 3, '09:00', '17:00'),
    (3, 4, '09:00', '17:00'),
    (3, 5, '09:00', '17:00');


SELECT setval(
    pg_get_serial_sequence('public.products', 'id'),
    COALESCE((SELECT MAX(id) FROM public.products), 1),
    (SELECT COUNT(*) > 0 FROM public.products)
);

SELECT setval(
    pg_get_serial_sequence('public.retailers', 'id'),
    COALESCE((SELECT MAX(id) FROM public.retailers), 1),
    (SELECT COUNT(*) > 0 FROM public.retailers)
);

SELECT setval(
    pg_get_serial_sequence('public.shops', 'id'),
    COALESCE((SELECT MAX(id) FROM public.shops), 1),
    (SELECT COUNT(*) > 0 FROM public.shops)
);