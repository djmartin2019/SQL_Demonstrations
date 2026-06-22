-- 4.	Get the top 5 longest films (by length).

SELECT title, length
FROM film
ORDER BY length DESC
FETCH FIRST 5 ROWS WITH TIES;
