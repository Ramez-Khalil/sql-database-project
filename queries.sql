-- ============================================================
-- MS SQL Server Database Project
-- Course: CIS 3050 - Database Management
-- Cal Poly Pomona | Spring 2026
-- Author: Ramez Khalil
-- ============================================================
-- Database tables: customers, orders, items, artists, employees
-- All queries written in T-SQL (Microsoft SQL Server syntax)
-- ============================================================


-- ============================================================
-- QUERY 1
-- Display all customers: last name, city, phone number.
-- Sort by state, then last name.
-- ============================================================
SELECT customer_last_name, customer_city, customer_phone
FROM customers
ORDER BY customer_state, customer_last_name;


-- ============================================================
-- QUERY 2
-- Display all customers: first name, state, phone number.
-- Sort by state, then last name.
-- ============================================================
SELECT customer_first_name, customer_state, customer_phone
FROM customers
ORDER BY customer_state, customer_last_name;


-- ============================================================
-- QUERY 3
-- Display all customers: first name, last name, city, phone, fax.
-- Sort by fax number ascending.
-- ============================================================
SELECT customer_first_name, customer_last_name, customer_city, customer_phone, customer_fax
FROM customers
ORDER BY customer_fax;


-- ============================================================
-- QUERY 4
-- Retrieve all customers from New York, North Carolina, or New Jersey.
-- ============================================================
SELECT *
FROM customers
WHERE customer_state IN ('NY', 'NC', 'NJ');


-- ============================================================
-- QUERY 5
-- Retrieve all customers from California who live in Fresno.
-- ============================================================
SELECT *
FROM customers
WHERE customer_state = 'CA'
  AND customer_city = 'Fresno';


-- ============================================================
-- QUERY 6
-- Display full name as 'Customer' and phone as 'Phone'
-- for customers from NY, NJ, or DC. Sort by phone number.
-- ============================================================
SELECT
    customer_first_name + ' ' + customer_last_name AS Customer,
    customer_phone AS Phone
FROM customers
WHERE customer_state IN ('NY', 'NJ', 'DC')
ORDER BY customer_phone;


-- ============================================================
-- QUERY 7
-- Display all unique cities where customers are located.
-- Label column 'Cities'. Sort descending alphabetically.
-- ============================================================
SELECT DISTINCT customer_city AS Cities
FROM customers
ORDER BY customer_city DESC;


-- ============================================================
-- QUERY 8
-- Display item title, original price ('Original'), and
-- price with 15% discount ('Sale') rounded to 2 decimal places.
-- Sort by price highest to lowest.
-- ============================================================
SELECT
    title,
    unit_price AS Original,
    ROUND(unit_price * 0.85, 2) AS Sale
FROM items
ORDER BY unit_price DESC;


-- ============================================================
-- QUERY 9
-- Display city, first name, last name, and zip for customers
-- whose zip code begins with 9. Uses LIKE operator.
-- ============================================================
SELECT customer_city, customer_first_name, customer_last_name, customer_zip
FROM customers
WHERE customer_zip LIKE '9%';


-- ============================================================
-- QUERY 10
-- Display order ID and order date (formatted 'Month dd, yyyy')
-- for orders placed between Feb 1, 2014 and May 30, 2014.
-- Does NOT use BETWEEN. Column heading: 'Ordered'.
-- ============================================================
SELECT
    order_id,
    FORMAT(order_date, 'MMMM dd, yyyy') AS Ordered
FROM orders
WHERE order_date >= '2014-02-01'
  AND order_date <= '2014-05-30';


-- ============================================================
-- QUERY 11
-- Display order ID and order date (formatted 'mm/dd/yy')
-- for orders placed during May 2014. Uses BETWEEN.
-- Column heading: 'Ordered'.
-- ============================================================
SELECT
    order_id,
    FORMAT(order_date, 'MM/dd/yy') AS Ordered
FROM orders
WHERE order_date BETWEEN '2014-05-01' AND '2014-05-31';


-- ============================================================
-- QUERY 12
-- Display order ID, customer ID, and days between order date
-- and ship date (DATEDIFF). Column: 'Days'.
-- Only show orders where Days >= 15. Sort descending.
-- ============================================================
SELECT
    order_id,
    customer_id,
    DATEDIFF(DAY, order_date, shipped_date) AS Days
FROM orders
WHERE DATEDIFF(DAY, order_date, shipped_date) >= 15
ORDER BY Days DESC;


-- ============================================================
-- QUERY 13
-- Display order ID, customer ID, employee ID, and order date
-- for all unshipped orders (shipped_date IS NULL).
-- Sort by order date descending (most recent first).
-- ============================================================
SELECT order_id, customer_id, employee_id, order_date
FROM orders
WHERE shipped_date IS NULL
ORDER BY order_date DESC;


-- ============================================================
-- QUERY 14
-- Shipped orders placed on Saturday or Sunday.
-- Display order ID, order date, shipped date, and day of week
-- using DATENAME. Sort by most recent order date.
-- ============================================================
SELECT
    order_id,
    order_date,
    shipped_date,
    DATENAME(WEEKDAY, order_date) AS Order_Day
FROM orders
WHERE shipped_date IS NOT NULL
  AND DATENAME(WEEKDAY, order_date) IN ('Saturday', 'Sunday')
ORDER BY order_date DESC;


-- ============================================================
-- QUERY 15
-- Display last name, phone, and fax for customers
-- who have a fax number (fax IS NOT NULL).
-- ============================================================
SELECT customer_last_name, customer_phone, customer_fax
FROM customers
WHERE customer_fax IS NOT NULL;


