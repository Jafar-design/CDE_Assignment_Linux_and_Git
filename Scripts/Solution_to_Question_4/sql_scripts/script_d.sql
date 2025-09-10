SELECT r.name, sr.name, a.name FROM
public.sales_reps AS sr 
LEFT JOIN public.region AS r 
ON sr.region_id = r.id
LEFT JOIN public.accounts AS a
ON sr.id = a.sales_rep_id