-- 11. Which employee has the highest total sales (commission)?

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
