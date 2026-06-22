-- 8. What are the top 10 selling artists by revenue?

SELECT
  a.artist_id,
  a.name AS artist_name,
  SUM(il.unit_price * il.quantity) AS total_revenue
FROM artist a
JOIN album  al ON al.artist_id = a.artist_id
JOIN track  t  ON t.album_id   = al.album_id
JOIN invoice_line il ON il.track_id = t.track_id
GROUP BY a.artist_id, a.name
ORDER BY total_revenue DESC
LIMIT 10;
