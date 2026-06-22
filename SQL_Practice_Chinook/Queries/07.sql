-- 7. Which customer has spent the most overall?

WITH spend AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        SUM(i.total) AS total_spent
    FROM customer c
    JOIN invoice i ON i.customer_id = c.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *
FROM spend
WHERE total_spent = (SELECT MAX(total_spent) FROM spend);
