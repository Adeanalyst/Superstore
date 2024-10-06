SELECT *
FROM Superstore


----------CHECKING FOR NULL VALUES----------
SELECT*
FROM Superstore
WHERE Row_ID is NULL OR Order_ID is NULL OR Order_Date is NULL OR Ship_Date is NULL OR Ship_Mode is NULL OR Customer_ID is NULL
      OR Customer_Name is NULL OR Segment is NULL OR Country_Region is NULL OR City is NULL OR State is NULL OR Postal_Code is NULL
	  OR Region is NULL OR Product_ID is NULL OR Category is NULL OR Sub_Category is NULL OR Product_Name is NULL OR Sales is NULL 
	  OR Quantity is NULL OR Discount is NULL OR Profit is NULL 

SELECT*
FROM Superstore
WHERE State = 'Vermont'

UPDATE Superstore
SET Postal_Code = '05401'
WHERE State = 'Vermont' AND City = 'Burlington' AND Postal_Code is NULL

ALTER TABLE Superstore
ALTER Column Postal_Code VARCHAR(11) 

-------Add 00000 (Zeros)--------------
UPDATE Superstore
SET Postal_Code = RIGHT('00000' + Postal_Code, 5)

UPDATE Superstore
SET Profit = 0
WHERE Row_ID =7345 AND Profit is NULL 

SELECT CONVERT(date, Order_Date) AS Order_Date 
FROM Superstore

UPDATE Superstore
SET Order_Date = CONVERT(date, Order_Date)

ALTER TABLE Superstore
ALTER COLUMN Order_date DATE

SELECT DISTINCT(Customer_ID)
FROM Superstore

--------AVG SALES FOR ALL CUSTOMERS (SUB QUERRIES)------

SELECT Customer_ID, Sales,(SELECT AVG(SALES) FROM Superstore) AS AVG_Sales
FROM Superstore


-------AVG SALES FOR ALL CUSTOMERS (CTE)------
WITH AVG_Sales AS(SELECT AVG(SALES) AS Average_sales FROM Superstore)

SELECT Customer_ID,Sales FROM Superstore WHERE Sales> (SELECT Average_Sales FROM AVG_Sales)


-------AVG SALES FOR ALL CUSTOMERS (TEMP TABLE)------
SELECT AVG(SALES) AS Average_sales INTO #Average_salesTable FROM Superstore

SELECT Customer_ID,Sales FROM Superstore WHERE Sales> (SELECT Average_Sales FROM #Average_salesTable)



-------AVG SALES FOR EACH CUTOMER ( SUM OF TOTAL SALES/OCUCURENCIES)------
SELECT Superstore.Customer_ID, Superstore.Customer_name, Superstore.Sales,AVGsalestable.AVGSales
FROM SuperStore
JOIN 
(SELECT Customer_ID, AVG(sales) AS AVGSales FROM Superstore GROUP BY Customer_ID) AS AVGsalestable
ON Superstore.Customer_ID = AVGsalestable.Customer_ID

------USING WHERE CLAUSE SUB-QUERRY-----
SELECT Customer_ID, Customer_name, Sales
FROM Superstore
WHERE Sales > (SELECT AVG(SALES) FROM Superstore)

------USING COUNT CLAUSE SUB-QUERRY TO SHOW CUSTOMERS THAT BOUGHT ABOVE AVG SALES-----
SELECT COUNT(*)
FROM Superstore
WHERE Sales > (SELECT AVG(SALES) FROM Superstore)


