USE MusicRetailPortfolio;
GO
SET NOCOUNT ON;
SET XACT_ABORT ON;
IF (SELECT COUNT(*) FROM sys.tables WHERE schema_id=SCHEMA_ID('dbo'))<>6 THROW 51001,'Table count',1;
IF (SELECT COUNT(*) FROM dbo.customers)<>40 THROW 51002,'Customer count',1;
IF (SELECT COUNT(*) FROM dbo.orders)<>56 THROW 51003,'Order count',1;
IF (SELECT COUNT(*) FROM dbo.order_details)<>56 THROW 51004,'Line count',1;
IF EXISTS(SELECT 1 FROM dbo.items WHERE item_id=21) THROW 51005,'DML rollback item',1;
IF EXISTS(SELECT 1 FROM dbo.customers WHERE customer_id=41) THROW 51006,'DML rollback customer',1;
IF EXISTS(SELECT 1 FROM dbo.artists WHERE artist_id=22) THROW 51007,'DML rollback artist',1;
IF EXISTS(SELECT 1 FROM dbo.vw_AboveAverageItems WHERE unit_price<=(SELECT AVG(unit_price) FROM dbo.items)) THROW 51008,'View predicate',1;
IF (SELECT COUNT(*) FROM dbo.items WHERE unit_price=(SELECT MAX(unit_price) FROM dbo.items))<>2 THROW 51009,'Maximum tie fixture',1;
IF (SELECT COUNT(*) FROM dbo.customers c WHERE NOT EXISTS(SELECT 1 FROM dbo.orders o WHERE o.customer_id=c.customer_id))<>16 THROW 51010,'Zero order fixture',1;
IF NOT EXISTS(SELECT 1 FROM dbo.orders WHERE order_id=102 AND order_date>='20140201' AND order_date<'20140531') THROW 51011,'Inclusive end date',1;
IF EXISTS(SELECT 1 FROM dbo.orders WHERE order_id=103 AND order_date>='20140201' AND order_date<'20140531') THROW 51012,'Exclusive next day',1;
IF NOT EXISTS(SELECT 1 FROM dbo.orders WHERE order_id=103 AND order_date BETWEEN '20140501' AND '20140531') THROW 51013,'May last date',1;
BEGIN TRANSACTION;
INSERT dbo.items VALUES(99,'Dynamic view test',10,100);
IF NOT EXISTS(SELECT 1 FROM dbo.vw_AboveAverageItems WHERE title='Dynamic view test') THROW 51014,'Dynamic view',1;
ROLLBACK;
;WITH C AS (SELECT c.customer_id,COUNT(o.order_id) AS n FROM dbo.customers c LEFT JOIN dbo.orders o ON c.customer_id=o.customer_id GROUP BY c.customer_id)
SELECT COUNT(*) AS Customers, SUM(n) AS Orders, CAST(AVG(CAST(n AS decimal(12,4))) AS decimal(12,4)) AS AverageOrdersAllCustomers FROM C;
SELECT 'PASS: 14 validation assertions' AS Validation;
SELECT CAST(SERVERPROPERTY('ProductVersion') AS varchar(30)) AS SQLServerVersion;
GO
