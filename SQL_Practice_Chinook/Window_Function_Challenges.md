# Chinook: 5 Crazy Window-Function Challenges

Five window-function-heavy prompts, all solvable with the existing `chinook` schema and data, with no extra tables required. Every question is designed so that a **window function is the natural (and intended) tool**: `RANK`/`DENSE_RANK`/`ROW_NUMBER`, `NTILE`, `LAG`/`LEAD`, `FIRST_VALUE`/`LAST_VALUE`, `PERCENT_RANK`/`CUME_DIST`, running frames (`ROWS`/`RANGE BETWEEN ...`), and named `WINDOW` clauses.

> Treat the latest `invoice.invoice_date` in the database as "today" wherever a current date is needed.
>
> Tables in play: `invoice`, `invoice_line`, `track`, `genre`, `album`, `artist`, `customer`, `employee`, `media_type`, `playlist`, `playlist_track`.

---

## Challenge 1: Genre Chart-Toppers and the "Almost Made It" Gap

**Business scenario.** The merchandising team wants a per-genre "Top 3" leaderboard of tracks by revenue, but they also want to know *how close* the number 4 track was to breaking in. A small gap means the ranking is fragile and worth revisiting.

**Requirements.**
1. Compute revenue per track as `SUM(invoice_line.unit_price * invoice_line.quantity)`, attributed to the track's `genre`.
2. Within each genre, rank tracks by revenue using a window function and keep the **top 3** (handle ties deliberately: decide between `RANK`, `DENSE_RANK`, and `ROW_NUMBER`, and justify it).
3. For each track in the top 3, also show:
   - the **genre's total revenue** (window `SUM` over the partition), and
   - each track's **share of genre revenue** as a percentage.
4. Add a `gap_to_next` column: for the **number 3 track only**, the revenue difference between it and the next-highest track (number 4) in the same genre, using `LEAD`. For numbers 1 and 2, this should be `NULL`.

**Definition of done.** One row per top-3 track: `genre_name`, `track_name`, `track_revenue`, `genre_revenue`, `pct_of_genre`, `rank_in_genre`, `gap_to_next`. Ordered by `genre_name`, then `rank_in_genre`.

**Why it's hard.** You need a partitioned ranking, a partitioned aggregate, and a `LEAD` that peeks past the cutoff you are filtering on. That means the `LEAD` must be computed **before** the top-3 filter, or the number 4 row is already gone.

---

## Challenge 2: Customer Purchase Cadence and Dormancy Streaks

**Business scenario.** Retention wants to understand each customer's rhythm: how long they typically wait between purchases, and whether their gaps are getting longer (cooling off) or shorter (heating up).

**Requirements.**
1. For every customer, order their invoices chronologically and use `LAG` to compute the **day gap** between each invoice and their previous one.
2. Produce, per customer:
   - `avg_gap_days` (average of those gaps),
   - `max_gap_days` (their longest dormant stretch),
   - `current_gap_days`: days from their **most recent** invoice to the global "today".
3. Flag each customer as `'COOLING'`, `'HEATING'`, or `'STEADY'` by comparing the gap **preceding their latest invoice** against their historical `avg_gap_days`.
4. Only include customers with **at least 3 invoices** (a single gap is not a cadence).

**Definition of done.** One row per qualifying customer: `customer_id`, full name, `invoice_count`, `avg_gap_days`, `max_gap_days`, `current_gap_days`, `trend`. Ordered by `current_gap_days` descending (most dormant first).

**Why it's hard.** Mixing an ordered `LAG` (row-level gaps) with per-customer aggregates forces a two-stage query, and the trend flag needs the *last* gap specifically. That means pulling one particular windowed value out of an ordered partition (think `LAST_VALUE` with an explicit frame, or a `ROW_NUMBER` filter).

---

## Challenge 3: Monthly Revenue with Running Total, 3-Month Rolling Average, and MoM Percent

**Business scenario.** Finance wants a single time-series table for the exec dashboard: cumulative revenue to date, a smoothed 3-month trend line, and month-over-month growth.

**Requirements.**
1. Aggregate `invoice.total` into **monthly buckets** (`DATE_TRUNC('month', invoice_date)`). Order strictly by the first day of the month.
2. Add these window columns over the monthly series:
   - `running_total`: cumulative revenue from the first month through the current month (`SUM` with an unbounded-preceding frame).
   - `rolling_3mo_avg`: average revenue over the current month and the two prior months (`ROWS BETWEEN 2 PRECEDING AND CURRENT ROW`).
   - `mom_pct_change`: percent change versus the previous month, via `LAG`.
