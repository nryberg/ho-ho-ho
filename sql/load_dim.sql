SELECT cast(lookup_code as bigint) as artist_id,
    lookup_name as artist_name,
    lookup_ref as artist_ref
FROM public.load_dimension
where lookup_code <> 'artist'