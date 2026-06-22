-- 9. List the top 5 genres by total sales.

SELECT
  g.genre_id,
  g.name AS genre_name,
  SUM(il.unit_price * il.quantity) AS total_revenue
FROM genre g
JOIN track t        ON t.genre_id = g.genre_id
JOIN invoice_line il ON il.track_id = t.track_id
GROUP BY g.genre_id, g.name
ORDER BY total_revenue DESC
LIMIT 5;
