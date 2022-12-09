WITH artists AS (
    SELECT artist_id,
        artist_name
    FROM PUBLIC.artist a
),
plays_by_day AS (
    SELECT station,
        substring(play_ts, 0, 11) AS play_date,
        artist_id,
        play_ts
    FROM PUBLIC.plays p
),
play_counts AS (
    SELECT play_date,
        station,
        ar.artist_name,
        count(DISTINCT (play_ts)) AS play_count
    FROM plays_by_day p
        JOIN artists AS ar ON p.artist_id = ar.artist_id
    WHERE play_ts LIKE '2022%'
    GROUP BY station,
        ar.artist_name,
        play_date
),
high_count as (
    SELECT *
    FROM play_counts
    WHERE play_count > 10
    order by play_count desc
),
xmas as (
    select distinct station
    from high_count
)
select distinct plays.station
from plays
    left join xmas on plays.station = xmas.station
where xmas.station is null