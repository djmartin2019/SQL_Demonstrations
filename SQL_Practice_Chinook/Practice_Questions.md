# Chinook Database Practice

## Junior Level (Warm-Ups)
1. List all customers from Brazil
```SQL
    SELECT
        customer_id,
        first_name,
        last_name,
        country
    FROM customer
    WHERE country = 'Brazil';
```
2. Find all invoices from 2022.
```SQL
    SELECT
        invoice_id,
        customer_id,
        invoice_date
    FROM invoice
    WHERE EXTRACT(YEAR FROM invoice_date) = 2022
    ORDER BY invoice_date ASC;
```
3. Show the number of tracks in each playlist.
```SQL
    SELECT p.playlist_id, COUNT(*) AS track_count
    FROM playlist AS p
    JOIN playlist_track AS pt
    ON p.playlist_id = pt.playlist_id
    GROUP BY p.playlist_id
    ORDER BY track_count DESC;
```
4. List the top 5 most expensive tracks by unit price.
```SQL
    SELECT track_id, name, MAX(unit_price)
    FROM track
    GROUP BY track_id
    ORDER BY unit_price DESC;
```
5. Count how many employees report to each manager.
```SQL
    WITH reports AS (
        SELECT reports_to, COUNT(reports_to) AS number_of_reports
        FROM employee
        GROUP BY reports_to
    )
    SELECT e.employee_id, e.first_name || ' ' || e.last_name AS employee_name, r.number_of_reports
    FROM employee AS e
    JOIN reports AS r
    ON e.employee_id = r.reports_to
    ORDER BY r.number_of_reports DESC
```
6. Get all albums released by the artist "AC/DC".
```SQL
    SELECT a.album_id, a.title, art.name
    FROM album AS a
    JOIN artist AS art
    ON art.artist_id = a.artist_id
    WHERE art.name = 'AC/DC';
```

---

## Mid-Level (Business Flavor)
7. Which customer has spent the most overall?
```SQL
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
```
8. What are the top 10 selling artists by revenue?
```SQL
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
```
9. List the top 5 genres by total sales.
```SQL
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
```

9.5. List the top 5 genres by number of tracks sold.
```SQL
    SELECT
        g.genre_id,
        g.name AS genre_name,
        SUM(il.quantity) AS units_sold
    FROM genre g
    JOIN track t ON t.genre_id = g.genre_id
    JOIN invoice_line il ON il.track_id = t.track_id
    GROUP BY g.genre_id, g.name
    ORDER BY units_sold DESC
    LIMIT 5;
```
10. Find the average invoice total grouped by country.
```SQL
    SELECT
      billing_country,
      COUNT(*) AS invoice_count,
      ROUND(AVG(total)::numeric, 2) AS average_invoice_amount
    FROM invoice
    GROUP BY billing_country
    ORDER BY average_invoice_amount DESC, invoice_count DESC;
```
11. Which employee has the highest total sales (commission)?
```SQL
    WITH sales_by_rep AS (
      SELECT
        e.employee_id,
        e.first_name || ' ' || e.last_name AS employee_name,
        SUM(i.total) AS total_sales
      FROM employee e
      JOIN customer c ON c.support_rep_id = e.employee_id
      JOIN invoice  i ON i.customer_id     = c.customer_id
      GROUP BY e.employee_id, e.first_name, e.last_name
    ),
    mx AS (SELECT MAX(total_sales) AS m FROM sales_by_rep)
    SELECT s.*
    FROM sales_by_rep s
    JOIN mx ON s.total_sales = mx.m;
```
12. Identify the track(s) purchased the most times.
```SQL
    WITH track_sales AS (
        SELECT
            t.track_id,
            t.name AS track_name,
            SUM(il.quantity) AS units_sold
        FROM track t
        JOIN invoice_line il ON il.track_id = t.track_id
        GROUP BY t.track_id, t.name
    ),
    rankings AS (
        SELECT
            track_id, track_name, units_sold,
            RANK() OVER (ORDER BY units_sold DESC) AS rnk
        FROM track_sales
    )
    SELECT track_id, track_name, units_sold
    FROM rankings
    WHERE rnk = 1;
```

---

## Advanced-Level (Data Engineer Playground)
13. Show monthly sales totals (revenue per month).
```SQL
SELECT
    DATE_TRUNC('month', invoice_date) AS month_start,
    TO_CHAR(invoice_date, 'YYYY-MM') AS month_year,
    SUM(total) AS total_sales
FROM invoice
GROUP BY month_start, month_year
ORDER BY month_start;

    NOTE: You want to order by the first day of the month to prevent any issues with string formatting.
```
14. Which artist shows consistent growth in sales year-over-year?
```SQL
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
```
15. For each customer, calculate their average time gap between invoices.
```SQL

```
16. Find the top 3 tracks purchased by customers in each country (window function).
```SQL

```
17. Calculate the discount impact: difference between unit price * quantity and invoice line total.
```SQL

```
18. Which albums have never had any track purchased?
```SQL

```

---

## Senior-Level (Interview Sweat)
19. Build a retention report: how many first-time cusotmers in a month returned to purchase again within 6 months?
```SQL

```
20. Calculate customer lifetime value: total spend per customer, ranked, and show the top 20%.
```SQL

```
21. For each genre, compute the 3-month rolling average of sales.
```SQL

```
22. Detect churned customers: no invoices in the past 12 months but >= 3 invoices before that.
```SQL

```
23. Rank employees by sales and calculate their percentage of total revenue.
```SQL

```
24. Analyze cross-selling: which genres are most often purchased together on the same invoice?
```SQL

```

---

## Extra-Senior Portfolio Ideas
- **Global music revenue dashboard**: revenue by country, genre, and year.
- **Customer Segmentation**: frequent buyers vs one-time buyers, high vs. low spend
- **Artist Performance Report**: lifetime sales, growth trajectory, best-selling albums.
