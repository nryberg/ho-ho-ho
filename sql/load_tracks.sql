with loader as (
    SELECT
        DISTINCT station,
        play_ts,
        play_ts_zone,
        artist_id,
        album_id,
        track_id,
        capture_ts
    FROM
        public.plays_load
    where
        station <> 'station'
)
INSERT INTO
    public.plays(
        station,
        play_ts,
        play_ts_zone,
        artist_id,
        album_id,
        track_id,
        capture_ts
    )
VALUES
    (?, ?, ?, ?, ?, ?, ?);