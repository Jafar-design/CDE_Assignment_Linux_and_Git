select a.name FROM public.accounts AS a
JOIN public.sales_reps AS sr
ON a.sales_rep_id = sr.id
WHERE (a.name LIKE 'C%' OR a.name LIKE 'W%')
AND (a.name ILIKE '%ana%')
AND sr.name NOT LIKE '%eana%';