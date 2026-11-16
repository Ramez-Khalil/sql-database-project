USE master;
GO
IF DB_ID(N'MusicRetailPortfolio') IS NOT NULL
 THROW 51000, 'Database already exists; setup will not overwrite it.', 1;
GO
CREATE DATABASE MusicRetailPortfolio;
GO
USE MusicRetailPortfolio;
GO
SET XACT_ABORT ON;
BEGIN TRANSACTION;
CREATE TABLE dbo.customers (
 customer_id int CONSTRAINT PK_customers PRIMARY KEY,
 customer_first_name varchar(20), customer_last_name varchar(20) NOT NULL,
 customer_address varchar(50) NOT NULL, customer_city varchar(20) NOT NULL,
 customer_state char(2) NOT NULL, customer_zip char(5) NOT NULL,
 customer_phone char(10) NOT NULL, customer_fax char(10)
);
CREATE TABLE dbo.artists (artist_id int CONSTRAINT PK_artists PRIMARY KEY,artist_name varchar(30));
CREATE TABLE dbo.items (
 item_id int CONSTRAINT PK_items PRIMARY KEY,title varchar(50) NOT NULL,
 artist_id int NOT NULL REFERENCES dbo.artists(artist_id),unit_price decimal(9,2) NOT NULL CHECK(unit_price>=0)
);
CREATE TABLE dbo.employees (
 employee_id int CONSTRAINT PK_employees PRIMARY KEY,last_name varchar(20) NOT NULL,
 first_name varchar(20) NOT NULL,manager_id int NULL REFERENCES dbo.employees(employee_id),
 CHECK(manager_id IS NULL OR manager_id<>employee_id)
);
CREATE TABLE dbo.orders (
 order_id int CONSTRAINT PK_orders PRIMARY KEY,
 customer_id int NOT NULL REFERENCES dbo.customers(customer_id),
 order_date date NOT NULL,shipped_date date,employee_id int NULL REFERENCES dbo.employees(employee_id),
 CHECK(shipped_date IS NULL OR shipped_date>=order_date)
);
CREATE TABLE dbo.order_details (
 order_id int NOT NULL REFERENCES dbo.orders(order_id),
 item_id int NOT NULL REFERENCES dbo.items(item_id),order_qty int NOT NULL CHECK(order_qty>0),
 CONSTRAINT PK_order_details PRIMARY KEY(order_id,item_id)
);
COMMIT;
GO
