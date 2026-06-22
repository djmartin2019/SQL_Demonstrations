-- 2. Find all invoices from 2022.
SELECT
    invoice_id,
    customer_id,
    invoice_date
FROM invoice
WHERE EXTRACT(YEAR FROM invoice_date) = 2022
ORDER BY invoice_date ASC;
