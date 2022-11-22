with loader as (
    SELECT DISTINCT station,
        play_ts,
        play_ts_zone,
        artist_id,
        album_id,
        track_id,
        capture_ts
    FROM plays_load
    where station <> 'station'
),
existing as (
    SELECT DISTINCT station as exist_station,
        play_ts as exist_play_ts
    FROm plays
),
new as (
    select ldr.*
    from loader as ldr
        LEFT join existing as exs on (
            ldr.station = exs.exist_station
            and ldr.play_ts = exs.exist_play_ts
        )
    WHERE exs.exist_station IS NULL
)
INSERT INTO plays (
        station,
        play_ts,
        play_ts_zone,
        artist_id,
        album_id,
        track_id,
        capture_ts
    )
SELECT *
from new