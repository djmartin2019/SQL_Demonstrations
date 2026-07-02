# Pagila: Senior-Level Query Challenges

Three brutal, real-world prompts. Every one is solvable with the existing `pagila` schema and data, with no extra tables required. Query the partitioned `payment` parent table directly (it transparently spans `payment_p2022_01` through `payment_p2022_07`).

> Useful facts: `rental.return_date` is `NULL` when a film is still out. `film.rental_duration` is the allowed loan length **in days**. Money lives in `payment.amount`.

---

## Challenge 1: Peak Concurrent Rentals (Sweep-Line Interval Overlap)

**Business scenario.** Operations wants to size staffing and shelf space. For **each store**, what is the **maximum number of films simultaneously out on rental** at any single instant, and *when* did that peak occur?

**Requirements.**
1. Each rental occupies the half-open interval `[rental_date, return_date)`. If `return_date IS NULL`, treat the film as still out through the **latest timestamp present in the data** (max of all rental and return dates).
2. Map rentals to a store via `inventory.store_id` (`rental` to `inventory`).
3. Build an **event stream**: `+1` at each `rental_date`, `-1` at each `return_date`. Compute a **running sum ordered by event time** to get the concurrent-out count, partitioned per store.
4. For each store, return the **maximum** concurrent value and the timestamp at which it was first reached.
5. Order by peak concurrency descending.

**Definition of done.** Columns: `store_id`, `peak_concurrent_rentals`, `peak_reached_at`.

**Why it's hard.** This is the classic interval-overlap and sweep-line problem: you must `UNION ALL` two derived event sets with opposite deltas, order carefully (a return at the exact instant of a rental must net correctly), run a windowed cumulative sum, then pick the argmax per partition with a tie-break on earliest time.

---

## Challenge 2: Monthly Revenue Cohort Retention

**Business scenario.** The growth team wants a **cohort retention curve**: of the customers who first paid in a given month, what fraction came back and paid in each subsequent month?

**Requirements.**
1. Define each customer's **cohort** as the calendar month of their **first** payment (`payment.payment_date`).
2. For every (cohort_month, activity_month) pair, count distinct paying customers, and compute the **month offset** (0 = cohort month, 1 = next month, and so on).
3. Compute **retention percent** = active customers at offset N / cohort size at offset 0.
4. Present it as a **retention matrix**: one row per cohort, columns for offsets 0 through 6 (the data spans January through July 2022). Use conditional aggregation or `FILTER` to pivot.
5. Include the cohort size next to each cohort label.

**Definition of done.** Columns: `cohort_month`, `cohort_size`, `m0`, `m1`, `m2`, `m3`, `m4`, `m5`, `m6` (each a retention percentage; `NULL` where the offset falls outside the data window).

**Why it's hard.** Requires deriving a per-customer first-payment month (window or grouped min), self-joining activity back to cohort, computing a month-difference offset across the partitioned payment data, then pivoting offsets into fixed columns with `FILTER` while keeping the offset-0 denominator correct.

---

## Challenge 3: Overdue Rental and Late-Fee Liability Analysis

**Business scenario.** Finance wants to quantify **late returns** and the revenue risk from outstanding rentals, broken down by store, using each film's contractual loan period.

**Requirements.**
1. A rental's **due date** = `rental_date + film.rental_duration` days (join `rental` to `inventory` to `film`).
2. Classify each rental:
   - **On time**: returned on or before the due date.
   - **Late**: returned after the due date (`days_late` = whole days past due).
   - **Outstanding**: `return_date IS NULL` and the due date is already past the dataset's "today" (max timestamp in `rental`); compute `days_late` as of "today".
3. Model a **late fee** = `days_late * (film.replacement_cost / film.rental_duration)`, that is, a daily rate proportional to the film's value, but **cap** the total fee at `film.replacement_cost`.
4. Aggregate **per store**: number of late rentals, number of outstanding rentals, average days late (late and outstanding combined), and total capped late-fee liability.
5. Also surface the single **worst offending customer per store** (highest accumulated late fee) using a window ranking, and return their name alongside the store totals.

**Definition of done.** Columns: `store_id`, `late_count`, `outstanding_count`, `avg_days_late`, `total_late_fee_liability`, `worst_customer`, `worst_customer_fee`.

**Why it's hard.** Combines interval arithmetic on `rental_duration`, three-way status classification (including the NULL-return "still out" branch evaluated against a derived current date), a non-linear capped fee (`LEAST(fee, replacement_cost)`), and a per-store argmax customer via window ranking layered on top of store-level aggregation.
