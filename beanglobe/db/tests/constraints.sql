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


--TESTING THE MACHINE DETAILS DATABASE

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