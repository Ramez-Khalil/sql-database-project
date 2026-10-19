# SQL Database Coursework — 30 T-SQL Queries

**Cal Poly Pomona · CIS 3050 Database Management · Spring 2026**

This academic exercise demonstrates Microsoft SQL Server **T-SQL query construction** against a described music-retail schema. The principal inspectable artifact is **[queries.sql](queries.sql)**, which contains 30 commented SQL statements.

## What you can review

The SQL refers to five related tables: `customers`, `orders`, `items`, `artists`, and `employees`. Comments explain the purpose of each statement.

| Area | Examples in the query file |
| --- | --- |
| Retrieval | `SELECT`, `WHERE`, `ORDER BY`, `DISTINCT`, `IN`, `LIKE`, `IS NULL` |
| Reporting | `COUNT`, `AVG`, `GROUP BY`, `HAVING`, joins and subqueries |
| Data presentation | string/date functions and calculated prices |
| Data manipulation | sample `INSERT`, `UPDATE`, `DELETE` statements |
| Database objects | a `CREATE VIEW` statement |

**[Read the actual SQL source →](queries.sql)**

## Evidence and reproducibility

- **Included:** 30 commented T-SQL statements that can be inspected directly; an illustrative, fictional record in the sample insert.
- **Not included:** SQL Server schema-creation scripts, a database backup, source tables, ER diagram, query outputs, or a recorded execution/test log.
- **Consequently:** the queries cannot be run as an end-to-end database from this repository alone. Their published presence does not establish successful execution on a particular SQL Server version or database scale.
- **Safety when practicing:** the file includes data-changing `INSERT`, `UPDATE`, and `DELETE` statements. Review them and use only a disposable test database you control; do not run them against real data.

This repository is **coursework evidence**, not a production system, performance benchmark, or independently validated deployment.

## Related portfolio

For a **separate** small illustrative schema with fictitious inserts and reporting queries, see [Business SQL Analysis](https://github.com/Ramez-Khalil/business-sql-analysis). It is not the same music-retail database. For broader hands-on infrastructure work, see the [IT Infrastructure & Security HomeLab](https://github.com/Ramez-Khalil/enterprise-it-cybersecurity-homelab).
