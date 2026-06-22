-- 1. List all customers from Brazil
SELECT
    customer_id,
    first_name,
    last_name,
    country
FROM customer
WHERE country = 'Brazil';
