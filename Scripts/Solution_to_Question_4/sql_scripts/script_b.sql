SELECT * 
FROM public.orders WHERE CAST(standard_qty AS INT) = 0 AND
(CAST(gloss_qty AS INT) > 1000 or CAST(poster_qty AS INT) > 1000)
