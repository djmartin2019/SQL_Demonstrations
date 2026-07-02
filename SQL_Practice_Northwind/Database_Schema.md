# Northwind Database Reference

> Classic Microsoft Northwind trading company sample database (products, orders, customers, employees, suppliers).

Generated: 2026-06-21

## Overview

| Metric | Value |
|--------|-------|
| Database | `northwind` |
| Schema | `public` |
| Tables | 14 |
| Total rows | 3,362 |

### Table Summary

| Table | Rows |
|-------|-----:|
| [categories](#categories) | 8 |
| [customer_customer_demo](#customer-customer-demo) | 0 |
| [customer_demographics](#customer-demographics) | 0 |
| [customers](#customers) | 91 |
| [employee_territories](#employee-territories) | 49 |
| [employees](#employees) | 9 |
| [order_details](#order-details) | 2,155 |
| [orders](#orders) | 830 |
| [products](#products) | 77 |
| [region](#region) | 4 |
| [shippers](#shippers) | 6 |
| [suppliers](#suppliers) | 29 |
| [territories](#territories) | 53 |
| [us_states](#us-states) | 51 |

---

## categories

**Row count:** 8

**Primary key:** `category_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `category_id` | smallint | NO | - |
| `category_name` | character varying(15) | NO | - |
| `description` | text | YES | - |
| `picture` | bytea | YES | - |

### Sample Data

*All 8 rows:*
*Sample omits binary column(s): `picture`.*


| `category_id` | `category_name` | `description` |
| --- | --- | --- |
| 1 | Beverages | Soft drinks, coffees, teas, beers, and ales |
| 2 | Condiments | Sweet and savory sauces, relishes, spreads, and se... |
| 3 | Confections | Desserts, candies, and sweet breads |
| 4 | Dairy Products | Cheeses |
| 5 | Grains/Cereals | Breads, crackers, pasta, and cereal |
| 6 | Meat/Poultry | Prepared meats |
| 7 | Produce | Dried fruit and bean curd |
| 8 | Seafood | Seaweed and fish |

---

## customer_customer_demo

**Row count:** 0

**Primary key:** `customer_id, customer_type_id`

**Foreign keys:**
- `customer_type_id` -> `customer_demographics.customer_type_id`
- `customer_id` -> `customers.customer_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `customer_id` | character varying(5) | NO | - |
| `customer_type_id` | character varying(5) | NO | - |

### Sample Data

*No rows.*

---

## customer_demographics

**Row count:** 0

**Primary key:** `customer_type_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `customer_type_id` | character varying(5) | NO | - |
| `customer_desc` | text | YES | - |

### Sample Data

*No rows.*

---

## customers

**Row count:** 91

**Primary key:** `customer_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `customer_id` | character varying(5) | NO | - |
| `company_name` | character varying(40) | NO | - |
| `contact_name` | character varying(30) | YES | - |
| `contact_title` | character varying(30) | YES | - |
| `address` | character varying(60) | YES | - |
| `city` | character varying(15) | YES | - |
| `region` | character varying(15) | YES | - |
| `postal_code` | character varying(10) | YES | - |
| `country` | character varying(15) | YES | - |
| `phone` | character varying(24) | YES | - |
| `fax` | character varying(24) | YES | - |

### Sample Data

*First 5 of 91 rows:*

| `customer_id` | `company_name` | `contact_name` | `contact_title` | `address` | `city` | `region` | `postal_code` | `country` | `phone` | `fax` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ALFKI | Alfreds Futterkiste | Maria Anders | Sales Representative | Obere Str. 57 | Berlin | - | 12209 | Germany | 030-0074321 | 030-0076545 |
| ANATR | Ana Trujillo Emparedados y helados | Ana Trujillo | Owner | Avda. de la Constitución 2222 | México D.F. | - | 05021 | Mexico | (5) 555-4729 | (5) 555-3745 |
| ANTON | Antonio Moreno Taquería | Antonio Moreno | Owner | Mataderos 2312 | México D.F. | - | 05023 | Mexico | (5) 555-3932 | - |
| AROUT | Around the Horn | Thomas Hardy | Sales Representative | 120 Hanover Sq. | London | - | WA1 1DP | UK | (171) 555-7788 | (171) 555-6750 |
| BERGS | Berglunds snabbköp | Christina Berglund | Order Administrator | Berguvsvägen 8 | Luleå | - | S-958 22 | Sweden | 0921-12 34 65 | 0921-12 34 67 |

---

## employee_territories

**Row count:** 49

**Primary key:** `employee_id, territory_id`

**Foreign keys:**
- `territory_id` -> `territories.territory_id`
- `employee_id` -> `employees.employee_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `employee_id` | smallint | NO | - |
| `territory_id` | character varying(20) | NO | - |

### Sample Data

*First 5 of 49 rows:*

| `employee_id` | `territory_id` |
| --- | --- |
| 1 | 06897 |
| 1 | 19713 |
| 2 | 01581 |
| 2 | 01730 |
| 2 | 01833 |

---

## employees

**Row count:** 9

**Primary key:** `employee_id`

**Foreign keys:**
- `reports_to` -> `employees.employee_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `employee_id` | smallint | NO | - |
| `last_name` | character varying(20) | NO | - |
| `first_name` | character varying(10) | NO | - |
| `title` | character varying(30) | YES | - |
| `title_of_courtesy` | character varying(25) | YES | - |
| `birth_date` | date | YES | - |
| `hire_date` | date | YES | - |
| `address` | character varying(60) | YES | - |
| `city` | character varying(15) | YES | - |
| `region` | character varying(15) | YES | - |
| `postal_code` | character varying(10) | YES | - |
| `country` | character varying(15) | YES | - |
| `home_phone` | character varying(24) | YES | - |
| `extension` | character varying(4) | YES | - |
| `photo` | bytea | YES | - |
| `notes` | text | YES | - |
| `reports_to` | smallint | YES | - |
| `photo_path` | character varying(255) | YES | - |

### Sample Data

*All 9 rows:*
*Sample omits binary column(s): `photo`.*


| `employee_id` | `last_name` | `first_name` | `title` | `title_of_courtesy` | `birth_date` | `hire_date` | `address` | `city` | `region` | `postal_code` | `country` | `home_phone` | `extension` | `notes` | `reports_to` | `photo_path` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Davolio | Nancy | Sales Representative | Ms. | 1948-12-08 | 1992-05-01 | 507 - 20th Ave. E. Apt. 2A | Seattle | WA | 98122 | USA | (206) 555-9857 | 5467 | Education includes a BA in psychology from Colorad... | 2 | http://accweb/emmployees/davolio.bmp |
| 2 | Fuller | Andrew | Vice President, Sales | Dr. | 1952-02-19 | 1992-08-14 | 908 W. Capital Way | Tacoma | WA | 98401 | USA | (206) 555-9482 | 3457 | Andrew received his BTS commercial in 1974 and a P... | - | http://accweb/emmployees/fuller.bmp |
| 3 | Leverling | Janet | Sales Representative | Ms. | 1963-08-30 | 1992-04-01 | 722 Moss Bay Blvd. | Kirkland | WA | 98033 | USA | (206) 555-3412 | 3355 | Janet has a BS degree in chemistry from Boston Col... | 2 | http://accweb/emmployees/leverling.bmp |
| 4 | Peacock | Margaret | Sales Representative | Mrs. | 1937-09-19 | 1993-05-03 | 4110 Old Redmond Rd. | Redmond | WA | 98052 | USA | (206) 555-8122 | 5176 | Margaret holds a BA in English literature from Con... | 2 | http://accweb/emmployees/peacock.bmp |
| 5 | Buchanan | Steven | Sales Manager | Mr. | 1955-03-04 | 1993-10-17 | 14 Garrett Hill | London | - | SW1 8JR | UK | (71) 555-4848 | 3453 | Steven Buchanan graduated from St. Andrews Univers... | 2 | http://accweb/emmployees/buchanan.bmp |
| 6 | Suyama | Michael | Sales Representative | Mr. | 1963-07-02 | 1993-10-17 | Coventry House Miner Rd. | London | - | EC2 7JR | UK | (71) 555-7773 | 428 | Michael is a graduate of Sussex University (MA, ec... | 5 | http://accweb/emmployees/davolio.bmp |
| 7 | King | Robert | Sales Representative | Mr. | 1960-05-29 | 1994-01-02 | Edgeham Hollow Winchester Way | London | - | RG1 9SP | UK | (71) 555-5598 | 465 | Robert King served in the Peace Corps and traveled... | 5 | http://accweb/emmployees/davolio.bmp |
| 8 | Callahan | Laura | Inside Sales Coordinator | Ms. | 1958-01-09 | 1994-03-05 | 4726 - 11th Ave. N.E. | Seattle | WA | 98105 | USA | (206) 555-1189 | 2344 | Laura received a BA in psychology from the Univers... | 2 | http://accweb/emmployees/davolio.bmp |
| 9 | Dodsworth | Anne | Sales Representative | Ms. | 1966-01-27 | 1994-11-15 | 7 Houndstooth Rd. | London | - | WG2 7LT | UK | (71) 555-4444 | 452 | Anne has a BA degree in English from St. Lawrence ... | 5 | http://accweb/emmployees/davolio.bmp |

---

## order_details

**Row count:** 2,155

**Primary key:** `order_id, product_id`

**Foreign keys:**
- `product_id` -> `products.product_id`
- `order_id` -> `orders.order_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `order_id` | smallint | NO | - |
| `product_id` | smallint | NO | - |
| `unit_price` | real | NO | - |
| `quantity` | smallint | NO | - |
| `discount` | real | NO | - |

### Sample Data

*First 5 of 2,155 rows:*

| `order_id` | `product_id` | `unit_price` | `quantity` | `discount` |
| --- | --- | --- | --- | --- |
| 10248 | 11 | 14 | 12 | 0 |
| 10248 | 42 | 9.8 | 10 | 0 |
| 10248 | 72 | 34.8 | 5 | 0 |
| 10249 | 14 | 18.6 | 9 | 0 |
| 10249 | 51 | 42.4 | 40 | 0 |

---

## orders

**Row count:** 830

**Primary key:** `order_id`

**Foreign keys:**
- `customer_id` -> `customers.customer_id`
- `employee_id` -> `employees.employee_id`
- `ship_via` -> `shippers.shipper_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `order_id` | smallint | NO | - |
| `customer_id` | character varying(5) | YES | - |
| `employee_id` | smallint | YES | - |
| `order_date` | date | YES | - |
| `required_date` | date | YES | - |
| `shipped_date` | date | YES | - |
| `ship_via` | smallint | YES | - |
| `freight` | real | YES | - |
| `ship_name` | character varying(40) | YES | - |
| `ship_address` | character varying(60) | YES | - |
| `ship_city` | character varying(15) | YES | - |
| `ship_region` | character varying(15) | YES | - |
| `ship_postal_code` | character varying(10) | YES | - |
| `ship_country` | character varying(15) | YES | - |

### Sample Data

*First 5 of 830 rows:*

| `order_id` | `customer_id` | `employee_id` | `order_date` | `required_date` | `shipped_date` | `ship_via` | `freight` | `ship_name` | `ship_address` | `ship_city` | `ship_region` | `ship_postal_code` | `ship_country` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 10248 | VINET | 5 | 1996-07-04 | 1996-08-01 | 1996-07-16 | 3 | 32.38 | Vins et alcools Chevalier | 59 rue de l'Abbaye | Reims | - | 51100 | France |
| 10249 | TOMSP | 6 | 1996-07-05 | 1996-08-16 | 1996-07-10 | 1 | 11.61 | Toms Spezialitäten | Luisenstr. 48 | Münster | - | 44087 | Germany |
| 10250 | HANAR | 4 | 1996-07-08 | 1996-08-05 | 1996-07-12 | 2 | 65.83 | Hanari Carnes | Rua do Paço, 67 | Rio de Janeiro | RJ | 05454-876 | Brazil |
| 10251 | VICTE | 3 | 1996-07-08 | 1996-08-05 | 1996-07-15 | 1 | 41.34 | Victuailles en stock | 2, rue du Commerce | Lyon | - | 69004 | France |
| 10252 | SUPRD | 4 | 1996-07-09 | 1996-08-06 | 1996-07-11 | 2 | 51.3 | Suprêmes délices | Boulevard Tirou, 255 | Charleroi | - | B-6000 | Belgium |

---

## products

**Row count:** 77

**Primary key:** `product_id`

**Foreign keys:**
- `category_id` -> `categories.category_id`
- `supplier_id` -> `suppliers.supplier_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `product_id` | smallint | NO | - |
| `product_name` | character varying(40) | NO | - |
| `supplier_id` | smallint | YES | - |
| `category_id` | smallint | YES | - |
| `quantity_per_unit` | character varying(20) | YES | - |
| `unit_price` | real | YES | - |
| `units_in_stock` | smallint | YES | - |
| `units_on_order` | smallint | YES | - |
| `reorder_level` | smallint | YES | - |
| `discontinued` | integer | NO | - |

### Sample Data

*First 5 of 77 rows:*

| `product_id` | `product_name` | `supplier_id` | `category_id` | `quantity_per_unit` | `unit_price` | `units_in_stock` | `units_on_order` | `reorder_level` | `discontinued` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Chai | 8 | 1 | 10 boxes x 30 bags | 18 | 39 | 0 | 10 | 1 |
| 2 | Chang | 1 | 1 | 24 - 12 oz bottles | 19 | 17 | 40 | 25 | 1 |
| 3 | Aniseed Syrup | 1 | 2 | 12 - 550 ml bottles | 10 | 13 | 70 | 25 | 0 |
| 4 | Chef Anton's Cajun Seasoning | 2 | 2 | 48 - 6 oz jars | 22 | 53 | 0 | 0 | 0 |
| 5 | Chef Anton's Gumbo Mix | 2 | 2 | 36 boxes | 21.35 | 0 | 0 | 0 | 1 |

---

## region

**Row count:** 4

**Primary key:** `region_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `region_id` | smallint | NO | - |
| `region_description` | character varying(60) | NO | - |

### Sample Data

*All 4 rows:*

| `region_id` | `region_description` |
| --- | --- |
| 1 | Eastern |
| 2 | Western |
| 3 | Northern |
| 4 | Southern |

---

## shippers

**Row count:** 6

**Primary key:** `shipper_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `shipper_id` | smallint | NO | - |
| `company_name` | character varying(40) | NO | - |
| `phone` | character varying(24) | YES | - |

### Sample Data

*All 6 rows:*

| `shipper_id` | `company_name` | `phone` |
| --- | --- | --- |
| 1 | Speedy Express | (503) 555-9831 |
| 2 | United Package | (503) 555-3199 |
| 3 | Federal Shipping | (503) 555-9931 |
| 4 | Alliance Shippers | 1-800-222-0451 |
| 5 | UPS | 1-800-782-7892 |
| 6 | DHL | 1-800-225-5345 |

---

## suppliers

**Row count:** 29

**Primary key:** `supplier_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `supplier_id` | smallint | NO | - |
| `company_name` | character varying(40) | NO | - |
| `contact_name` | character varying(30) | YES | - |
| `contact_title` | character varying(30) | YES | - |
| `address` | character varying(60) | YES | - |
| `city` | character varying(15) | YES | - |
| `region` | character varying(15) | YES | - |
| `postal_code` | character varying(10) | YES | - |
| `country` | character varying(15) | YES | - |
| `phone` | character varying(24) | YES | - |
| `fax` | character varying(24) | YES | - |
| `homepage` | text | YES | - |

### Sample Data

*First 5 of 29 rows:*

| `supplier_id` | `company_name` | `contact_name` | `contact_title` | `address` | `city` | `region` | `postal_code` | `country` | `phone` | `fax` | `homepage` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Exotic Liquids | Charlotte Cooper | Purchasing Manager | 49 Gilbert St. | London | - | EC1 4SD | UK | (171) 555-2222 | - | - |
| 2 | New Orleans Cajun Delights | Shelley Burke | Order Administrator | P.O. Box 78934 | New Orleans | LA | 70117 | USA | (100) 555-4822 | - | #CAJUN.HTM# |
| 3 | Grandma Kelly's Homestead | Regina Murphy | Sales Representative | 707 Oxford Rd. | Ann Arbor | MI | 48104 | USA | (313) 555-5735 | (313) 555-3349 | - |
| 4 | Tokyo Traders | Yoshi Nagase | Marketing Manager | 9-8 Sekimai Musashino-shi | Tokyo | - | 100 | Japan | (03) 3555-5011 | - | - |
| 5 | Cooperativa de Quesos 'Las Cabras' | Antonio del Valle Saavedra | Export Administrator | Calle del Rosal 4 | Oviedo | Asturias | 33007 | Spain | (98) 598 76 54 | - | - |

---

## territories

**Row count:** 53

**Primary key:** `territory_id`

**Foreign keys:**
- `region_id` -> `region.region_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `territory_id` | character varying(20) | NO | - |
| `territory_description` | character varying(60) | NO | - |
| `region_id` | smallint | NO | - |

### Sample Data

*First 5 of 53 rows:*

| `territory_id` | `territory_description` | `region_id` |
| --- | --- | --- |
| 01581 | Westboro | 1 |
| 01730 | Bedford | 1 |
| 01833 | Georgetow | 1 |
| 02116 | Boston | 1 |
| 02139 | Cambridge | 1 |

---

## us_states

**Row count:** 51

**Primary key:** `state_id`

### Columns

| Column | Type | Nullable | Default |
|--------|------|:--------:|---------|
| `state_id` | smallint | NO | - |
| `state_name` | character varying(100) | YES | - |
| `state_abbr` | character varying(2) | YES | - |
| `state_region` | character varying(50) | YES | - |

### Sample Data

*First 5 of 51 rows:*

| `state_id` | `state_name` | `state_abbr` | `state_region` |
| --- | --- | --- | --- |
| 1 | Alabama | AL | south |
| 2 | Alaska | AK | north |
| 3 | Arizona | AZ | west |
| 4 | Arkansas | AR | south |
| 5 | California | CA | west |

---
