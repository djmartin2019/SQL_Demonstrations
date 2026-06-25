WITH RECURSIVE org AS (
    --- top/root employees
    SELECT
        e.employee_id,
        e.first_name || ' ' || e.last_name AS name,
        e.title,
        e.reports_to,
        0 AS depth,
        e.title::text AS org_path
    FROM employee e
    WHERE e.reports_to IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.first_name || ' ' | e.last_name AS name,
        e.title,
        e.reports_to,
        o.depth + 1 AS depth,
        o.org_path || ' > ' || e.title AS org_path
    FROM employee e
    JOIN org o
        ON e.reports_to = o.employee_id
)

SELECT * FROM org;
