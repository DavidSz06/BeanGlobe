SELECT setval(
    pg_get_serial_sequence('public.products', 'id'),
    COALESCE((SELECT MAX(id) FROM public.products), 1),
    (SELECT COUNT(*) > 0 FROM public.products)
);