-- ============================================================
-- QUERY 16
-- Retrieve the total number of orders.
-- ============================================================
SELECT COUNT(*) AS Total_Orders
FROM orders;


-- ============================================================
-- QUERY 17
-- Display item ID, title, artist name, and price
-- using a JOIN between items and artists tables.
-- ============================================================
SELECT items.item_id, items.title, artists.artist_name, items.unit_price
FROM items
JOIN artists ON items.artist_id = artists.artist_id;


-- ============================================================
-- QUERY 18
-- LEFT JOIN: All customers with their orders (if any).
-- Sort by customer_id, order_id, employee_id.
-- RIGHT JOIN: All orders with customer info (even if no customer match).
-- ============================================================

-- LEFT JOIN
SELECT
    customers.customer_id,
    customers.customer_first_name + ' ' + customers.customer_last_name AS Customer_Name,
    orders.order_id,
    orders.employee_id
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
ORDER BY customers.customer_id, orders.order_id, orders.employee_id;

-- RIGHT JOIN
SELECT
    customers.customer_id,
    customers.customer_first_name + ' ' + customers.customer_last_name AS Customer_Name,
    orders.order_id,
    orders.order_date
FROM customers
RIGHT JOIN orders ON customers.customer_id = orders.customer_id;


-- ============================================================
-- QUERY 19
-- Display name and address of the customer who placed order #45.
-- ============================================================
SELECT
    customers.customer_first_name + ' ' + customers.customer_last_name AS Customer_Name,
    customers.customer_address
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.order_id = 45;


-- ============================================================
-- QUERY 20
-- Retrieve all details for the item with the highest price.
-- ============================================================
SELECT TOP 1 *
FROM items
ORDER BY unit_price DESC;


-- ============================================================
-- QUERY 21
-- INSERT a new item record, then verify with SELECT.
-- item_id: 21, title: 'Eugenio Gattinara', artist_id: 17, unit_price: 25.99
-- ============================================================
INSERT INTO items (item_id, title, artist_id, unit_price)
VALUES (21, 'Eugenio Gattinara', 17, 25.99);

SELECT * FROM items WHERE item_id > 19;


-- ============================================================
-- QUERY 22
-- UPDATE the previously inserted item's price to 19.77.
-- Verify with SELECT.
-- ============================================================
UPDATE items
SET unit_price = 19.77
WHERE item_id = 21;

SELECT * FROM items WHERE item_id > 19;


-- ============================================================
-- QUERY 23
-- DELETE the previously inserted/updated item.
-- Verify removal with SELECT.
-- ============================================================
DELETE FROM items
WHERE item_id = 21;

SELECT * FROM items WHERE item_id > 9;


-- ============================================================
-- QUERY 24
-- Format customer names as 'LastName, FirstName' and phone
-- as '(XXX) XXX-XXXX' using SUBSTRING and CONCAT.
-- Sort by first name.
-- ============================================================
SELECT
    customer_last_name + ', ' + customer_first_name AS Customer,
    '(' + SUBSTRING(customer_phone, 1, 3) + ') ' +
    SUBSTRING(customer_phone, 4, 3) + '-' +
    SUBSTRING(customer_phone, 7, 4) AS Phone
FROM customers
ORDER BY customer_first_name;


-- ============================================================
-- QUERY 25
-- INSERT a new customer record with personal details.
-- Address: 3801 W Temple Ave, Pomona, CA 91768
-- ============================================================
INSERT INTO customers
    (customer_id, customer_first_name, customer_last_name, customer_address,
     customer_city, customer_state, customer_zip, customer_phone, customer_fax)
VALUES
    (41, 'Alex', 'Morgan', '100 Example Ave', 'Sample City', 'CA', '90000', '5550100100', NULL);


-- ============================================================
-- QUERY 26
-- CREATE a VIEW that returns all items priced above average.
-- View updates dynamically as new items are added.
-- ============================================================
CREATE VIEW vw_AboveAverageItems AS
SELECT title, unit_price
FROM items
WHERE unit_price > (SELECT AVG(unit_price) FROM items);

-- To query the view:
-- SELECT * FROM vw_AboveAverageItems;


-- ============================================================
-- QUERY 27
-- Conceptual: Cardinality in a self-referencing employees table.
--
-- In a self-referencing relationship on the employees table,
-- one employee (manager) can supervise many employees (subordinates),
-- forming a one-to-many (1:N) hierarchical structure.
--
-- Example schema:
-- employees (employee_id PK, employee_name, manager_id FK -> employee_id)
--
-- Query to show each employee and their manager:
-- ============================================================
SELECT
    e.employee_id,
    e.employee_first_name + ' ' + e.employee_last_name AS Employee,
    m.employee_first_name + ' ' + m.employee_last_name AS Manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;


-- ============================================================
-- QUERY 28
-- INSERT a new artist record.
-- ============================================================
INSERT INTO artists (artist_id, artist_name)
VALUES (22, 'Ramez Khalil');


-- ============================================================
-- QUERY 29
-- Display each state and total number of customers in that state.
-- Label count column 'Total_Customers'. Sort descending.
-- ============================================================
SELECT
    customer_state,
    COUNT(*) AS Total_Customers
FROM customers
GROUP BY customer_state
ORDER BY Total_Customers DESC;


-- ============================================================
-- QUERY 30
-- Subquery: Display customers whose total orders exceed
-- the average number of orders per customer.
-- Sort by total orders descending.
-- ============================================================
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
