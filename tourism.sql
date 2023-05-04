/*What is the percentage of customers who purchased each of the 5 types of packages (Basic, Standard, Deluxe, Super Deluxe, and King) in the last year? */
USE new_schema;
SELECT 
    ProductPitched, 
    COUNT(*) AS TotalCount, 
    ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM tourism WHERE ProdTaken = 1), 2) AS Percentage
FROM 
    tourism 
WHERE 
    ProdTaken = 1 
    AND ProductPitched IN ('Basic', 'Standard', 'Deluxe', 'Super Deluxe', 'King')
GROUP BY 
    ProductPitched;

/*What is the most common occupation among customers who purchased a package?*/
SELECT Occupation, COUNT(*) AS count_occ
FROM tourism
WHERE ProdTaken = 1
GROUP BY Occupation
ORDER BY count_occ DESC;

/*What is the distribution of customers' monthly income?*/
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SELECT COUNT(*) as count, 
       FLOOR(MonthlyIncome/10000)*10000 as range_start, 
       FLOOR(MonthlyIncome/10000)*10000 + 9999 as range_end 
FROM tourism 
GROUP BY FLOOR(MonthlyIncome/10000)*10000;


/*How does the customer's preferred hotel property rating relate to the package they purchased?*/
SELECT PreferredPropertyStar, 
  COUNT(*) as TotalCustomers, 
  SUM(ProdTaken) as CustomersWithPackage, 
  SUM(ProdTaken)/COUNT(*) as PackagePurchaseRate
FROM tourism
GROUP BY PreferredPropertyStar;