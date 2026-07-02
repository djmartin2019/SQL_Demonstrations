# SQL Practice & Demo Repository

This repo is a workspace for **SQL practice, demonstrations, and tutorial content**. Each subdirectory targets a classic PostgreSQL sample database with saved queries, practice questions, and schema reference docs.

Use it to explore real-world table relationships, write and test queries locally, and prepare material for tutorials or live demos.

## Databases

| Database | Folder | Description | Schema Reference |
|----------|--------|-------------|------------------|
| **Chinook** | [`SQL_Practice_Chinook/`](SQL_Practice_Chinook/) | Digital media store: artists, albums, tracks, customers, invoices | [`Database_Schema.md`](SQL_Practice_Chinook/Database_Schema.md) |
| **Northwind** | [`SQL_Practice_Northwind/`](SQL_Practice_Northwind/) | Trading company: products, orders, customers, employees, suppliers | [`Database_Schema.md`](SQL_Practice_Northwind/Database_Schema.md) |
| **Pagila** | [`SQL_Practice_Pagila/`](SQL_Practice_Pagila/) | DVD rental store (Sakila port): films, actors, rentals, payments | [`Database_Schema.md`](SQL_Practice_Pagila/Database_Schema.md) |

Each `Database_Schema.md` includes table summaries, column definitions, foreign keys, and sample rows.

## Getting Started

1. Install PostgreSQL 16 and make sure a local server is running.
2. Load each sample database (Chinook, Northwind, Pagila) into your local instance.
3. Install the Python dependencies if you want to run queries from scripts:

```bash
pip install -r requirements.txt
```

## Connecting with psql

Connect to any database directly with `psql`:

```bash
psql -d chinook
psql -d northwind
psql -d pagila
```

## Running Queries from Python

Each database folder ships a small `db.py` helper. Set the standard `PG*` environment
variables if your local setup differs from the defaults, then run queries like this:

```python
from db import run_query

rows = run_query(
    """
    SELECT customer_id, first_name, last_name, country
    FROM customer
    WHERE country = %s
    """,
    ("Brazil",),
)
for row in rows:
    print(row)
```

## What Each Database Folder Contains

Every `SQL_Practice_*` folder follows the same layout:

- `Database_Schema.md`: generated schema reference (tables, columns, keys, sample rows).
- `Practice_Questions.md`: graded question sets from junior warm-ups to senior interview problems.
- `Advanced_Challenges.md`: a few brutal, real-world prompts to stress-test your SQL.
- `Queries/`: saved `.sql` solutions.
- `Python/`: Python examples that run queries through `db.py`.
- `db.py`: PostgreSQL connection helper.

The Chinook folder additionally includes `Window_Function_Challenges.md` (five
window-function-focused problems) and an `Advanced_Queries/` folder.

## Repo Layout

```
SQL/
├── README.md                (you are here)
├── requirements.txt
├── SQL_Practice_Chinook/
│   ├── Database_Schema.md
│   ├── Practice_Questions.md
│   ├── Advanced_Challenges.md
│   ├── Window_Function_Challenges.md
│   ├── db.py
│   ├── Queries/
│   ├── Advanced_Queries/
│   └── Python/
├── SQL_Practice_Northwind/
│   ├── Database_Schema.md
│   ├── Practice_Questions.md
│   ├── Advanced_Challenges.md
│   ├── db.py
│   ├── Queries/
│   └── Python/
└── SQL_Practice_Pagila/
    ├── Database_Schema.md
    ├── Practice_Questions.md
    ├── Advanced_Challenges.md
    ├── db.py
    ├── Queries/
    └── Python/
```

## Quick Links

- Chinook: [schema](SQL_Practice_Chinook/Database_Schema.md), [practice questions](SQL_Practice_Chinook/Practice_Questions.md), [advanced challenges](SQL_Practice_Chinook/Advanced_Challenges.md), [window functions](SQL_Practice_Chinook/Window_Function_Challenges.md)
- Northwind: [schema](SQL_Practice_Northwind/Database_Schema.md), [practice questions](SQL_Practice_Northwind/Practice_Questions.md), [advanced challenges](SQL_Practice_Northwind/Advanced_Challenges.md)
- Pagila: [schema](SQL_Practice_Pagila/Database_Schema.md), [practice questions](SQL_Practice_Pagila/Practice_Questions.md), [advanced challenges](SQL_Practice_Pagila/Advanced_Challenges.md)