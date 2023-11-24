+++
title = 'Uniques'
date = 2023-11-24T10:06:59-06:00
draft = true
+++

The Ho-Ho-Ho website is coming together, and now I'm struggling with the uniques.  There's a bit of cruft with songs from non-holiday artists. 

More frustrating is the titles that are almost but not exactly the same.  Some are legit, others are just mispellings.  

For example, I have two `Adestes Fideles` songs, one is spelled `Fideles` and the other is `Fidelis`.  The correct spelling is `Fideles`. 

So the question is how to correctly identify the mixed up version and combine it with the correct version.  Since the songs are identified with a unique number, I should be able to swap them with SQL.

The following is the hard way to do it.  

```sql
WITH bad as (
    SELECT title_ref as bad_ref
    FROM track_history
    WHERE title like '%Fidelis%'
), good as (
        SELECT title_ref as good_ref
    FROM track_history
    WHERE title like '%Fideles%'
)
UPDATE track_history SET
title_ref = good_ref
WHERE title_ref = bad_ref
```

If I'm doing a list from a CSV file, that'd be more work to set up.  But more doable. 

