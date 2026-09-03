SELECT setval(
    pg_get_serial_sequence('public.products', 'id'),
    COALESCE((SELECT MAX(id) FROM public.products), 1),
    (SELECT COUNT(*) > 0 FROM public.products)
);

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