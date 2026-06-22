-- 3.	Show the number of films in each category.

SELECT c.name AS category_name, COUNT(*) film_count
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON c.category_id = fc.category_id
GROUP BY category_name
ORDER BY film_count DESC;
