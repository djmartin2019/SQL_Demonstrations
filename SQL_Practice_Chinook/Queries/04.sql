-- 4. List the top 5 most expensive tracks by unit price.

SELECT track_id, name, MAX(unit_price)
FROM track
GROUP BY track_id
ORDER BY unit_price DESC;

