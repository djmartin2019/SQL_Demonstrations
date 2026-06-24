"""PostgreSQL connection helpers for the Pagila practice database.

Usage in a query script::

    from db import run_query

    rows = run_query(
        '''
        SELECT customer_id, first_name, last_name, email
        FROM customer
        WHERE active = %s
        LIMIT 10
        ''',
        (True,),
    )
    for row in rows:
        print(row)
"""

from __future__ import annotations

import os
from contextlib import contextmanager
from typing import Any, Iterator

import psycopg
from psycopg.rows import dict_row

DATABASE = os.getenv("PGDATABASE", "pagila")


def _conninfo() -> str:
    parts = [
        f"host={os.getenv('PGHOST', 'localhost')}",
        f"port={os.getenv('PGPORT', '5432')}",
        f"dbname={DATABASE}",
        f"user={os.getenv('PGUSER', 'davidmartin')}",
    ]
    if password := os.getenv("PGPASSWORD"):
        parts.append(f"password={password}")
    return " ".join(parts)


@contextmanager
def get_connection() -> Iterator[psycopg.Connection]:
    """Open a connection to the Pagila database."""
    with psycopg.connect(_conninfo(), row_factory=dict_row) as conn:
        yield conn


def run_query(
    sql: str,
    params: tuple | dict | None = None,
) -> list[dict[str, Any]]:
    """Run a SQL statement and return rows as dictionaries."""
    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(sql, params)
            rows = cur.fetchall() if cur.description else []
        conn.commit()
        return rows
