-- 10. Find the average invoice total grouped by country.

SELECT
  billing_country,
  COUNT(*) AS invoice_count,
  ROUND(AVG(total)::numeric, 2) AS average_invoice_amount
FROM invoice
GROUP BY billing_country
ORDER BY average_invoice_amount DESC, invoice_count DESC;

