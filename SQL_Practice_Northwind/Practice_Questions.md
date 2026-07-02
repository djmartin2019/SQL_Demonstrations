# Northwind Database Practice

## Junior-Level (SQL Push-Ups)

1. List all customers in the USA.
```SQL
    SELECT customer_id, company_name, contact_name
    FROM customers
    WHERE country = 'USA';
```
    NOTE: SELECT * is fine for warm-ups, but it's a bad habit in real work. Avoid bringing in columns you don't need.
2. Find all orders placed in 1997.
```SQL
    SELECT * FROM orders
    WHERE order_date BETWEEN '1997-01-01' AND '1997-12-31';
```
    NOTE: Inclusive boundaries are easier to read. BETWEEN helps make the query read like a sentence.
3. Get the total number of orders per employee.
```SQL
    SELECT e.employee_id, e.first_name || ' ' || e.last_name as employee_name, COUNT(o.employee_id) as order_count
    FROM employees AS e
    JOIN orders AS o
    ON e.employee_id = o.employee_id
    GROUP BY e.employee_id, e.first_name, e.last_name
    ORDER BY order_count desc;
```
    NOTE: Use every non-aggregated column in GROUP BY. Some SQL dialects require it, so it's safer for interviews to include them.
4. Show the top 5 most frequently ordered products.
```SQL
    SELECT p.product_id, p.product_name, COUNT(od.order_id) as order_count
    FROM products AS p
    JOIN order_details AS od
    ON od.product_id = p.product_id
    GROUP BY p.product_name
    ORDER BY order_count desc
    LIMIT 5;
```
    NOTE: Including product_id is good practice because it prevents the nightmare of duplicate product_names.
5. Find all suppliers located in Germany.
```SQL
    SELECT company_name, country
    FROM suppliers
    WHERE country = 'Germany';
```
    NOTE: Best practice to include only the columns you need.
6. Get the number of customers by country.
```SQL
    SELECT country,
        COUNT(customer_id) AS customer_count,
        RANK() OVER (ORDER BY COUNT(customer_id) DESC) AS country_rank
    FROM customers
    GROUP BY country;
```
    NOTE: Use a window function to compare countries.

---

## Mid-Level (Business Analyst Flavor)

7. Which customer has placed the highest number of orders?
```SQL
    WITH customer_orders AS (
        SELECT o.customer_id, c.contact_name, COUNT(*) AS order_count
        FROM orders AS o
        JOIN customers AS c ON o.customer_id = c.customer_id
        GROUP BY o.customer_id, c.contact_name
    )
    SELECT *
    FROM customer_orders
    WHERE order_count = (SELECT MAX(order_count) FROM customer_orders);
```
8. What are the top 10 customers by revenue in 1997?
```SQL
    WITH customer_revenue AS (
        SELECT
            o.customer_id,
            ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount))::NUMERIC, 2) AS total_revenue
        FROM orders AS o
        JOIN order_details AS od
            ON o.order_id = od.order_id
        WHERE o.order_date BETWEEN '1997-01-01' AND '1997-12-31'
        GROUP BY o.customer_id
    )
    SELECT
        cr.customer_id,
        c.contact_name,
        cr.total_revenue
    FROM customer_revenue AS cr
    JOIN customers AS c
        ON cr.customer_id = c.customer_id
    ORDER BY cr.total_revenue DESC
    LIMIT 10;
```

9. Which product category generates the most value?
```SQL
    WITH product_revenue AS (
        SELECT p.product_id, p.category_id,
            SUM(od.unit_price * od.quantity * (1 - od.discount))::NUMERIC AS total_revenue
        FROM products AS p
        JOIN order_details AS od ON p.product_id = od.product_id
        GROUP BY p.product_id, p.catgory_id
    ),
    catgory_revenue AS (
        SELECT c.category_name,
            SUM(pr.total_revenue) AS total_category_revenue
        FROM product_revenue AS pr
        JOIN categories AS c ON c.category_id = pr.category_id
        GROUP BY c.category_name
    ),
    ranked_categories AS (
        SELECT
            category_name,
            ROUND(total_category_revenue, 2) AS total_category_revenue,
            RANK() OVER (ORDER BY total_category_revenue DESC) AS revenue_rank
        FROM category_revenue
    )
    SELECT *
    FROM ranked_categories
    WHERE revenue_rank <= 5
    ORDER BY revenue_rank;
```
    NOTES:
        1. Find total revenue per product.
        2. Find total revenue per category.
        3. Rank each category based on their revenue.
            The ranked_categories CTE is needed because RANK() cannot be used in a WHERE statement in PSQL.
            So we add the extra CTE to rank the categories and then use the final query to display them.
        4. Display the top 5 categories with the most revenue.

