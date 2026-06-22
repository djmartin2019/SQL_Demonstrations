-- 13. Show monthly sales totals (revenue per month).

SELECT
    DATE_TRUNC('month', invoice_date) AS month_start,
    TO_CHAR(invoice_date, 'YYYY-MM') AS month_year,
    SUM(total) AS total_sales
FROM invoice
GROUP BY month_start, month_year
ORDER BY month_start;
