-- 1. List all customers in the USA.
SELECT customer_id, company_name, contact_name
FROM customers
WHERE country = 'USA';