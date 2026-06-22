# Pagila Database Practice

## 🍼 Junior-Level (warm-ups)
1.	List all customers from Canada.
```SQL
    SELECT
        c.first_name || ' ' || c.last_name AS customer_name,
        cnt.country
    FROM customer AS c
    JOIN address AS a ON a.address_id = c.address_id
    JOIN city AS cit ON a.city_id = cit.city_id
    JOIN country AS cnt ON cit.city_id = cnt.country_id
    WHERE cnt.country = 'Canada';
```
2.	Find all films released in 2006.
```SQL
    SELECT film_id, title, release_year
    FROM film
    WHERE release_year = 2006;
```
3.	Show the number of films in each category.
    ```SQL
    SELECT c.name AS category_name, COUNT(*) film_count
    FROM film AS f
    JOIN film_category AS fc ON f.film_id = fc.film_id
    JOIN category AS c ON c.category_id = fc.category_id
    GROUP BY category_name
    ORDER BY film_count DESC;
```
4.	Get the top 5 longest films (by length).
```SQL
    SELECT title, length
    FROM film
    ORDER BY length DESC
    FETCH FIRST 5 ROWS WITH TIES;
```
5.	Count how many rentals each staff member processed.
```SQL

```
6.	List all actors in the film Academy Dinosaur.
```SQL

```

⸻

## 🏋️ Mid-Level (business flavor)
	7.	Which customer has rented the most films?
    ```SQL

    ```
	8.	Who are the top 10 customers by total payment amount?
    ```SQL

    ```
	9.	Which film category generates the highest revenue?
    ```SQL

    ```
	10.	What’s the average rental duration per film category?
    ```SQL

    ```
	11.	Which staff member collected the most payment revenue?
    ```SQL

    ```
	12.	List films that were never rented.
    ```SQL

    ```

⸻

## 🧠 Advanced-Level (data engineer playground)
	13.	Show monthly rental revenue trends for 2005–2006.
    ```SQL

    ```
	14.	Identify films with consistently increasing rentals month-over-month.
    ```SQL

    ```
	15.	For each customer, calculate the average time gap between rentals.
    ```SQL

    ```
	16.	Find the top 3 rented films per store (use RANK or DENSE_RANK).
    ```SQL

    ```
	17.	Calculate discount impact if all rentals over 7 days long had been charged extra fees.
    ```SQL

    ```
	18.	Identify customers who rented the same film multiple times.
    ```SQL

    ```

⸻

## 🦉 Senior-Level (interview sweat)
	19.	Build a retention report: how many first-time renters in a given month came back within 90 days?
    ```SQL

    ```
	20.	Calculate customer lifetime value: total payments per customer, ranked by percentile.
    ```SQL

    ```
	21.	Compute rolling 3-month rental revenue per category.
    ```SQL

    ```
	22.	Detect churned customers: no rentals in past 6 months but ≥5 rentals before that.
    ```SQL

    ```
	23.	For each store, rank staff by rental revenue contribution.
    ```SQL

    ```
	24.	Cross-renting analysis: which categories are most often rented together by the same customer in a month?
    ```SQL

    ```

⸻

## 🚀 Extra-Senior Portfolio Ideas
	•	Rental KPIs dashboard: revenue, rentals, late fees, new vs returning customers.
	•	Customer segmentation: heavy renters, seasonal renters, one-time renters.
	•	Film category analysis: profitability, average rental length, popularity trends.

