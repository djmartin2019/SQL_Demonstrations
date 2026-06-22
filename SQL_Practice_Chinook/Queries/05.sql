-- 5. Count how many employees report to each manager.
WITH reports AS (
    SELECT reports_to, COUNT(reports_to) AS number_of_reports
    FROM employee
    GROUP BY reports_to
)
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS employee_name, r.number_of_reports
FROM employee AS e
JOIN reports AS r
ON e.employee_id = r.reports_to
ORDER BY r.number_of_reports DESC
