-- 1.	List all customers from Canada.

SELECT
    c.first_name || ' ' || c.last_name AS customer_name,
    cnt.country
FROM customer AS c
JOIN address AS a ON a.address_id = c.address_id
JOIN city AS cit ON a.city_id = cit.city_id
JOIN country AS cnt ON cit.city_id = cnt.country_id
WHERE cnt.country = 'Canada';
