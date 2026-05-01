# SQL Database Project — Microsoft SQL Server (SSMS)

**Course:** CIS 3050 — Database Management  
**Institution:** Cal Poly Pomona  
**Term:** Spring 2026  

## Overview

This project involves designing and querying a relational database using **Microsoft SQL Server Management Studio (SSMS)**. The database models a music retail business with five related tables connected through primary and foreign keys.

## Database Schema

| Table | Description |
|---|---|
| `customers` | Customer contact and location information |
| `orders` | Order records with dates and shipping status |
| `items` | Music items with pricing |
| `artists` | Artist information linked to items |
| `employees` | Staff records with self-referencing manager relationship |

## What's in This Repo

- **`queries.sql`** — All 30 T-SQL queries with comments explaining each one

## SQL Concepts Covered

The 30 queries cover a broad range of SQL skills:

- **Filtering & Sorting** — `WHERE`, `ORDER BY`, `IN`, `LIKE`, `IS NULL`, `IS NOT NULL`
- **String Functions** — `SUBSTRING`, concatenation, name formatting
- **Date Functions** — `FORMAT`, `DATEDIFF`, `DATENAME`, `BETWEEN`
- **Aggregate Functions** — `COUNT`, `AVG`, `GROUP BY`, `HAVING`
- **Joins** — `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`
- **Subqueries** — Scalar subqueries for average comparison
- **DML** — `INSERT`, `UPDATE`, `DELETE`
- **Views** — Creating a dynamic view for above-average priced items
- **Self-Referencing Relationships** — Manager-subordinate hierarchy in employees table

## Sample Queries

**Filter customers by state using IN:**
```sql
SELECT *
FROM customers
WHERE customer_state IN ('NY', 'NC', 'NJ');
```

**Calculate discount price:**
```sql
SELECT title,
       unit_price AS Original,
       ROUND(unit_price * 0.85, 2) AS Sale
FROM items
ORDER BY unit_price DESC;
```

**Customers with above-average order counts (subquery):**
```sql
SELECT customer_id, COUNT(*) AS Total_Orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > (
    SELECT AVG(OrderCount)
    FROM (
        SELECT COUNT(*) AS OrderCount
        FROM orders
        GROUP BY customer_id
    ) AS AvgTable
)
ORDER BY Total_Orders DESC;
```

## Tools Used

- Microsoft SQL Server Management Studio (SSMS)
- T-SQL (Transact-SQL)
