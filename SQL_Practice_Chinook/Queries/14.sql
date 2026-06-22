-- 14. Which artist shows consistent growth in sales year-over-year?

WITH yoy AS (
    WITH artist_sales AS (
        SELECT
            a.artist_id,
            a.name AS artist_name,
            EXTRACT(YEAR FROM i.invoice_date) AS sales_year,
            SUM(il.unit_price * il.quantity) AS total_sales
        FROM invoice_line il
        JOIN invoice i ON il.invoice_id = i.invoice_id
        JOIN track t ON il.track_id = t.track_id
        JOIN album al ON t.album_id = al.album_id
        JOIN artist a ON al.artist_id = a.artist_id
        GROUP BY a.artist_id, a.name, sales_year
    )
    SELECT
        artist_id,
        artist_name,
        sales_year,
        total_sales,
        LAG(total_sales) OVER (PARTITION BY artist_id ORDER BY sales_year) AS prev_year_sales,
        (total_sales - LAG(total_sales) OVER (PARTITION BY artist_id ORDER BY sales_year)) AS yoy_growth
    FROM artist_sales
    ORDER BY artist_name, sales_year
)
SELECT artist_name
FROM yoy
GROUP BY artist_name
HAVING MIN(yoy_growth) > 0;
