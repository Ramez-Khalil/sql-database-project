# Music Retail SQL Analytics

A reproducible Microsoft SQL Server project that explores customer activity, music catalogs, order fulfillment and employee reporting relationships.

**30 query exercises · 6 relational tables · 14 validation assertions**

## Explore the project

- [Queries](queries.sql): filtering, dates, joins, aggregates, a dynamic view and reversible data changes.
- [Schema](sql/00-schema.sql) and [synthetic dataset](sql/01-seed.sql): a complete local demonstration.
- [Database design](docs/database-design.md): relationships and design decisions.
- [Validation](sql/03-validate.sql) and [execution evidence](evidence/validation.txt).
- [Query results](evidence/queries.txt): actual SQL Server output from the demonstration dataset.

## What it answers

Which customers order more often than the average customer? Which orders are still awaiting shipment? Which music titles are priced above the current catalog average? Who reports to each manager?

The project covers all 30 exercises from an earlier database course, expanded into a runnable portfolio implementation. The public fixture is entirely synthetic and is not the original course dataset.

## Run locally

Requires Microsoft SQL Server and SSMS or sqlcmd. Run these files in order:

1. `sql/00-schema.sql`
2. `sql/01-seed.sql`
3. `queries.sql`
4. `sql/03-validate.sql`

The setup creates a new database named `MusicRetailPortfolio` and refuses to overwrite an existing database. It does not modify other databases. The query suite's insert/update/delete demonstrations roll back their changes; its view remains available. The query and validation scripts can be rerun after setup.

## Verified results

Executed on SQL Server 2025, version **17.0.1000.7**, on November 16, 2026.

- 6 related tables
- 40 fictional customers, 56 orders and 56 order-detail rows
- 20 catalog items, 12 artists and 4 employees
- All 30 query exercises executed without SQL errors
- 14 automated assertions passed
- Mean orders per customer: **1.4000**, including 16 customers with no orders

The text logs record execution against the synthetic demonstration dataset.

## Implementation highlights

- Foreign keys preserve relationships; positive quantities, nonnegative prices and shipment dates are checked.
- Customers with no orders are included when computing the average.
- Decimal arithmetic avoids integer truncation in that average.
- Highest-price ties are retained.
- The employee self-join uses the actual schema's `first_name` and `last_name`.
- The above-average-price view is in its own SQL batch and updates dynamically.
- Personal contact information is replaced with fictional example records.

## Background

Developed from Ramez Khalil's CIS 3050 SQL coursework and rebuilt as a standalone portfolio demonstration. Course instructions and the original submitted report are not redistributed here.

[Project notes](docs/project-notes.md) explain the public fixture, query assumptions and validation scope.
