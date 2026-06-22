-- 12. Identify the track(s) purchased the most times.

WITH track_sales AS (
    SELECT
        t.track_id,
        t.name AS track_name,
        SUM(il.quantity) AS units_sold
    FROM track t
    JOIN invoice_line il ON il.track_id = t.track_id
    GROUP BY t.track_id, t.name
),
rankings AS (
    SELECT
        track_id, track_name, units_sold,
        RANK() OVER (ORDER BY units_sold DESC) AS rnk
    FROM track_sales
)
SELECT track_id, track_name, units_sold
FROM rankings
WHERE rnk = 1;