10. What's the average order value by country?
```SQL
    WITH order_revenue AS (
        SELECT
            o.ship_country,
            o.order_id,
            SUM(od.unit_price * od.quantity * (1 - od.discount))::NUMERIC AS order_total
        FROM orders AS o
        JOIN order_details AS od
            ON o.order_id = od.order_id
        GROUP BY o.ship_country, o.order_id
    ),
    ranked_countries AS (
        SELECT
            ship_country,
            ROUND(AVG(order_total), 2) AS avg_order_value,
            RANK() OVER (ORDER BY AVG(order_total) DESC) AS avg_order_rank
        FROM order_revenue
        GROUP BY ship_country
        ORDER BY avg_order_value DESC
    )
    SELECT *
    FROM ranked_countries
    WHERE avg_order_rank <= 5
    ORDER BY avg_order_rank;
```
11. Which employee sold the most in Q2 of 1996?
```SQL
    WITH order_revenue AS (
        SELECT
            o.employee_id,
            SUM(od.unit_price * od.quantity * (1 - od.discount))::NUMERIC AS total_revenue
        FROM orders o
        JOIN order_details od ON o.order_id = od.order_id
        WHERE o.order_date BETWEEN '1997-04-01' AND '1997-06-30'
        GROUP BY o.employee_id
    ),
    ranked_employees AS (
        SELECT
            e.employee_id,
            e.first_name || ' ' || e.last_name AS employee_name,
            ROUND(rev.total_revenue, 2) AS total_revenue,
            RANK() OVER (ORDER BY rev.total_revenue DESC) AS employee_sales_rank
        FROM order_revenue rev
        JOIN employees e ON e.employee_id = rev.employee_id
    )
    SELECT *
    FROM ranked_employees
    WHERE employee_sales_rank <= 5
    ORDER BY employee_sales_rank;
```
12. List the products that were never ordered.
```SQL
    SELECT p.product_id, p.product_name
    FROM products p
    LEFT JOIN order_details od
        ON p.product_id = od.product_id
    WHERE od.product_id IS NULL;
```

---

## Advanced-Level (Data Engineer Brain Flex)

13. Show the monthly sales trend (total revenue per month).
```SQL
    SELECT
        EXTRACT(YEAR FROM o.order_date) AS year,
        EXTRACT(MONTH FROM o.order_date) AS month,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount))::NUMERIC, 2) AS total_revenue,
        RANK() OVER (ORDER BY SUM(od.unit_price * od.quantity * (1 - od.discount)) DESC) AS rev_rank
    FROM orders AS o
    JOIN order_details AS od ON o.order_id = od.order_id
    GROUP BY EXTRACT(MONTH FROM o.order_date),
             EXTRACT(YEAR FROM o.order_date)
    ORDER BY year, month;
```
14. Which products have increasing sales month-over-month for at least 3 consecutive months?
```SQL
    WITH product_monthly_revenue AS (
        SELECT
            p.product_id,
            p.product_name,
            DATE_TRUNC('month', o.order_date) AS month,
            SUM(od.unit_price * od.quantity * (1 - od.discount))::NUMERIC AS revenue
        FROM products p
        JOIN order_details AS od ON p.product_id = od.product_id
        JOIN orders AS o ON od.order_id = o.order_id
        GROUP BY p.product_id, p.product_name, DATE_TRUNC('month', o.order_date)
    ),
    revenue_with_lag AS (
        SELECT
            product_id,
            product_name,
            month,
            revenue,
            LAG(revenue) OVER (PARTITION BY product_id ORDER BY month) AS prev_revenue
        FROM product_monthly_revenue
    ),
    flagged AS (
        SELECT *,
            CASE WHEN revenue > prev_revenue THEN 1 ELSE 0 END AS is_increase
        FROM revenue_with_lag
    ),
    streaks AS (
        SELECT
            product_id,
            product_name,
            month,
            is_increase,
            SUM(CASE WHEN is_increase = 0 THEN 1 ELSE 0 END)
                OVER (PARTITION BY product_id ORDER BY month) AS grp
        FROM flagged
    )
    SELECT product_id, product_name
    FROM (
        SELECT product_id, product_name, grp, COUNT(*) AS streak_length
        FROM streaks
        WHERE is_increase = 1
        GROUP BY product_id, product_name, grp
    ) t
    WHERE streak_length >= 3
    ORDER BY product_name;
```
15. Find the average time between a customer's orders (customer loyalty metric).
```SQL

```
16. For each employee, calculate their revenue and their share of total company revenue.
```SQL

```
17. Identify the top 3 products per category by sales volume (using RANK or DENSE_RANK).
```SQL

```
18. Which orders had the highest discount impact (difference between list price and discounted total)?
```SQL

```

---

## Senior-Level (make them sweat in interviews)

19. Calculate year-over-year growth in sales for each region.
20. Build a customer retention report:
    How many first-time customers in a month returned to order again within 6 months?
21. Find customers who generate at least 80% of revenue in each region (Pareto principle).
22. For each supplier, calculate the average delivery time (OrderDate -> ShippedDate), then rank suppliers by reliability.
23. Create a rolling 3-month sales average by category.
24. Detect "churned customers":
    Customers with no orders in the past 12 months but who had at least 3 orders before that.

---

## Extra-Senior/"Please Hire Me" Project Ideas

- Sales KPI dashboard (revenue, orders, discounts, growth).
- Customer Segmentation Analysis (new vs. repeat, high-value vs low-value).
- Supplier Performance Report (on-time shipments, sales contribution).
