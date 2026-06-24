# Northwind — Senior-Level Query Challenges

Three brutal, real-world prompts. Every one is solvable with the existing `northwind` schema and data — no extra tables required.

> Net line revenue is always defined as `unit_price * quantity * (1 - discount)` from `order_details`. Use `orders.order_date` for time. `discount` and `unit_price` are `real`, so cast to `numeric` before rounding.

---

## Challenge 1 — Longest Consecutive Month-over-Month Growth Streak

**Business scenario.** The CFO claims revenue "keeps climbing." Prove or disprove it: find the company's longest unbroken run of months where net revenue grew versus the immediately prior **calendar** month.

**Requirements.**
1. Aggregate net revenue per **calendar month** (`date_trunc('month', order_date)`). Months with no orders must be treated as **gaps that break the chain** (do not silently skip — a missing month is not "growth").
2. Compute month-over-month change using `LAG` over the dense monthly series. A month "grows" only if the previous calendar month exists **and** its revenue was strictly lower.
3. Using a **gap-and-islands** technique, identify maximal consecutive runs of growth months and return the **longest** streak (break ties by the most recent).
4. Report the streak's start month, end month, length in months, and the total net revenue gained from the first to the last month of the streak.

**Definition of done.** Columns: `streak_start_month`, `streak_end_month`, `months_in_streak`, `start_revenue`, `end_revenue`, `revenue_delta`.

**Why it's hard.** You must first build a **gapless month spine** (generate_series between min and max order month) so missing months correctly interrupt the streak, then layer LAG-based growth flags, then the classic row_number-difference islanding — three stacked window passes.

---

## Challenge 2 — Customer Churn & Reactivation Detection

**Business scenario.** Retention wants to know which customers **churned and came back**. A reactivation is valuable signal for what marketing did right.

**Requirements.**
1. For each customer, order their orders by `order_date` and compute the **gap in days** to their previous order using `LAG`.
2. Define **churn threshold** dynamically as the customer base's **90th percentile of all inter-order gaps** (`PERCENTILE_CONT(0.9)`) — compute it once, then apply to everyone.
3. Flag any order whose preceding gap **exceeds that threshold** as a **reactivation event** (the customer "came back" after a long silence).
4. Produce, per customer: total orders, their longest gap, count of reactivation events, and the date of their most recent reactivation (NULL if none).
5. Return only customers with **at least one reactivation**, ordered by reactivation count desc, then longest gap desc.

**Definition of done.** Columns: `customer_id`, `company_name`, `total_orders`, `longest_gap_days`, `reactivation_events`, `last_reactivation_date`, `churn_threshold_days`.

**Why it's hard.** A global percentile must be derived from a per-customer windowed gap series and then fed back as a scalar threshold (CTE + cross join), while correctly handling customers with a single order (no gap, never reactivated).

---

## Challenge 3 — ABC / Pareto Product Classification (80-20)

**Business scenario.** Procurement wants an **ABC inventory classification** so they can focus working capital on the products that actually drive revenue.

**Requirements.**
1. Compute lifetime net revenue per product (`products` joined to `order_details`). Products that have **never sold** must still appear with revenue `0`.
2. Order products by revenue descending and compute a **running cumulative revenue** and the **cumulative percent of total company revenue** using window functions.
3. Assign an ABC class by cumulative share:
   - **A** — products composing the first 0–80% of cumulative revenue.
   - **B** — the next 80–95%.
   - **C** — the final 95–100% (including the zero-revenue products).
   The boundary product (the one that crosses 80% / 95%) belongs to the **lower-letter** class it pushes into.
4. Additionally show each product's **rank within its own category** (`category_id`) by revenue.
5. Output a summary as well: for each ABC class, the **number of products** and the **share of total revenue** they represent.

**Definition of done.** Two result sets (or one detail + one rollup): detail rows `product_id`, `product_name`, `category_name`, `revenue`, `cumulative_pct`, `abc_class`, `rank_in_category`; and a class summary `abc_class`, `product_count`, `pct_of_revenue`.

**Why it's hard.** The boundary-inclusion rule means a naive `CASE` on cumulative percent misclassifies the threshold-crossing product; you need the cumulative sum *up to the previous row* to decide class membership. Zero-revenue products also break naive percentage math (division and ordering edge cases).
