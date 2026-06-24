from db import run_query

rows = run_query(
    """
    SELECT
        customer_id,
        first_name,
        last_name,
        country
    FROM customer
    WHERE country = 'Brazil';
    """
)

for row in rows:
    print(row)