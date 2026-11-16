# Project notes

## Dataset and interpretation

The public dataset is newly generated, entirely synthetic and deliberately includes zero-order customers, missing fax numbers, unshipped orders, price ties and date boundaries. It preserves the six-table model and field names but does not reproduce original course results.

The examples cover Fresno customer filtering, a catalog price update to 19.77, a fictional customer insert with ID41, and an artist insert. Insert, update and delete demonstrations use transactions and roll back their changes.

Dates are SQL DATE values. May's inclusive BETWEEN is appropriate for this type. The broader date range uses an exclusive next-day upper bound. English date names are selected explicitly for deterministic weekend output.

## Query groups

| Exercises | Capability |
|---|---|
| 1–7 | Projection, sorting, location filters, distinct values and readable names |
| 8–15 | Discounts, patterns, date intervals, fulfillment delays and NULL handling |
| 16–20 | Counts, inner/outer joins, customer lookup and price ties |
| 21–25 | Transactional DML, verification and formatted strings |
| 26–30 | Dynamic view, employee hierarchy, artist insert, aggregation and subquery comparison |

The RIGHT JOIN demonstrates query syntax; valid foreign keys mean the supplied fixture does not contain orphan orders.

## Validation scope

The test script checks table and record counts, rollback of three mutation demos, view semantics, maximum-price ties, zero-order customers and date endpoints. It also inserts and rolls back a high-price item to verify that the view responds to changes. All queries were executed; assertions are focused, not a proof of every possible input.

## Learning outcomes

- Use keys and joins to relate business entities without duplicating them.
- Define aggregate populations explicitly, including customers with zero activity.
- Separate data presentation from filtering and mathematical precision.
- Demonstrate data modifications safely with transactions and rollback.

## References

- [Microsoft: SELECT](https://learn.microsoft.com/en-us/sql/t-sql/queries/select-transact-sql)
- [Microsoft: CREATE VIEW](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-view-transact-sql)
- [Microsoft: AVG](https://learn.microsoft.com/en-us/sql/t-sql/functions/avg-transact-sql)
- [Microsoft: Transactions](https://learn.microsoft.com/en-us/sql/t-sql/language-elements/transactions-transact-sql)
