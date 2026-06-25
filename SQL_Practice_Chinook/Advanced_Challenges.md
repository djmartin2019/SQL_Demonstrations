# Chinook — Senior-Level Query Challenges

Three brutal, real-world prompts. Every one is solvable with the existing `chinook` schema and data — no extra tables required. Treat the latest `invoice.invoice_date` in the database as "today" wherever a current date is needed.

> Tables in play: `invoice`, `invoice_line`, `track`, `genre`, `customer`, `employee`, `album`, `artist`, `playlist`, `playlist_track`.

---

## Challenge 1 — RFM Segmentation with At-Risk High-Value Detection

**Business scenario.** The head of CRM wants a customer segmentation model to drive a win-back campaign. They specifically want to find customers who *used* to be valuable but are going quiet.

**Requirements.**

1. For every customer, compute the three RFM components using **revenue from `invoice.total`** (not line items):
  - **Recency** = days between the customer's most recent invoice and the global "today" (max invoice date in the DB).
  - **Frequency** = distinct count of invoices.
  - **Monetary** = total spend.
2. Convert each component into a **1–5 score using `NTILE(5)`** across the full customer base (5 = best, so recency must be inverted — a *smaller* gap should score *higher*).
3. Produce a concatenated `rfm_cell` (e.g. `'5-4-5'`) and an overall `rfm_score` (sum of the three).
4. Label each customer with a segment using these rules, evaluated **in order**:
  - `Champion` — R≥4 AND F≥4 AND M≥4
  - `Loyal` — F≥4 AND M≥3
  - `At Risk` — R≤2 AND M≥4
  - `Hibernating` — R≤2 AND F≤2
  - otherwise `Regular`
5. Return only the `**At Risk*`* segment, ordered by Monetary descending.

**Definition of done.** One row per at-risk customer: `customer_id`, full name, `recency_days`, `frequency`, `monetary`, `r_score`, `f_score`, `m_score`, `rfm_cell`, `segment`.

**Why it's hard.** Inverted recency scoring, multiple independent `NTILE` windows over the same base, and ordered/priority CASE labeling that must not double-classify.

---

## Challenge 2 — Recursive Org Revenue Roll-Up

**Business scenario.** Finance wants a management hierarchy P&L: every manager's "book of business" should include revenue from *their own* customers plus the **fully recursive** revenue of everyone beneath them in the reporting tree.

**Requirements.**

1. Customers are attributed to a sales rep via `customer.support_rep_id → employee.employee_id`.
2. Direct revenue for an employee = sum of `invoice.total` for invoices belonging to customers they directly support.
3. Using a **recursive CTE over `employee.reports_to`**, compute each employee's **rolled-up revenue** = their direct revenue + the rolled-up revenue of all descendants (any depth).
4. Also output each employee's **depth** in the org tree (CEO/top = 0) and their **path** of titles from the root (e.g. `General Manager > Sales Manager > Sales Support Agent`).
5. For every employee, show what **percentage of their direct manager's rolled-up revenue** their own rolled-up revenue represents (top of tree = `NULL`).

**Definition of done.** One row per employee: `employee_id`, name, `title`, `depth`, `org_path`, `direct_revenue`, `rolled_up_revenue`, `pct_of_manager_rollup`, ordered by `depth` then `rolled_up_revenue` desc.

**Why it's hard.** You can't roll a tree up with a single recursive descent that also aggregates leaf revenue cleanly — most people need a recursive descent to map every employee to all descendants (or a bottom-up accumulation), then join back to per-rep revenue. The manager-percentage step forces a second self-reference.

---

## Challenge 3 — Genre Co-Purchase Affinity (Market Basket: Support / Confidence / Lift)

**Business scenario.** Merchandising wants to know which **genres sell together** inside a single invoice so they can build cross-promotions ("customers buying Metal also buy…").

**Requirements.**

1. Treat each `invoice` as a basket. A basket "contains" a genre if any line item's track belongs to that genre (`invoice_line → track → genre`).
2. For every **unordered pair of distinct genres (A, B)** that co-occur in at least one basket, compute:
  - `support_ab` = (# baskets containing both A and B) / (total # baskets).
  - `confidence_a_to_b` = P(B | A) = baskets with both / baskets with A.
  - `lift` = support_ab / (support_a × support_b), where `support_x` = baskets containing X / total baskets.
3. Avoid mirror-duplicate pairs (don't report both `Rock|Jazz` and `Jazz|Rock`) — enforce `genre_a.name < genre_b.name`.
4. Keep only pairs co-occurring in **at least 5 baskets** and with **lift > 1** (positive association).
5. Rank by `lift` descending; return the top 15.

**Definition of done.** Columns: `genre_a`, `genre_b`, `baskets_with_both`, `support_ab`, `confidence_a_to_b`, `lift`. Values rounded sensibly.

**Why it's hard.** Requires de-duplicating genres per basket first (a track-level join will double count), a self-join of the basket-genre set with an asymmetric inequality to kill mirror pairs, and three correlated denominators (total baskets, baskets-with-A, baskets-with-B) combined into the lift formula.