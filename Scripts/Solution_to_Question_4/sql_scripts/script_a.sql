SELECT id
	FROM public.orders WHERE (CAST(gloss_qty AS INT) > 4000 or CAST(poster_qty AS INT) > 4000)
	AND (gloss_qty IS NOT NULL AND poster_qty IS NOT NULL) 

    