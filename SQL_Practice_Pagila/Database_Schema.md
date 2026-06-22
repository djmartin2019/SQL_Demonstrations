# Pagila Database Reference

> PostgreSQL port of Sakila DVD rental store (films, actors, rentals, payments). Includes partitioned payment tables.

Generated: 2026-06-21

## Overview

| Metric | Value |
|--------|-------|
| Database | `pagila` |
| Schema | `public` |
| Tables | 22 |
| Total rows | 65,685 |

### Table Summary

| Table | Rows |
|-------|-----:|
| [actor](#actor) | 200 |
| [address](#address) | 603 |
| [category](#category) | 16 |
| [city](#city) | 600 |
| [country](#country) | 109 |
| [customer](#customer) | 599 |
| [film](#film) | 1,000 |
| [film_actor](#film-actor) | 5,462 |
| [film_category](#film-category) | 2,367 |
| [inventory](#inventory) | 4,581 |
| [language](#language) | 6 |
| [payment](#payment) | 16,049 |
| [payment_p2022_01](#payment-p2022-01) | 723 |
| [payment_p2022_02](#payment-p2022-02) | 2,401 |
| [payment_p2022_03](#payment-p2022-03) | 2,713 |
| [payment_p2022_04](#payment-p2022-04) | 2,547 |
| [payment_p2022_05](#payment-p2022-05) | 2,677 |
| [payment_p2022_06](#payment-p2022-06) | 2,654 |
| [payment_p2022_07](#payment-p2022-07) | 2,334 |
| [rental](#rental) | 16,044 |
| [staff](#staff) | 1,500 |
| [store](#store) | 500 |

---

## actor

**Row count:** 200

**Primary key:** `actor_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `actor_id` | integer | NO | nextval('actor_actor_id_seq'::regclass) |
| `first_name` | text | NO | — |
| `last_name` | text | NO | — |
| `last_update` | timestamp with time zone | NO | now() |

### Sample Data

*First 5 of 200 rows:*

| `actor_id` | `first_name` | `last_name` | `last_update` |
| --- | --- | --- | --- |
| 1 | PENELOPE | GUINESS | 2022-02-15 04:34:33-05 |
| 2 | NICK | WAHLBERG | 2022-02-15 04:34:33-05 |
| 3 | ED | CHASE | 2022-02-15 04:34:33-05 |
| 4 | JENNIFER | DAVIS | 2022-02-15 04:34:33-05 |
| 5 | JOHNNY | LOLLOBRIGIDA | 2022-02-15 04:34:33-05 |

---

## address

**Row count:** 603

**Primary key:** `address_id`

**Foreign keys:**
- `city_id` → `city.city_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `address_id` | integer | NO | nextval('address_address_id_seq'::regclass) |
| `address` | text | NO | — |
| `address2` | text | YES | — |
| `district` | text | NO | — |
| `city_id` | integer | NO | — |
| `postal_code` | text | YES | — |
| `phone` | text | NO | — |
| `last_update` | timestamp with time zone | NO | now() |

### Sample Data

*First 5 of 603 rows:*

| `address_id` | `address` | `address2` | `district` | `city_id` | `postal_code` | `phone` | `last_update` |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 47 MySakila Drive | — | Alberta | 300 | — | — | 2022-02-15 04:45:30-05 |
| 2 | 28 MySQL Boulevard | — | QLD | 576 | — | — | 2022-02-15 04:45:30-05 |
| 3 | 23 Workhaven Lane | — | Alberta | 300 | — | 14033335568 | 2022-02-15 04:45:30-05 |
| 4 | 1411 Lillydale Drive | — | QLD | 576 | — | 6172235589 | 2022-02-15 04:45:30-05 |
| 5 | 1913 Hanoi Way | — | Nagasaki | 463 | 35200 | 28303384290 | 2022-02-15 04:45:30-05 |

---

## category

**Row count:** 16

**Primary key:** `category_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `category_id` | integer | NO | nextval('category_category_id_seq'::regclass) |
| `name` | text | NO | — |
| `last_update` | timestamp with time zone | NO | now() |

### Sample Data

*All 16 rows:*

| `category_id` | `name` | `last_update` |
| --- | --- | --- |
| 1 | Action | 2022-02-15 04:46:27-05 |
| 2 | Animation | 2022-02-15 04:46:27-05 |
| 3 | Children | 2022-02-15 04:46:27-05 |
| 4 | Classics | 2022-02-15 04:46:27-05 |
| 5 | Comedy | 2022-02-15 04:46:27-05 |
| 6 | Documentary | 2022-02-15 04:46:27-05 |
| 7 | Drama | 2022-02-15 04:46:27-05 |
| 8 | Family | 2022-02-15 04:46:27-05 |
| 9 | Foreign | 2022-02-15 04:46:27-05 |
| 10 | Games | 2022-02-15 04:46:27-05 |
| 11 | Horror | 2022-02-15 04:46:27-05 |
| 12 | Music | 2022-02-15 04:46:27-05 |
| 13 | New | 2022-02-15 04:46:27-05 |
| 14 | Sci-Fi | 2022-02-15 04:46:27-05 |
| 15 | Sports | 2022-02-15 04:46:27-05 |
| 16 | Travel | 2022-02-15 04:46:27-05 |

---

## city

**Row count:** 600

**Primary key:** `city_id`

**Foreign keys:**
- `country_id` → `country.country_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `city_id` | integer | NO | nextval('city_city_id_seq'::regclass) |
| `city` | text | NO | — |
| `country_id` | integer | NO | — |
| `last_update` | timestamp with time zone | NO | now() |

### Sample Data

*First 5 of 600 rows:*

| `city_id` | `city` | `country_id` | `last_update` |
| --- | --- | --- | --- |
| 1 | A Corua (La Corua) | 87 | 2022-02-15 04:45:25-05 |
| 2 | Abha | 82 | 2022-02-15 04:45:25-05 |
| 3 | Abu Dhabi | 101 | 2022-02-15 04:45:25-05 |
| 4 | Acua | 60 | 2022-02-15 04:45:25-05 |
| 5 | Adana | 97 | 2022-02-15 04:45:25-05 |

---

## country

**Row count:** 109

**Primary key:** `country_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `country_id` | integer | NO | nextval('country_country_id_seq'::regclass) |
| `country` | text | NO | — |
| `last_update` | timestamp with time zone | NO | now() |

### Sample Data

*First 5 of 109 rows:*

| `country_id` | `country` | `last_update` |
| --- | --- | --- |
| 1 | Afghanistan | 2022-02-15 04:44:00-05 |
| 2 | Algeria | 2022-02-15 04:44:00-05 |
| 3 | American Samoa | 2022-02-15 04:44:00-05 |
| 4 | Angola | 2022-02-15 04:44:00-05 |
| 5 | Anguilla | 2022-02-15 04:44:00-05 |

---

## customer

**Row count:** 599

**Primary key:** `customer_id`

**Foreign keys:**
- `address_id` → `address.address_id`
- `store_id` → `store.store_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `customer_id` | integer | NO | nextval('customer_customer_id_seq'::regclass) |
| `store_id` | integer | NO | — |
| `first_name` | text | NO | — |
| `last_name` | text | NO | — |
| `email` | text | YES | — |
| `address_id` | integer | NO | — |
| `activebool` | boolean | NO | true |
| `create_date` | date | NO | CURRENT_DATE |
| `last_update` | timestamp with time zone | YES | now() |
| `active` | integer | YES | — |

### Sample Data

*First 5 of 599 rows:*

| `customer_id` | `store_id` | `first_name` | `last_name` | `email` | `address_id` | `activebool` | `create_date` | `last_update` | `active` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 1 | MARY | SMITH | MARY.SMITH@sakilacustomer.org | 5 | t | 2022-02-14 | 2022-02-15 04:57:20-05 | 1 |
| 2 | 1 | PATRICIA | JOHNSON | PATRICIA.JOHNSON@sakilacustomer.org | 6 | t | 2022-02-14 | 2022-02-15 04:57:20-05 | 1 |
| 3 | 1 | LINDA | WILLIAMS | LINDA.WILLIAMS@sakilacustomer.org | 7 | t | 2022-02-14 | 2022-02-15 04:57:20-05 | 1 |
| 4 | 2 | BARBARA | JONES | BARBARA.JONES@sakilacustomer.org | 8 | t | 2022-02-14 | 2022-02-15 04:57:20-05 | 1 |
| 5 | 1 | ELIZABETH | BROWN | ELIZABETH.BROWN@sakilacustomer.org | 9 | t | 2022-02-14 | 2022-02-15 04:57:20-05 | 1 |

---

## film

**Row count:** 1,000

**Primary key:** `film_id`

**Foreign keys:**
- `language_id` → `language.language_id`
- `original_language_id` → `language.language_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `film_id` | integer | NO | nextval('film_film_id_seq'::regclass) |
| `title` | text | NO | — |
| `description` | text | YES | — |
| `release_year` | integer | YES | — |
| `language_id` | integer | NO | — |
| `original_language_id` | integer | YES | — |
| `rental_duration` | smallint | NO | 3 |
| `rental_rate` | numeric(4,2) | NO | 4.99 |
| `length` | smallint | YES | — |
| `replacement_cost` | numeric(5,2) | NO | 19.99 |
| `rating` | USER-DEFINED | YES | 'G'::mpaa_rating |
| `last_update` | timestamp with time zone | NO | now() |
| `special_features` | ARRAY | YES | — |
| `fulltext` | tsvector | NO | — |

### Sample Data

*First 5 of 1,000 rows:*

| `film_id` | `title` | `description` | `release_year` | `language_id` | `original_language_id` | `rental_duration` | `rental_rate` | `length` | `replacement_cost` | `rating` | `last_update` | `special_features` | `fulltext` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | ACADEMY DINOSAUR | A Epic Drama of a Feminist And a Mad Scientist who… | 2012 | 1 | — | 6 | 0.99 | 86 | 20.99 | PG | 2022-09-10 12:46:03.905795-04 | {"Deleted Scenes","Behind the Scenes"} | 'academi':1 'battl':15 'canadian':20 'dinosaur':2 'drama':5 'epic':4 'feminist':8 'mad':11 'must':14 'rocki':21 'scientist':12 'teacher':17 |
| 2 | ACE GOLDFINGER | A Astounding Epistle of a Database Administrator A… | 2023 | 1 | — | 3 | 4.99 | 48 | 12.99 | G | 2022-09-10 12:46:03.905795-04 | {Trailers,"Deleted Scenes"} | 'ace':1 'administr':9 'ancient':19 'astound':4 'car':17 'china':20 'databas':8 'epistl':5 'explor':12 'find':15 'goldfing':2 'must':14 |
| 3 | ADAPTATION HOLES | A Astounding Reflection of a Lumberjack And a Car … | 2017 | 2 | — | 7 | 2.99 | 50 | 18.99 | NC-17 | 2022-09-10 12:46:03.905795-04 | {Trailers,"Deleted Scenes"} | 'adapt':1 'astound':4 'baloon':19 'car':11 'factori':20 'hole':2 'lumberjack':8,16 'must':13 'reflect':5 'sink':14 |
| 4 | AFFAIR PREJUDICE | A Fanciful Documentary of a Frisbee And a Lumberja… | 2023 | 6 | — | 5 | 2.99 | 117 | 26.99 | G | 2022-09-10 12:46:03.905795-04 | {Commentaries,"Behind the Scenes"} | 'affair':1 'chase':14 'documentari':5 'fanci':4 'frisbe':8 'lumberjack':11 'monkey':16 'must':13 'prejudic':2 'shark':19 'tank':20 |
| 5 | AFRICAN EGG | A Fast-Paced Documentary of a Pastry Chef And a De… | 2019 | 4 | — | 6 | 2.99 | 130 | 22.99 | G | 2022-09-10 12:46:03.905795-04 | {"Deleted Scenes"} | 'african':1 'chef':11 'dentist':14 'documentari':7 'egg':2 'fast':5 'fast-pac':4 'forens':19 'gulf':23 'mexico':25 'must':16 'pace':6 'pastri':10 'psychologist':20 'pursu':17 |

---

## film_actor

**Row count:** 5,462

**Primary key:** `actor_id, film_id`

**Foreign keys:**
- `actor_id` → `actor.actor_id`
- `film_id` → `film.film_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `actor_id` | integer | NO | — |
| `film_id` | integer | NO | — |
| `last_update` | timestamp with time zone | NO | now() |

### Sample Data

*First 5 of 5,462 rows:*

| `actor_id` | `film_id` | `last_update` |
| --- | --- | --- |
| 1 | 1 | 2022-02-15 05:05:03-05 |
| 1 | 23 | 2022-02-15 05:05:03-05 |
| 1 | 25 | 2022-02-15 05:05:03-05 |
| 1 | 106 | 2022-02-15 05:05:03-05 |
| 1 | 140 | 2022-02-15 05:05:03-05 |

---

## film_category

**Row count:** 2,367

**Primary key:** `film_id, category_id`

**Foreign keys:**
- `category_id` → `category.category_id`
- `film_id` → `film.film_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `film_id` | integer | NO | — |
| `category_id` | integer | NO | — |
| `last_update` | timestamp with time zone | NO | now() |

### Sample Data

*First 5 of 2,367 rows:*

| `film_id` | `category_id` | `last_update` |
| --- | --- | --- |
| 56 | 11 | 2022-02-15 05:07:09-05 |
| 62 | 5 | 2022-02-15 05:07:09-05 |
| 95 | 6 | 2022-02-15 05:07:09-05 |
| 39 | 8 | 2022-02-15 05:07:09-05 |
| 5 | 9 | 2022-02-15 05:07:09-05 |

---

## inventory

**Row count:** 4,581

**Primary key:** `inventory_id`

**Foreign keys:**
- `film_id` → `film.film_id`
- `store_id` → `store.store_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `inventory_id` | integer | NO | nextval('inventory_inventory_id_seq'::regclass) |
| `film_id` | integer | NO | — |
| `store_id` | integer | NO | — |
| `last_update` | timestamp with time zone | NO | now() |

### Sample Data

*First 5 of 4,581 rows:*

| `inventory_id` | `film_id` | `store_id` | `last_update` |
| --- | --- | --- | --- |
| 1 | 1 | 1 | 2022-02-15 05:09:17-05 |
| 2 | 1 | 1 | 2022-02-15 05:09:17-05 |
| 3 | 1 | 1 | 2022-02-15 05:09:17-05 |
| 4 | 1 | 1 | 2022-02-15 05:09:17-05 |
| 5 | 1 | 2 | 2022-02-15 05:09:17-05 |

---

## language

**Row count:** 6

**Primary key:** `language_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `language_id` | integer | NO | nextval('language_language_id_seq'::regclass) |
| `name` | character(20) | NO | — |
| `last_update` | timestamp with time zone | NO | now() |

### Sample Data

*All 6 rows:*

| `language_id` | `name` | `last_update` |
| --- | --- | --- |
| 1 | English | 2022-02-15 05:02:19-05 |
| 2 | Italian | 2022-02-15 05:02:19-05 |
| 3 | Japanese | 2022-02-15 05:02:19-05 |
| 4 | Mandarin | 2022-02-15 05:02:19-05 |
| 5 | French | 2022-02-15 05:02:19-05 |
| 6 | German | 2022-02-15 05:02:19-05 |

---

## payment

**Row count:** 16,049

**Primary key:** `payment_id, payment_date`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `payment_id` | integer | NO | nextval('payment_payment_id_seq'::regclass) |
| `customer_id` | integer | NO | — |
| `staff_id` | integer | NO | — |
| `rental_id` | integer | NO | — |
| `amount` | numeric(5,2) | NO | — |
| `payment_date` | timestamp with time zone | NO | — |

### Sample Data

*First 5 of 16,049 rows:*

| `payment_id` | `customer_id` | `staff_id` | `rental_id` | `amount` | `payment_date` |
| --- | --- | --- | --- | --- | --- |
| 16051 | 269 | 1 | 98 | 0.99 | 2022-01-28 20:58:52.222594-05 |
| 16065 | 274 | 1 | 147 | 2.99 | 2022-01-25 07:14:16.895377-05 |
| 16109 | 297 | 2 | 143 | 0.99 | 2022-01-27 19:49:49.128218-05 |
| 16195 | 344 | 2 | 157 | 2.99 | 2022-01-31 00:58:51.176578-05 |
| 16202 | 348 | 2 | 821 | 0.99 | 2022-01-26 11:52:41.359433-05 |

---

## payment_p2022_01

**Row count:** 723

**Primary key:** `payment_id, payment_date`

**Foreign keys:**
- `customer_id` → `customer.customer_id`
- `rental_id` → `rental.rental_id`
- `staff_id` → `staff.staff_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `payment_id` | integer | NO | nextval('payment_payment_id_seq'::regclass) |
| `customer_id` | integer | NO | — |
| `staff_id` | integer | NO | — |
| `rental_id` | integer | NO | — |
| `amount` | numeric(5,2) | NO | — |
| `payment_date` | timestamp with time zone | NO | — |

### Sample Data

*First 5 of 723 rows:*

| `payment_id` | `customer_id` | `staff_id` | `rental_id` | `amount` | `payment_date` |
| --- | --- | --- | --- | --- | --- |
| 16051 | 269 | 1 | 98 | 0.99 | 2022-01-28 20:58:52.222594-05 |
| 16065 | 274 | 1 | 147 | 2.99 | 2022-01-25 07:14:16.895377-05 |
| 16109 | 297 | 2 | 143 | 0.99 | 2022-01-27 19:49:49.128218-05 |
| 16195 | 344 | 2 | 157 | 2.99 | 2022-01-31 00:58:51.176578-05 |
| 16202 | 348 | 2 | 821 | 0.99 | 2022-01-26 11:52:41.359433-05 |

---

## payment_p2022_02

**Row count:** 2,401

**Primary key:** `payment_id, payment_date`

**Foreign keys:**
- `customer_id` → `customer.customer_id`
- `rental_id` → `rental.rental_id`
- `staff_id` → `staff.staff_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `payment_id` | integer | NO | nextval('payment_payment_id_seq'::regclass) |
| `customer_id` | integer | NO | — |
| `staff_id` | integer | NO | — |
| `rental_id` | integer | NO | — |
| `amount` | numeric(5,2) | NO | — |
| `payment_date` | timestamp with time zone | NO | — |

### Sample Data

*First 5 of 2,401 rows:*

| `payment_id` | `customer_id` | `staff_id` | `rental_id` | `amount` | `payment_date` |
| --- | --- | --- | --- | --- | --- |
| 16056 | 270 | 1 | 193 | 1.99 | 2022-02-02 20:49:30.663659-05 |
| 16075 | 278 | 1 | 1092 | 4.99 | 2022-02-14 11:08:09.981165-05 |
| 16077 | 279 | 2 | 1019 | 0.99 | 2022-02-09 16:43:26.740315-05 |
| 16078 | 280 | 1 | 1014 | 4.99 | 2022-02-05 19:01:36.023609-05 |
| 16103 | 294 | 1 | 595 | 1.99 | 2022-02-02 00:00:37.57789-05 |

---

## payment_p2022_03

**Row count:** 2,713

**Primary key:** `payment_id, payment_date`

**Foreign keys:**
- `customer_id` → `customer.customer_id`
- `rental_id` → `rental.rental_id`
- `staff_id` → `staff.staff_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `payment_id` | integer | NO | nextval('payment_payment_id_seq'::regclass) |
| `customer_id` | integer | NO | — |
| `staff_id` | integer | NO | — |
| `rental_id` | integer | NO | — |
| `amount` | numeric(5,2) | NO | — |
| `payment_date` | timestamp with time zone | NO | — |

### Sample Data

*First 5 of 2,713 rows:*

| `payment_id` | `customer_id` | `staff_id` | `rental_id` | `amount` | `payment_date` |
| --- | --- | --- | --- | --- | --- |
| 16053 | 269 | 2 | 703 | 0.99 | 2022-03-02 14:51:40.813503-05 |
| 16058 | 271 | 1 | 1096 | 8.99 | 2022-03-19 02:19:47.019162-04 |
| 16059 | 272 | 1 | 33 | 0.99 | 2022-03-12 08:32:36.628975-05 |
| 16060 | 272 | 1 | 405 | 6.99 | 2022-03-17 21:40:43.327915-04 |
| 16063 | 273 | 2 | 122 | 3.99 | 2022-03-14 08:07:41.127016-04 |

---

## payment_p2022_04

**Row count:** 2,547

**Primary key:** `payment_id, payment_date`

**Foreign keys:**
- `customer_id` → `customer.customer_id`
- `rental_id` → `rental.rental_id`
- `staff_id` → `staff.staff_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `payment_id` | integer | NO | nextval('payment_payment_id_seq'::regclass) |
| `customer_id` | integer | NO | — |
| `staff_id` | integer | NO | — |
| `rental_id` | integer | NO | — |
| `amount` | numeric(5,2) | NO | — |
| `payment_date` | timestamp with time zone | NO | — |

### Sample Data

*First 5 of 2,547 rows:*

| `payment_id` | `customer_id` | `staff_id` | `rental_id` | `amount` | `payment_date` |
| --- | --- | --- | --- | --- | --- |
| 16066 | 274 | 1 | 208 | 4.99 | 2022-04-15 08:28:07.452161-04 |
| 16069 | 274 | 2 | 474 | 2.99 | 2022-04-27 14:46:10.151444-04 |
| 16074 | 277 | 2 | 308 | 6.99 | 2022-04-04 06:51:07.496345-04 |
| 16091 | 288 | 2 | 93 | 3.99 | 2022-04-26 06:18:58.440363-04 |
| 16092 | 288 | 2 | 427 | 6.99 | 2022-04-05 09:22:55.687336-04 |

---

## payment_p2022_05

**Row count:** 2,677

**Primary key:** `payment_id, payment_date`

**Foreign keys:**
- `customer_id` → `customer.customer_id`
- `rental_id` → `rental.rental_id`
- `staff_id` → `staff.staff_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `payment_id` | integer | NO | nextval('payment_payment_id_seq'::regclass) |
| `customer_id` | integer | NO | — |
| `staff_id` | integer | NO | — |
| `rental_id` | integer | NO | — |
| `amount` | numeric(5,2) | NO | — |
| `payment_date` | timestamp with time zone | NO | — |

### Sample Data

*First 5 of 2,677 rows:*

| `payment_id` | `customer_id` | `staff_id` | `rental_id` | `amount` | `payment_date` |
| --- | --- | --- | --- | --- | --- |
| 16055 | 269 | 2 | 1099 | 2.99 | 2022-05-20 11:54:02.174545-04 |
| 16057 | 270 | 1 | 1040 | 4.99 | 2022-05-11 05:27:17.752545-04 |
| 16067 | 274 | 2 | 301 | 2.99 | 2022-05-10 23:38:43.477404-04 |
| 16068 | 274 | 1 | 394 | 5.99 | 2022-05-04 03:27:05.030262-04 |
| 16070 | 274 | 1 | 892 | 4.99 | 2022-05-15 01:32:14.136295-04 |

---

## payment_p2022_06

**Row count:** 2,654

**Primary key:** `payment_id, payment_date`

**Foreign keys:**
- `customer_id` → `customer.customer_id`
- `rental_id` → `rental.rental_id`
- `staff_id` → `staff.staff_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `payment_id` | integer | NO | nextval('payment_payment_id_seq'::regclass) |
| `customer_id` | integer | NO | — |
| `staff_id` | integer | NO | — |
| `rental_id` | integer | NO | — |
| `amount` | numeric(5,2) | NO | — |
| `payment_date` | timestamp with time zone | NO | — |

### Sample Data

*First 5 of 2,654 rows:*

| `payment_id` | `customer_id` | `staff_id` | `rental_id` | `amount` | `payment_date` |
| --- | --- | --- | --- | --- | --- |
| 16050 | 269 | 2 | 7 | 1.99 | 2022-06-21 03:41:50.707316-04 |
| 16052 | 269 | 2 | 678 | 6.99 | 2022-06-26 18:37:21.783785-04 |
| 16054 | 269 | 1 | 750 | 4.99 | 2022-06-01 23:29:53.30199-04 |
| 16062 | 272 | 1 | 1072 | 0.99 | 2022-06-14 21:19:29.001208-04 |
| 16073 | 276 | 1 | 860 | 10.99 | 2022-06-03 16:10:31.235993-04 |

---

## payment_p2022_07

**Row count:** 2,334

**Primary key:** `payment_id, payment_date`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `payment_id` | integer | NO | nextval('payment_payment_id_seq'::regclass) |
| `customer_id` | integer | NO | — |
| `staff_id` | integer | NO | — |
| `rental_id` | integer | NO | — |
| `amount` | numeric(5,2) | NO | — |
| `payment_date` | timestamp with time zone | NO | — |

### Sample Data

*First 5 of 2,334 rows:*

| `payment_id` | `customer_id` | `staff_id` | `rental_id` | `amount` | `payment_date` |
| --- | --- | --- | --- | --- | --- |
| 16061 | 272 | 1 | 1041 | 6.99 | 2022-07-19 02:32:02.911937-04 |
| 16064 | 273 | 2 | 980 | 0.99 | 2022-07-07 03:15:37.160099-04 |
| 16071 | 275 | 2 | 336 | 2.99 | 2022-07-04 05:47:03.440928-04 |
| 16072 | 276 | 1 | 736 | 3.99 | 2022-07-11 00:46:45.091689-04 |
| 16076 | 279 | 1 | 979 | 2.99 | 2022-07-24 06:07:49.460456-04 |

---

## rental

**Row count:** 16,044

**Primary key:** `rental_id`

**Foreign keys:**
- `customer_id` → `customer.customer_id`
- `inventory_id` → `inventory.inventory_id`
- `staff_id` → `staff.staff_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `rental_id` | integer | NO | nextval('rental_rental_id_seq'::regclass) |
| `rental_date` | timestamp with time zone | NO | — |
| `inventory_id` | integer | NO | — |
| `customer_id` | integer | NO | — |
| `return_date` | timestamp with time zone | YES | — |
| `staff_id` | integer | NO | — |
| `last_update` | timestamp with time zone | NO | now() |

### Sample Data

*First 5 of 16,044 rows:*

| `rental_id` | `rental_date` | `inventory_id` | `customer_id` | `return_date` | `staff_id` | `last_update` |
| --- | --- | --- | --- | --- | --- | --- |
| 2 | 2022-05-24 17:54:33-04 | 1525 | 459 | 2022-05-28 14:40:33-04 | 1 | 2022-02-15 21:30:53-05 |
| 3 | 2022-05-24 18:03:39-04 | 1711 | 408 | 2022-06-01 17:12:39-04 | 1 | 2022-02-15 21:30:53-05 |
| 4 | 2022-05-24 18:04:41-04 | 2452 | 333 | 2022-06-02 20:43:41-04 | 2 | 2022-02-15 21:30:53-05 |
| 5 | 2022-05-24 18:05:21-04 | 2079 | 222 | 2022-06-01 23:33:21-04 | 1 | 2022-02-15 21:30:53-05 |
| 6 | 2022-05-24 18:08:07-04 | 2792 | 549 | 2022-05-26 20:32:07-04 | 1 | 2022-02-15 21:30:53-05 |

---

## staff

**Row count:** 1,500

**Primary key:** `staff_id`

**Foreign keys:**
- `address_id` → `address.address_id`
- `store_id` → `store.store_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `staff_id` | integer | NO | nextval('staff_staff_id_seq'::regclass) |
| `first_name` | text | NO | — |
| `last_name` | text | NO | — |
| `address_id` | integer | NO | — |
| `email` | text | YES | — |
| `store_id` | integer | NO | — |
| `active` | boolean | NO | true |
| `username` | text | NO | — |
| `password` | text | YES | — |
| `last_update` | timestamp with time zone | NO | now() |
| `picture` | bytea | YES | — |

### Sample Data

*First 5 of 1,500 rows:*
*Sample omits binary column(s): `picture`.*


| `staff_id` | `first_name` | `last_name` | `address_id` | `email` | `store_id` | `active` | `username` | `password` | `last_update` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | Tisha | DuBuque | 28 | schneider9987@rosenbaumreichert.com | 23 | t | sina.corkery | 8cb2237d0679ca88db6464eac60da96345513964 | 2022-05-16 11:13:11.79328-04 |
| 1 | Warner | Hudson | 45 | hartmann1448@ratkehaley.com | 25 | t | fay.kub | 8cb2237d0679ca88db6464eac60da96345513964 | 2022-05-16 11:13:11.79328-04 |
| 2 | Lavone | O'Reilly | 6 | mclaughlin3045@kleinwisokyandswaniawski.com | 33 | t | gaston.wuckert | 8cb2237d0679ca88db6464eac60da96345513964 | 2022-05-16 11:13:11.79328-04 |
| 3 | Louie | Walter | 28 | ondricka8612@baileykeebler.com | 18 | t | lewis.damore | 8cb2237d0679ca88db6464eac60da96345513964 | 2022-05-16 11:13:11.79328-04 |
| 4 | Domenica | Armstrong | 8 | walsh2658@corkeryinc.com | 3 | t | jannette.effertz | 8cb2237d0679ca88db6464eac60da96345513964 | 2022-05-16 11:13:11.79328-04 |

---

## store

**Row count:** 500

**Primary key:** `store_id`

**Foreign keys:**
- `address_id` → `address.address_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `store_id` | integer | NO | nextval('store_store_id_seq'::regclass) |
| `manager_staff_id` | integer | NO | — |
| `address_id` | integer | NO | — |
| `last_update` | timestamp with time zone | NO | now() |

### Sample Data

*First 5 of 500 rows:*

| `store_id` | `manager_staff_id` | `address_id` | `last_update` |
| --- | --- | --- | --- |
| 0 | 0 | 73 | 2022-02-15 04:57:12-05 |
| 1 | 1 | 129 | 2022-02-15 04:57:12-05 |
| 2 | 2 | 12 | 2022-02-15 04:57:12-05 |
| 3 | 3 | 71 | 2022-02-15 04:57:12-05 |
| 4 | 4 | 18 | 2022-02-15 04:57:12-05 |

---
