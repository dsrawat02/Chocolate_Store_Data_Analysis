-- ---------------------------------------------------------------------------------------------------------
-- ---------------------------------EASY PROBLEMS-------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------

# 1.Print details of shipment(sales) like saledate, amount, boxes, amount per boxes.
SELECT SaleDate, Amount, Boxes, Amount / Boxes AS "Amount per box" 
FROM sales;

# 2.Show the shipment(sales) data where the amount is greater than 10,000.
SELECT *
FROM sales
WHERE Amount > 10000
ORDER BY Amount;

# 3.Print details of sales where geography is g1 by product id and descending order of amounts. 
SELECT geoid, pid, amount
FROM sales
WHERE geoid = 'g1'
ORDER BY pid, amount DESC;

# 4.Print details of sales where amount is greater than 10000 and shipped after 2021.  
SELECT saledate, amount
FROM sales
WHERE amount > 10000 AND SaleDate >= '2022-01-01';

# 5.Create a branching logic in amount column where if the amount is less than 1000 it will print 'under 1k', less than 5000 'under 5k', less than 10000 'under 10k'.
SELECT SaleDate, Amount, 
		CASE
				WHEN amount < 1000 THEN 'Under 1k'
				WHEN amount < 5000 THEN 'Under 5k'
                WHEN amount < 10000 THEN 'Under 10k'
			ELSE '10k or more'
		END AS 'Amount Category'
FROM sales;



-- ---------------------------------------------------------------------------------------------------------
-- --------------------------------------INTERMEDIATE PROBLEMS-----------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------

# 1. Print details of shipments (sales) where amounts are greater than 2,000 and boxes are less than 100?
SELECT *
FROM sales
WHERE amount > 2000 AND boxes < 100;

# 2. How many shipments (sales) each of the sales persons had in the month of January 2022?
SELECT p.Salesperson, SUM(s.amount) AS 'Total Amount', COUNT(s.saledate) AS 'Shipment Count'
FROM sales s
LEFT JOIN people p ON s.spid = p.spid
WHERE s.saledate BETWEEN '2022-01-01' AND '2022-01-31'
GROUP BY p.Salesperson
ORDER BY COUNT(s.saledate) DESC;

# 3. Which product sells more boxes? Milk Bars or Eclairs?
SELECT pr.product, SUM(s.boxes) AS 'Total Boxes Sold'
FROM sales s
LEFT JOIN products pr ON pr.pid = s.pid
WHERE pr.product IN ('Milk Bars', 'Eclairs')
GROUP BY pr.product
ORDER BY SUM(s.boxes) DESC;

# 4. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?
SELECT pr.product, SUM(s.boxes) AS 'Total boxes sold'
FROM sales s
LEFT JOIN products pr ON pr.pid = s.pid
WHERE pr.product IN ('Milk Bars', 'Eclairs') AND s.saledate BETWEEN '2022-02-01' AND '2022-02-07'
GROUP BY pr.product
ORDER BY SUM(s.boxes) DESC;

 # 5. Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?
SELECT *
FROM sales
WHERE customers <100 AND boxes <100 AND dayname(saledate) = 'Wednesday';
-- -----------------------OR--------------------------------------------
SELECT *,
CASE 
WHEN weekday(saledate) = 2 THEN 'Wednesday Shipment'
ELSE ''
END AS 'W Shipment'
FROM sales
WHERE customers <100 AND boxes <100;



-- ---------------------------------------------------------------------------------------------------------
-- --------------------------------------HARD PROBLEMS-----------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------

# 1.What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?
SELECT p.Salesperson, COUNT(*) AS 'Shipment Count'
FROM sales s
LEFT JOIN people p ON p.spid = s.spid
WHERE 'Shipment Count' >= 0 AND s.saledate BETWEEN '2022-01-01' AND '2022-01-07'
GROUP BY p.Salesperson;
-- ------------------OR-----------------------------------------
select distinct p.Salesperson
from sales s
join people p on p.spid = s.SPID
where s.SaleDate between '2022-01-01' and '2022-01-07';

# 2.Which salespersons did not make any shipments in the first 7 days of January 2022?
select p.salesperson
from people p
where p.spid not in
(select distinct s.spid 
 from sales s 
 where s.SaleDate between '2022-01-01' and '2022-01-07');
 
# 3.How many times we shipped more than 1,000 boxes in each month?
SELECT YEAR(saledate) 'Year', MONTH(saledate) 'Month', COUNT(*) 'Times we shipped 1k boxes'
FROM sales
WHERE boxes > 1000
GROUP BY YEAR(saledate), MONTH(saledate) 
ORDER BY YEAR(saledate), MONTH(saledate);

# 4.India or Australia? Who buys more chocolate boxes on a monthly basis?
SELECT YEAR(saledate) as Year, MONTH(saledate) 'Month',
SUM(CASE WHEN g.geo = 'India' = 1 THEN boxes ELSE 0 END ) 'India Boxes',
SUM(CASE WHEN g.geo = 'Australia' = 1 THEN boxes ELSE 0 END ) 'Australia Boxes'
FROM sales s
LEFT JOIN geo g ON g.geoid = s.geoid
GROUP BY YEAR(saledate), MONTH(saledate) 
ORDER BY YEAR(saledate), MONTH(saledate);
