from db import run_query

rows = run_query(
    """
    SELECT customer_id, company_name, contact_name
    FROM customers
    WHERE country = %s
    ORDER BY contact_name ASC;
    """,
    ("USA",),
)

for row in rows:
    print(row)