3. Also include `pct_of_total_revenue`: each month's share of all-time revenue (window `SUM` over the whole series).

**Definition of done.** One row per month: `month_start`, `monthly_revenue`, `running_total`, `rolling_3mo_avg`, `mom_pct_change`, `pct_of_total_revenue`. Ordered chronologically.

**Why it's hard.** Three different frame specifications must coexist on the same ordered set (unbounded running total, a fixed 3-row sliding window, and a whole-partition total), and the rolling average must behave sanely for the first one or two months where fewer than three rows exist.

---

## Challenge 4: Each Country's Big Spender versus the Local Median

**Business scenario.** Regional managers want to know their number 1 customer per country, but also whether that top customer is a lone whale or just barely above the pack, so they need the country's spend distribution around them.

**Requirements.**
1. Compute total spend per customer (`SUM(invoice.total)`), partitioned by `customer.country`.
2. Within each country, use `ROW_NUMBER` (or `RANK`) to identify the **top spender**, and `NTILE(4)` to assign every customer a spend **quartile within their country**.
3. For each country's top spender, also report:
   - the country's **median customer spend** (`PERCENTILE_CONT(0.5)` as a window or aggregate),
   - the top spender's **`PERCENT_RANK`** within the country (should be 1.0 for the top),
   - `lead_over_2nd`: how much more the number 1 spent than the number 2 in that country (`LEAD`/`LAG`), `NULL` if the country has only one customer.
4. Return **only each country's top spender**.

**Definition of done.** One row per country: `country`, `customer_id`, full name, `total_spend`, `country_median_spend`, `lead_over_2nd`, `customers_in_country`. Ordered by `total_spend` descending.

**Why it's hard.** You are combining a partitioned rank, an in-partition `NTILE`, a windowed median, and a neighbor comparison. `PERCENTILE_CONT` behaves differently as a window function versus an aggregate, so you must choose the form that composes with the rest.

---

## Challenge 5: Artist Streaks of Consecutive Years of Sales Growth (Gaps and Islands)

**Business scenario.** A&R wants to spotlight artists with **momentum**: the longest run of *consecutive calendar years* in which their revenue grew versus the prior year.

**Requirements.**
1. Build per-artist, per-year revenue from `invoice_line` to `track` to `album` to `artist`, using `EXTRACT(YEAR FROM invoice.invoice_date)`.
2. For each artist, use `LAG` over the year-ordered series to determine whether each year's revenue **grew** versus the immediately preceding year, and only when the years are actually consecutive (a missing year breaks the streak).
3. Using a **gaps-and-islands** technique (a difference of two `ROW_NUMBER`s, or a running `SUM` of a "streak break" flag), collapse consecutive growth years into streaks.
4. For each artist, return their **longest growth streak**: its length in years, and the start and end year.
5. Keep only artists whose longest streak is **at least 2 years**, ranked by streak length descending (break ties by total revenue in the streak).

**Definition of done.** One row per qualifying artist: `artist_name`, `streak_length_years`, `streak_start_year`, `streak_end_year`, `streak_revenue`. Ordered by `streak_length_years` descending, then `streak_revenue` descending.

**Why it's hard.** This is the classic gaps-and-islands trap: you need `LAG` both to detect growth *and* to detect year-adjacency, then a second layer of windowing to group the surviving rows into islands, then a per-island aggregate, then a per-artist "pick the longest island". That is four stacked window or aggregate stages.

---

### Hints (open only if stuck)

<details>
<summary>General patterns these five share</summary>

- **Stage your CTEs.** Almost every prompt needs: (1) a base aggregate CTE, (2) a CTE that adds window columns, and (3) a filter or select. Do not try to filter on a window result in the same `SELECT` that computes it. Wrap it instead.
- **Frames matter.** `SUM(x) OVER (ORDER BY d)` defaults to `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`. Be explicit with `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` for true row-count windows (Challenge 3).
- **`LAST_VALUE` needs a frame.** To grab the last value in a partition, use `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING`, or just `ROW_NUMBER` plus a filter.
- **Gaps and islands (Challenge 5):** `year - ROW_NUMBER() OVER (PARTITION BY artist ORDER BY year)` is constant within a run of consecutive years. Group by that constant to form islands.
- **Ties:** decide `RANK` versus `DENSE_RANK` versus `ROW_NUMBER` per business intent. `ROW_NUMBER` guarantees exactly N rows in a Top-N.
</details>
