# Chinook Database Reference

> Digital media store sample database (albums, artists, tracks, customers, invoices). Classic SQL learning dataset.

Generated: 2026-06-21

## Overview

| Metric | Value |
|--------|-------|
| Database | `chinook` |
| Schema | `public` |
| Tables | 11 |
| Total rows | 15,607 |

### Table Summary

| Table | Rows |
|-------|-----:|
| [album](#album) | 347 |
| [artist](#artist) | 275 |
| [customer](#customer) | 59 |
| [employee](#employee) | 8 |
| [genre](#genre) | 25 |
| [invoice](#invoice) | 412 |
| [invoice_line](#invoice-line) | 2,240 |
| [media_type](#media-type) | 5 |
| [playlist](#playlist) | 18 |
| [playlist_track](#playlist-track) | 8,715 |
| [track](#track) | 3,503 |

---

## album

**Row count:** 347

**Primary key:** `album_id`

**Foreign keys:**
- `artist_id` → `artist.artist_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `album_id` | integer | NO | — |
| `title` | character varying(160) | NO | — |
| `artist_id` | integer | NO | — |

### Sample Data

*First 5 of 347 rows:*

| `album_id` | `title` | `artist_id` |
| --- | --- | --- |
| 1 | For Those About To Rock We Salute You | 1 |
| 2 | Balls to the Wall | 2 |
| 3 | Restless and Wild | 2 |
| 4 | Let There Be Rock | 1 |
| 5 | Big Ones | 3 |

---

## artist

**Row count:** 275

**Primary key:** `artist_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `artist_id` | integer | NO | — |
| `name` | character varying(120) | YES | — |

### Sample Data

*First 5 of 275 rows:*

| `artist_id` | `name` |
| --- | --- |
| 1 | AC/DC |
| 2 | Accept |
| 3 | Aerosmith |
| 4 | Alanis Morissette |
| 5 | Alice In Chains |

---

## customer

**Row count:** 59

**Primary key:** `customer_id`

**Foreign keys:**
- `support_rep_id` → `employee.employee_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `customer_id` | integer | NO | — |
| `first_name` | character varying(40) | NO | — |
| `last_name` | character varying(20) | NO | — |
| `company` | character varying(80) | YES | — |
| `address` | character varying(70) | YES | — |
| `city` | character varying(40) | YES | — |
| `state` | character varying(40) | YES | — |
| `country` | character varying(40) | YES | — |
| `postal_code` | character varying(10) | YES | — |
| `phone` | character varying(24) | YES | — |
| `fax` | character varying(24) | YES | — |
| `email` | character varying(60) | NO | — |
| `support_rep_id` | integer | YES | — |

### Sample Data

*First 5 of 59 rows:*

| `customer_id` | `first_name` | `last_name` | `company` | `address` | `city` | `state` | `country` | `postal_code` | `phone` | `fax` | `email` | `support_rep_id` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Luís | Gonçalves | Embraer - Empresa Brasileira de Aeronáutica S.A. | Av. Brigadeiro Faria Lima, 2170 | São José dos Campos | SP | Brazil | 12227-000 | +55 (12) 3923-5555 | +55 (12) 3923-5566 | luisg@embraer.com.br | 3 |
| 2 | Leonie | Köhler | — | Theodor-Heuss-Straße 34 | Stuttgart | — | Germany | 70174 | +49 0711 2842222 | — | leonekohler@surfeu.de | 5 |
| 3 | François | Tremblay | — | 1498 rue Bélanger | Montréal | QC | Canada | H2G 1A7 | +1 (514) 721-4711 | — | ftremblay@gmail.com | 3 |
| 4 | Bjørn | Hansen | — | Ullevålsveien 14 | Oslo | — | Norway | 0171 | +47 22 44 22 22 | — | bjorn.hansen@yahoo.no | 4 |
| 5 | František | Wichterlová | JetBrains s.r.o. | Klanova 9/506 | Prague | — | Czech Republic | 14700 | +420 2 4172 5555 | +420 2 4172 5555 | frantisekw@jetbrains.com | 4 |

---

## employee

**Row count:** 8

**Primary key:** `employee_id`

**Foreign keys:**
- `reports_to` → `employee.employee_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `employee_id` | integer | NO | — |
| `last_name` | character varying(20) | NO | — |
| `first_name` | character varying(20) | NO | — |
| `title` | character varying(30) | YES | — |
| `reports_to` | integer | YES | — |
| `birth_date` | timestamp without time zone | YES | — |
| `hire_date` | timestamp without time zone | YES | — |
| `address` | character varying(70) | YES | — |
| `city` | character varying(40) | YES | — |
| `state` | character varying(40) | YES | — |
| `country` | character varying(40) | YES | — |
| `postal_code` | character varying(10) | YES | — |
| `phone` | character varying(24) | YES | — |
| `fax` | character varying(24) | YES | — |
| `email` | character varying(60) | YES | — |

### Sample Data

*All 8 rows:*

| `employee_id` | `last_name` | `first_name` | `title` | `reports_to` | `birth_date` | `hire_date` | `address` | `city` | `state` | `country` | `postal_code` | `phone` | `fax` | `email` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Adams | Andrew | General Manager | — | 1962-02-18 00:00:00 | 2002-08-14 00:00:00 | 11120 Jasper Ave NW | Edmonton | AB | Canada | T5K 2N1 | +1 (780) 428-9482 | +1 (780) 428-3457 | andrew@chinookcorp.com |
| 2 | Edwards | Nancy | Sales Manager | 1 | 1958-12-08 00:00:00 | 2002-05-01 00:00:00 | 825 8 Ave SW | Calgary | AB | Canada | T2P 2T3 | +1 (403) 262-3443 | +1 (403) 262-3322 | nancy@chinookcorp.com |
| 3 | Peacock | Jane | Sales Support Agent | 2 | 1973-08-29 00:00:00 | 2002-04-01 00:00:00 | 1111 6 Ave SW | Calgary | AB | Canada | T2P 5M5 | +1 (403) 262-3443 | +1 (403) 262-6712 | jane@chinookcorp.com |
| 4 | Park | Margaret | Sales Support Agent | 2 | 1947-09-19 00:00:00 | 2003-05-03 00:00:00 | 683 10 Street SW | Calgary | AB | Canada | T2P 5G3 | +1 (403) 263-4423 | +1 (403) 263-4289 | margaret@chinookcorp.com |
| 5 | Johnson | Steve | Sales Support Agent | 2 | 1965-03-03 00:00:00 | 2003-10-17 00:00:00 | 7727B 41 Ave | Calgary | AB | Canada | T3B 1Y7 | 1 (780) 836-9987 | 1 (780) 836-9543 | steve@chinookcorp.com |
| 6 | Mitchell | Michael | IT Manager | 1 | 1973-07-01 00:00:00 | 2003-10-17 00:00:00 | 5827 Bowness Road NW | Calgary | AB | Canada | T3B 0C5 | +1 (403) 246-9887 | +1 (403) 246-9899 | michael@chinookcorp.com |
| 7 | King | Robert | IT Staff | 6 | 1970-05-29 00:00:00 | 2004-01-02 00:00:00 | 590 Columbia Boulevard West | Lethbridge | AB | Canada | T1K 5N8 | +1 (403) 456-9986 | +1 (403) 456-8485 | robert@chinookcorp.com |
| 8 | Callahan | Laura | IT Staff | 6 | 1968-01-09 00:00:00 | 2004-03-04 00:00:00 | 923 7 ST NW | Lethbridge | AB | Canada | T1H 1Y8 | +1 (403) 467-3351 | +1 (403) 467-8772 | laura@chinookcorp.com |

---

## genre

**Row count:** 25

**Primary key:** `genre_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `genre_id` | integer | NO | — |
| `name` | character varying(120) | YES | — |

### Sample Data

*All 25 rows:*

| `genre_id` | `name` |
| --- | --- |
| 1 | Rock |
| 2 | Jazz |
| 3 | Metal |
| 4 | Alternative & Punk |
| 5 | Rock And Roll |
| 6 | Blues |
| 7 | Latin |
| 8 | Reggae |
| 9 | Pop |
| 10 | Soundtrack |
| 11 | Bossa Nova |
| 12 | Easy Listening |
| 13 | Heavy Metal |
| 14 | R&B/Soul |
| 15 | Electronica/Dance |
| 16 | World |
| 17 | Hip Hop/Rap |
| 18 | Science Fiction |
| 19 | TV Shows |
| 20 | Sci Fi & Fantasy |
| 21 | Drama |
| 22 | Comedy |
| 23 | Alternative |
| 24 | Classical |
| 25 | Opera |

---

## invoice

**Row count:** 412

**Primary key:** `invoice_id`

**Foreign keys:**
- `customer_id` → `customer.customer_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `invoice_id` | integer | NO | — |
| `customer_id` | integer | NO | — |
| `invoice_date` | timestamp without time zone | NO | — |
| `billing_address` | character varying(70) | YES | — |
| `billing_city` | character varying(40) | YES | — |
| `billing_state` | character varying(40) | YES | — |
| `billing_country` | character varying(40) | YES | — |
| `billing_postal_code` | character varying(10) | YES | — |
| `total` | numeric(10,2) | NO | — |

### Sample Data

*First 5 of 412 rows:*

| `invoice_id` | `customer_id` | `invoice_date` | `billing_address` | `billing_city` | `billing_state` | `billing_country` | `billing_postal_code` | `total` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 2 | 2021-01-01 00:00:00 | Theodor-Heuss-Straße 34 | Stuttgart | — | Germany | 70174 | 1.98 |
| 2 | 4 | 2021-01-02 00:00:00 | Ullevålsveien 14 | Oslo | — | Norway | 0171 | 3.96 |
| 3 | 8 | 2021-01-03 00:00:00 | Grétrystraat 63 | Brussels | — | Belgium | 1000 | 5.94 |
| 4 | 14 | 2021-01-06 00:00:00 | 8210 111 ST NW | Edmonton | AB | Canada | T6G 2C7 | 8.91 |
| 5 | 23 | 2021-01-11 00:00:00 | 69 Salem Street | Boston | MA | USA | 2113 | 13.86 |

---

## invoice_line

**Row count:** 2,240

**Primary key:** `invoice_line_id`

**Foreign keys:**
- `invoice_id` → `invoice.invoice_id`
- `track_id` → `track.track_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `invoice_line_id` | integer | NO | — |
| `invoice_id` | integer | NO | — |
| `track_id` | integer | NO | — |
| `unit_price` | numeric(10,2) | NO | — |
| `quantity` | integer | NO | — |

### Sample Data

*First 5 of 2,240 rows:*

| `invoice_line_id` | `invoice_id` | `track_id` | `unit_price` | `quantity` |
| --- | --- | --- | --- | --- |
| 1 | 1 | 2 | 0.99 | 1 |
| 2 | 1 | 4 | 0.99 | 1 |
| 3 | 2 | 6 | 0.99 | 1 |
| 4 | 2 | 8 | 0.99 | 1 |
| 5 | 2 | 10 | 0.99 | 1 |

---

## media_type

**Row count:** 5

**Primary key:** `media_type_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `media_type_id` | integer | NO | — |
| `name` | character varying(120) | YES | — |

### Sample Data

*All 5 rows:*

| `media_type_id` | `name` |
| --- | --- |
| 1 | MPEG audio file |
| 2 | Protected AAC audio file |
| 3 | Protected MPEG-4 video file |
| 4 | Purchased AAC audio file |
| 5 | AAC audio file |

---

## playlist

**Row count:** 18

**Primary key:** `playlist_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `playlist_id` | integer | NO | — |
| `name` | character varying(120) | YES | — |

### Sample Data

*All 18 rows:*

| `playlist_id` | `name` |
| --- | --- |
| 1 | Music |
| 2 | Movies |
| 3 | TV Shows |
| 4 | Audiobooks |
| 5 | 90’s Music |
| 6 | Audiobooks |
| 7 | Movies |
| 8 | Music |
| 9 | Music Videos |
| 10 | TV Shows |
| 11 | Brazilian Music |
| 12 | Classical |
| 13 | Classical 101 - Deep Cuts |
| 14 | Classical 101 - Next Steps |
| 15 | Classical 101 - The Basics |
| 16 | Grunge |
| 17 | Heavy Metal Classic |
| 18 | On-The-Go 1 |

---

## playlist_track

**Row count:** 8,715

**Primary key:** `playlist_id, track_id`

**Foreign keys:**
- `playlist_id` → `playlist.playlist_id`
- `track_id` → `track.track_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `playlist_id` | integer | NO | — |
| `track_id` | integer | NO | — |

### Sample Data

*First 5 of 8,715 rows:*

| `playlist_id` | `track_id` |
| --- | --- |
| 1 | 3402 |
| 1 | 3389 |
| 1 | 3390 |
| 1 | 3391 |
| 1 | 3392 |

---

## track

**Row count:** 3,503

**Primary key:** `track_id`

**Foreign keys:**
- `album_id` → `album.album_id`
- `genre_id` → `genre.genre_id`
- `media_type_id` → `media_type.media_type_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `track_id` | integer | NO | — |
| `name` | character varying(200) | NO | — |
| `album_id` | integer | YES | — |
| `media_type_id` | integer | NO | — |
| `genre_id` | integer | YES | — |
| `composer` | character varying(220) | YES | — |
| `milliseconds` | integer | NO | — |
| `bytes` | integer | YES | — |
| `unit_price` | numeric(10,2) | NO | — |

### Sample Data

*First 5 of 3,503 rows:*

| `track_id` | `name` | `album_id` | `media_type_id` | `genre_id` | `composer` | `milliseconds` | `bytes` | `unit_price` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | For Those About To Rock (We Salute You) | 1 | 1 | 1 | Angus Young, Malcolm Young, Brian Johnson | 343719 | 11170334 | 0.99 |
| 2 | Balls to the Wall | 2 | 2 | 1 | U. Dirkschneider, W. Hoffmann, H. Frank, P. Baltes… | 342562 | 5510424 | 0.99 |
| 3 | Fast As a Shark | 3 | 2 | 1 | F. Baltes, S. Kaufman, U. Dirkscneider & W. Hoffma… | 230619 | 3990994 | 0.99 |
| 4 | Restless and Wild | 3 | 2 | 1 | F. Baltes, R.A. Smith-Diesel, S. Kaufman, U. Dirks… | 252051 | 4331779 | 0.99 |
| 5 | Princess of the Dawn | 3 | 2 | 1 | Deaffy & R.A. Smith-Diesel | 375418 | 6290521 | 0.99 |

---
