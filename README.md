# SQL Practice & Demo Repository

This repo is a workspace for **SQL practice, demonstrations, and YouTube content**. Each subdirectory targets a classic PostgreSQL sample database with saved queries, practice questions, and schema reference docs.

Use it to explore real-world table relationships, write and test queries locally, and prep material for tutorials or live demos.

## Databases

| Database | Folder | Description | Schema Reference |
|----------|--------|-------------|------------------|
| **Chinook** | [`SQL_Practice_Chinook/`](SQL_Practice_Chinook/) | Digital media store — artists, albums, tracks, customers, invoices | [`Database_Schema.md`](SQL_Practice_Chinook/Database_Schema.md) |
| **Northwind** | [`SQL_Practice_Northwind/`](SQL_Practice_Northwind/) | Trading company — products, orders, customers, employees, suppliers | [`Database_Schema.md`](SQL_Practice_Northwind/Database_Schema.md) |
| **Pagila** | [`SQL_Practice_Pagila/`](SQL_Practice_Pagila/) | DVD rental store (Sakila port) — films, actors, rentals, payments | [`Database_Schema.md`](SQL_Practice_Pagila/Database_Schema.md) |

Each `Database_Schema.md` includes table summaries, column definitions, foreign keys, and sample rows.

## Connecting with psql

PostgreSQL 16 should be running locally. Connect to any database with:

```bash
psql -d chinook
psql -d northwind
psql -d pagila
```

## Repo Layout

```
SQL/
├── README.md                      ← you are here
├── SQL_Practice_Chinook/
│   ├── Database_Schema.md
│   ├── Practice_Questions.md
│   └── Queries/
├── SQL_Practice_Northwind/
│   ├── Database_Schema.md
│   └── Practice_Questions.md
└── SQL_Practice_Pagila/
    ├── Database_Schema.md
    ├── Practice_Questions.md
    └── Queries/
```

## Quick Links

- [Chinook schema](SQL_Practice_Chinook/Database_Schema.md) · [Practice questions](SQL_Practice_Chinook/Practice_Questions.md)
- [Northwind schema](SQL_Practice_Northwind/Database_Schema.md) · [Practice questions](SQL_Practice_Northwind/Practice_Questions.md)
- [Pagila schema](SQL_Practice_Pagila/Database_Schema.md) · [Practice questions](SQL_Practice_Pagila/Practice_Questions.md)
