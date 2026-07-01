WITH customer_rfm AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS full_name,
        MAX(i.invoice_date)::date AS most_recent_invoice_date,
        COUNT(DISTINCT i.invoice_id) AS frequency,
        SUM(i.total) AS monetary
    FROM customer c
    JOIN invoice i
        ON c.customer_id = i.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
),

rfm_base AS (
    SELECT
        customer_id,
        full_name,
        (
            MAX(most_recent_invoice_date) OVER ()
            - most_recent_invoice_date
        ) AS recency_days,
        frequency,
        monetary
    FROM customer_rfm
),

rfm_scored AS (
    SELECT
        customer_id,
        full_name,
        recency_days,
        frequency,
        monetary,

        NTILE(5) OVER (ORDER BY recency_days DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
    FROM rfm_base
),

rfm_segmented AS (
    SELECT
        customer_id,
        full_name,
        recency_days,
        frequency,
        monetary,
        r_score,
        f_score,
        m_score,
        r_score || '-' || f_score || '-' || m_score AS rfm_cell,
        r_score + f_score + m_score AS rfm_score,
        CASE
            WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champion'
            WHEN r_score <= 2 AND m_score >= 4 THEN 'At Risk'
            WHEN f_score >= 4 AND m_score >= 3 THEN 'Loyal'
            WHEN r_score <= 2 AND f_score <= 2 THEN 'Hibernating'
            ELSE 'Regular'
        END AS segment
    FROM rfm_scored
    ORDER BY monetary DESC
)

SELECT
    customer_id,
    full_name,
    recency_days,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    rfm_cell,
    segment
FROM rfm_segmented
WHERE segment = 'At Risk'
ORDER BY monetary DESC;
