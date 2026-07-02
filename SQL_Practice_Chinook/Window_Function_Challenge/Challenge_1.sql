WITH track_revenue AS (
    SELECT
        g.genre_id,
        g.name AS genre_name,
        t.track_id,
        t.name AS track_name,
        SUM(il.unit_price * il.quantity) AS track_revenue
    FROM invoice_line il
    JOIN track t
        ON il.track_id = t.track_id
    JOIN genre g
        ON t.genre_id = g.genre_id
    GROUP BY
        g.genre_id,
        g.name,
        t.track_id,
        t.name
),

scored AS (
    SELECT
        genre_name,
        track_name,
        track_revenue,

        SUM(track_revenue) OVER (
            PARTITION BY genre_id
        ) AS genre_revenue,

        track_revenue / SUM(track_revenue) OVER (
            PARTITION BY genre_id
        ) AS pct_of_genre,

        ROW_NUMBER() OVER (
            PARTITION BY genre_id
            ORDER BY track_revenue DESC, track_name
        ) AS rank_in_genre,

        LEAD(track_revenue) OVER (
            PARTITION BY genre_id
            ORDER BY track_revenue DESC, track_name
        ) AS next_track_revenue
    FROM track_revenue
)

SELECT
    genre_name,
    track_name,
    track_revenue,
    genre_revenue,
    pct_of_genre,
    rank_in_genre,
    CASE
        WHEN rank_in_genre = 3
        THEN track_revenue - next_track_revenue
        ELSE NULL
    END AS gap_to_next
FROM scored
WHERE rank_in_genre <= 3
ORDER BY
    genre_name,
    rank_in_genre;