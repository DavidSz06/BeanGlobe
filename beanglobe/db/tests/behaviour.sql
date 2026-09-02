SELECT amount, updated_at
FROM public.prices
WHERE product_id = 10
  AND retailer_id = 1;

UPDATE public.prices
SET amount = 27.50
WHERE product_id = 10
  AND retailer_id = 1;

SELECT amount, updated_at
FROM public.prices
WHERE product_id = 10
  AND retailer_id = 1;