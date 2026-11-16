USE MusicRetailPortfolio;
GO
SET XACT_ABORT ON;
BEGIN TRANSACTION;
-- Entirely synthetic public demo fixture; not the instructor's dataset.
DECLARE @n int=1;
WHILE @n<=40 BEGIN
 INSERT dbo.customers VALUES(@n,CONCAT('Customer',@n),CONCAT('Demo',RIGHT('00'+CAST(@n AS varchar(2)),2)),CONCAT(@n,' Example Lane'),
 CASE @n%5 WHEN 0 THEN 'Fresno' WHEN 1 THEN 'New York' WHEN 2 THEN 'Newark' WHEN 3 THEN 'Charlotte' ELSE 'Washington' END,
 CASE @n%5 WHEN 0 THEN 'CA' WHEN 1 THEN 'NY' WHEN 2 THEN 'NJ' WHEN 3 THEN 'NC' ELSE 'DC' END,
 CASE WHEN @n%5=0 THEN '93711' ELSE '10001' END,
 CONCAT('20255501',RIGHT('00'+CAST(@n AS varchar(2)),2)),
 CASE WHEN @n%4=0 THEN '2025550199' ELSE NULL END);
 SET @n+=1;
END;
SET @n=10;
WHILE @n<=21 BEGIN INSERT dbo.artists VALUES(@n,CONCAT('Studio Ensemble ',@n)); SET @n+=1; END;
SET @n=1;
WHILE @n<=20 BEGIN
 INSERT dbo.items VALUES(@n,CONCAT('Album ',RIGHT('00'+CAST(@n AS varchar(2)),2)),10+(@n%12),10+(@n%10));
 SET @n+=1;
END;
INSERT dbo.employees VALUES(1,'Reed','Alex',NULL),(2,'Lin','Jordan',1),(3,'Bell','Casey',1),(4,'Lake','Morgan',2);
SET @n=1;
WHILE @n<=52 BEGIN
 INSERT dbo.orders VALUES(@n,1+(@n%24),DATEADD(day,@n*3,'20140101'),
 CASE WHEN @n%13=0 THEN NULL ELSE DATEADD(day,@n*3+CASE WHEN @n%5=0 THEN 20 ELSE 4 END,'20140101') END,
 CASE WHEN @n%4=0 THEN NULL ELSE 1+(@n%4) END);
 INSERT dbo.order_details VALUES(@n,1+(@n%20),1+(@n%3));
 SET @n+=1;
END;
-- Boundary records let date-range behavior be checked explicitly.
INSERT dbo.orders VALUES(101,1,'20140201','20140205',1),(102,1,'20140530','20140603',1),
 (103,1,'20140531','20140604',1),(104,1,'20140601',NULL,1);
INSERT dbo.order_details VALUES(101,1,1),(102,2,2),(103,3,1),(104,4,2);
COMMIT;
GO
