--- cleaning Data
--- Total rows = 10991 rows
--- All records have CustomerID. = 10991 rows have CustomerID
CREATE TEMPORARY TABLE online_retail_main AS
with `online retail` as 
(
	SELECT * 
	FROM retail_online.`online retail`
	where CustomerID != 0
)
, quantity_unit_price as
(
	/* 10990 rows with Quantity & UnitPrice
	*/
	select * 
	from `online retail`
	where Quantity > 0 and UnitPrice > 0
)
, dup_check as
(
	/* duplicate check 
	*/
	select * , row_number() over (partition by InvoiceNo, StockCode, Quantity, UnitPrice)dup_flag
	from quantity_unit_price
), dup_flag as
	/* 10719 rows clean data
    271 duplicate data
	*/
(
SELECT * 
FROM dup_check 
WHERE dup_flag = 1
)
-- CLEAN DATA
-- BEGIN COHORT ANALYSIS
SELECT*
FROM online_retail_main;

-- Unique identifer(CustID)
-- Initial start Date (First InvoiceDate)
-- Revenue Data

CREATE temporary table cohort as
SELECT
    CustomerID,
    MIN(STR_TO_DATE(InvoiceDate, '%d/%m/%Y %H:%i')) AS first_purchase_date,
    DATE_FORMAT(
        MIN(STR_TO_DATE(InvoiceDate, '%d/%m/%Y %H:%i')),
        '%Y-%m-01'
    ) AS cohort_date
FROM online_retail_main
WHERE InvoiceDate IS NULL
GROUP BY CustomerID;

select*
from cohort










