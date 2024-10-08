/****** Script for SelectTopNRows command from SSMS  ******/
--1. Display all data from DimCustomer
SELECT *
FROM DimCustomer

--2. Select all data from DimProduct
SELECT *
FROM DimProduct;

--3. Select all data from Dimemployee
SELECT *
FROM DimEmployee;

--4. Select first name and last name of all employees from DimEmployee

SELECT FirstName, LastName, BirthDate, Gender, MaritalStatus
FROM DimEmployee

--5. Give me the names of the customers whose income is greater than 60000 from DimCustomer
SELECT FirstName, LastName, YearlyIncome 
FROM DimCustomer
where YearlyIncome>60000

--6. Show me the City, Country, Postal Code from DimGeography

SELECT DG.City, DG.EnglishCountryRegionName Country, DG.PostalCode
FROM DimGeography as DG

--6A. Display all the customers who have less than 3 children
SELECT FirstName, LastName, TotalChildren
FROM DimCustomer
WHERE TotalChildren < 3
AND TotalChildren > 0

--6B. Display the products whose reorder point level is more than 250
select EnglishProductName, ReorderPoint
from DimProduct
where ReorderPoint > 250

--6C. Give me the of the full name of customers who are married and have yearly income more than 100000

select FirstName+' '+LastName FullName, MaritalStatus, YearlyIncome
from DimCustomer
where MaritalStatus = 'M'
and YearlyIncome > 100000

--6D. Give me the names of the female customers whose yearly income is < 100000
select FirstName, LastName, Gender, YearlyIncome
from DimCustomer
where Gender = 'F'
and YearlyIncome < 100000

--6E. List all male customers whose birth date is more than 1st Jan 1970
select FirstName, LastName, Gender, BirthDate
from DimCustomer
where Gender = 'M'
and BirthDate > '1970-01-01'

--Text and dates should be mentioned in single quotes

--7. Get the customers whoes occupation is either Professional and Management
select FirstName, LastName, EnglishOccupation Occupation
from DimCustomer
where EnglishOccupation = 'PROFESSIONAL'
OR EnglishOccupation = 'MANAGEMENT'

--when both the conditions needs to be satisfied we use and
--when either of the condition needs to be executed we use or.
--Conditions are not case sensitive

--7A. Display all products which are Red or Black in color
select EnglishProductName Product, Color
from DimProduct
where Color = 'Red'
or Color = 'Black'

--8. Get accountkey, parentaccountkey and account discription from DimAccount
-- whose account type is liabilities

select AccountKey, ParentAccountKey, AccountDescription, AccountType
from DimAccount
where AccountType = 'Liabilities'

--9. Display productkey and product name from DimProduct where reorder point is more than 300
-- and color is black

select ProductKey, EnglishProductName ProductName, ReorderPoint, Color
from DimProduct
where ReorderPoint > 300 and Color = 'Black'

--10. Give me the names of the products who are silver in color
select EnglishProductName, Color
from DimProduct
where Color = 'silver'

--11. Employees working HR and Sales
select FirstName, LastName, DepartmentName
from DimEmployee
where DepartmentName = 'Human Resources'
or DepartmentName = 'Sales'

--12. Give  me department names from DimEmployee
select distinct DepartmentName
from DimEmployee

--Note: Distinct keyword is used to get unique values from the record

--13. Display sales order number productkey and freight from FactResellerSales 
-- whose freight is greater than 15 and less than 100

select SalesOrderNumber, ProductKey, Freight
from FactResellerSales
where Freight > 15 
and Freight < 100

--or
select SalesOrderNumber, ProductKey, Freight 
from FactResellerSales
where Freight between 15 and 100

--note : between includes top and bottom limit, which is same as <= and >=

--14. Give me names of employees working in hr, sales, purchasing and marketing
SELECT FirstName+' '+LastName EmpName, DepartmentName
FROM DimEmployee
where DepartmentName in ('Human Resources', 'Marketing', 'Sales', 'Purchasing')

--15. Display employeekey, parentemployeekey and department name of employees
-- whose employeekey is 1. 19. 276, 105 and 73

SELECT EmployeeKey, ParentEmployeeKey, DepartmentName
FROM DimEmployee
WHERE EmployeeKey IN (1,19,276, 105,73)

--16. Give me the list of employees who are married and whose base rate is greater than 10 and less tha 25
SELECT FirstName+' '+LastName EmpName, MaritalStatus, BaseRate
FROM DimEmployee
where BaseRate >= 10 
and BaseRate <= 25
and MaritalStatus = 'M'

--17. Give me all married female employees list whose base rate is between 10 and 25
Select FirstName, LastName, MaritalStatus, Gender, BaseRate
from DimEmployee
where Gender= 'F'
and MaritalStatus = 'M'
and BaseRate between 10 and 25

--18. Display all the customer names starting with J

select FirstName
from DimCustomer
where FirstName like '%J%'

--19A. Display all customer whose first name starts with J, E and C
select FirstName
from DimCustomer
where FirstName like '[JEC]%'

--20. Display Customer name, birthdate, gender
select FirstName, LastName, BirthDate, Gender
from DimCustomer

--21. Display all products with their subcategory name
select EnglishProductName Products, EnglishProductSubcategoryName SubCategory
from DimProduct as DP
left join DimProductSubcategory as DPS
on DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey

--21A. Dipslay all customers with their country, state and city
select FirstName, LastName, EnglishCountryRegionName, StateProvinceName, City
from DimCustomer as DC
left join DimGeography as loc
on DC.GeographyKey = loc.GeographyKey

--21B. Dispaly all employees with their territories

--23 Display Departmentwise count
select DepartmentName, count(*) NumberofEmployees 
from DimEmployee
group by DepartmentName
order by 2 desc

--24. ProductSubCategorywise number of Products from DimProduct
select EnglishProductSubcategoryName, count(*) NoofProducts
 from DimProduct as DP
 left join DimProductSubcategory as DPS
 on  DP.ProductSubcategoryKey=DPS.ProductSubcategoryKey
 group by DPS.EnglishProductSubcategoryName

 --25. ProductSubCategorywise number of Products from DimProduct WHERE subcategories IS not null

 select dps.EnglishProductSubcategoryName SubCategory, Count(*) numberofproducts 
 from DimProduct as DP
 inner join DimProductSubcategory as DPS
 on DP.ProductSubcategoryKey= DPS.ProductSubcategoryKey
 group by DPS.EnglishProductSubcategoryName

 --26. Display count of married female employees
 SELECT COUNT(*) NoofMarriedFemale
 FROM DimEmployee
 WHERE MaritalStatus='M'
 and Gender ='F'

 --27. Display departmentwise count of married female employees
 SELECT DepartmentName, COUNT(*) NoofMarriedFemaleEmp
 FROM DimEmployee
 WHERE MaritalStatus='M'
 and Gender ='F'
 group by DepartmentName

 --28. CustomerNamewise total slaes and total freight from FactInternetSales

 select DC.FirstName+ ' '+DC.LastName, SUM(FIS.SalesAmount) TotalSales, SUM(FIS.Freight) TotalFrieght
 from FactInternetSales as FIS
 join DimCustomer as DC
 on FIS.CustomerKey = DC.CustomerKey
 group by  DC.FirstName+ ' '+DC.LastName


 --29. Display productwise total sales from FactInternetSales
 
select EnglishProductName as Product, Round(Sum(FIS.SalesAmount),2) TotalSales
 from FactInternetSales as FIS
 join DimProduct as DP
 on FIS.ProductKey = DP.ProductKey
 group by DP.EnglishProductName

 --30. ProductSubcategory wise Average sales from FactInternetSales
 select 
 from FactInternetSales as FIS
 JOIN DimProduct as DP
 on FIS.ProductKey= DP.ProductKey
 JOIN DimProductSubcategory as DPS
 on FIS.

 --31. Counrtywsie total sales in ascending order from FactResellerSales

 SELECT DG.EnglishCountryRegionName Country, ROUND(SUM(FRS.SalesAmount),2)TotalSales
 FROM FactResellerSales AS FRS
 JOIN DimSalesTerritory AS DST
 ON FRS.SalesTerritoryKey = DST.SalesTerritoryKey
 JOIN DimGeography AS DG
 ON DST.SalesTerritoryKey = DG.SalesTerritoryKey
 GROUP BY DG.EnglishCountryRegionName
 ORDER BY ROUND(SUM(FRS.SalesAmount),2) ASC

 --32. Countrywise Statewise total sales from FactInternetSales

 SELECT DG.EnglishCountryRegionName Country, DG.StateProvinceName StateName, ROUND(SUM(FRS.SalesAmount),2)TotalSales
 FROM FactResellerSales AS FRS
 JOIN DimSalesTerritory AS DST
 ON FRS.SalesTerritoryKey = DST.SalesTerritoryKey
 JOIN DimGeography AS DG
 ON DST.SalesTerritoryKey = DG.SalesTerritoryKey
 GROUP BY DG.EnglishCountryRegionName, DG.StateProvinceName
 ORDER BY 1,3

 --CORRECT WAY

 SELECT DG.EnglishCountryRegionName, DG.StateProvinceName, ROUND(SUM(FRS.SalesAmount),2)TotalSales
 FROM FactResellerSales FRS
 JOIN DimReseller DR
 ON FRS.ResellerKey = DR.ResellerKey
 JOIN DimGeography AS DG
 ON DR.GeographyKey = DG.GeographyKey
 GROUP BY DG.EnglishCountryRegionName, DG.StateProvinceName
 ORDER BY 1, 3 DESC

 --32A. Countrywise Statewise total sales from FactInternetSales
 SELECT DG.EnglishCountryRegionName Country, DG.StateProvinceName, ROUND(SUM(FIS.SalesAmount),2)TotalSales
 FROM FactInternetSales AS FIS
 JOIN DimCustomer DC
 ON FIS.CustomerKey = DC.CustomerKey
 JOIN DimGeography DG
 ON DC.GeographyKey = DG.GeographyKey
 GROUP BY DG.EnglishCountryRegionName, DG.StateProvinceName
 ORDER BY 1, 3

 --33. Countrywise Resellerwise total slaes from FactResellerSales
 SELECT DG.EnglishCountryRegionName Country, DR.ResellerName, Sum(FRS.SalesAmount)TotalSales
 FROM FactResellerSales AS FRS
 JOIN DimReseller DR
 ON FRS.ResellerKey=DR.ResellerKey
 JOIN DimGeography AS DG
 ON DR.GeographyKey=DG.GeographyKey
 GROUP BY DG.EnglishCountryRegionName, DR.ResellerName
 order by 1, 3 ASC

 --34. Fiscal yearwise employeewiSE average sales from FactResellersSales
 SELECT DD.FiscalYear FiscalYear, DE.FirstName+' '+DE.LastName Employee, AVG(FRS.SalesAmount)AvgSalesAmt
 FROM FactResellerSales AS FRS
 JOIN DimDate AS DD
 ON FRS.OrderDateKey = DD.DateKey
 JOIN DimEmployee AS DE
 ON FRS.EmployeeKey =DE.EmployeeKey
 GROUP BY DD.FiscalYear, DE.FirstName+' '+DE.LastName
 order by 1, 3 desc

 --35. Sales territory country wise employee wise category wise Minimum and Maximum Sales from FactInternetSales
 SELECT DST.SalesTerritoryCountry Country, DE.FirstName+' '+DE.LastName, DPC.EnglishProductCategoryName Category,
 MIN(FIS.SalesAmount)MinimumSalesAmt, MAX(FIS.SalesAmount)MaximumSalesAmt
 FROM FactInternetSales FIS
 JOIN DimSalesTerritory DST
 ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
 JOIN DimEmployee DE
 ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
 JOIN DimProduct DP
 ON FIS.ProductKey = DP.ProductKey
 JOIN DimProductSubcategory AS DPS
 ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
 JOIN DimProductCategory AS DPC
 ON DPS.ProductCategoryKey = DPC.ProductCategoryKey
 group by DST.SalesTerritoryCountry, DE.FirstName+' '+DE.LastName, DPC.EnglishProductCategoryName
 order by 1


 --36 HW. SubCategorywise total sale from FactInternetSales
 SELECT DPS.EnglishProductSubcategoryName, SUM(FIS.SalesAmount) TotalSales
 FROM FactInternetSales FIS
 JOIN DimProduct DP
 ON FIS.ProductKey = DP.ProductKey
 JOIN DimProductSubcategory DPS
 ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
 GROUP BY DPS.EnglishProductSubcategoryName
 ORDER BY 2 desc

--37. Dispaly salesoredrnumber, salesorederlinenumber, amount due from FactInternetSales
SELECT SalesOrderNumber, SalesOrderLineNumber, (FIS.SalesAmount+FIS.TaxAmt+FIS.Freight) AmtDue
FROM FactInternetSales FIS

--38. Display employeekey, employee full anme, department name and manager name from DimEmployee
SELECT E.EmployeeKey, E.FirstName+' '+E.LastName EmployeeName,  E.DepartmentName, M.FirstName+' '+M.LastName ManagerName
FROM DimEmployee E
LEFT JOIN DimEmployee M
ON E.ParentEmployeeKey = M.EmployeeKey
ORDER BY 1 

--39. Display manager name from DimEmployee, total number of employees reporting to him
SELECT M.FirstName+' '+M.LastName ManagerName, COUNT(*)
FROM DimEmployee E
JOIN DimEmployee M
ON E.ParentEmployeeKey = M.EmployeeKey
GROUP BY M.FirstName+' '+M.LastName
ORDER BY 1

--40. Find the names of the customers who have registered more than 15 orders from 
-- FactInternetSales
SELECT DC.FirstName+' '+DC.LastName CustName, COUNT(*)NumberofOrders
FROM FactInternetSales FIS
JOIN DimCustomer DC
ON FIS.CustomerKey = DC.CustomerKey
GROUP BY DC.FirstName+' '+DC.LastName
HAVING COUNT(*) >15
ORDER BY 2 DESC

--41. Find the names of the customers who have registered more than 60 orders from 
-- FactInternetSales

SELECT DC.FirstName+' '+DC.LastName CustName, COUNT(*)NumberofOrders
FROM FactInternetSales FIS
JOIN DimCustomer DC
ON FIS.CustomerKey = DC.CustomerKey
GROUP BY DC.FirstName+' '+DC.LastName
HAVING COUNT(*) >60
ORDER BY 2 DESC

--42. Display Categorywise Employeewise total sale where total sales is greater than 2 lakh

SELECT DPC.EnglishProductCategoryName Category, DE.FirstName+' '+DE.LastName EmpName, ROUND(SUM(FIS.SalesAmount),2) TotalSales
FROM FactInternetSales FIS
JOIN DimProduct DP
ON FIS.ProductKey = DP.ProductKey
JOIN DimProductSubcategory as DPS
on DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
JOIN DimProductCategory AS DPC
ON DPS.ProductCategoryKey = DPC.ProductCategoryKey
JOIN FactResellerSales AS FRS
ON DP.ProductKey = FRS.ProductKey
JOIN DimEmployee AS DE
ON FRS.EmployeeKey = DE.EmployeeKey
group by DPC.EnglishProductCategoryName, DE.FirstName+' '+DE.LastName
HAVING ROUND(SUM(FIS.SalesAmount),2)  > 200000
order by 1, 3 DESC

--Alternate way

SELECT DPC.EnglishProductCategoryName Category, DE.FirstName+' '+DE.LastName EmpName,
ROUND(SUM(FIS.SalesAmount),2)TotalSales
FROM FactInternetSales FIS
JOIN DimProduct DP
ON FIS.ProductKey = DP.ProductKey
JOIN DimProductSubcategory as DPS
on DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
JOIN DimProductCategory AS DPC
ON DPS.ProductCategoryKey = DPC.ProductCategoryKey
JOIN DimSalesTerritory as DST
on FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE
ON DST.

group by DPC.EnglishProductCategoryName, DE.FirstName+' '+DE.LastName
HAVING ROUND(SUM(FIS.SalesAmount),2)  > 200000
order by 1, 3 DESC

--43. Which are the top 10 selling products from FactInternetSales

WITH ProductWiseSale AS
(
SELECT DP.EnglishProductName AS Product, ROUND(SUM(FIS.SalesAmount),2)ProductSale
FROM FactInternetSales as FIS
JOIN DimProduct AS DP
ON FIS.ProductKey = DP.ProductKey
GROUP BY DP.EnglishProductName
--ORDER BY 2 DESC
), ProductSalesList AS
(
SELECT PS.Product, PS.ProductSale, ROW_NUMBER() OVER (order BY PS.PRODUCT)SrNo
FROM ProductWiseSale as PS
)
select SrNo, Product, ProductSale
from ProductSalesList as PSL
where PSL.SrNo <=10

--44. Create a output which will give me top 3 products by employee
--from FactResellerSales for Financial year 2007

WITH EmployeewiseProductSale As
(
SELECT DE.FirstName+' '+DE.LastName Employee, DP.EnglishProductName Product, ROUND(SUM(FRS.SalesAmount),2)ProductSales
FROM FactResellerSales FRS
JOIN DimEmployee DE
ON FRS.EmployeeKey = DE.EmployeeKey
JOIN DimProduct DP
ON FRS.ProductKey = DP.ProductKey
JOIN DimDate DD
ON FRS.OrderDateKey = DD.DateKey
GROUP BY DE.FirstName+' '+DE.LastName, DP.EnglishProductName
),EmployeewiseProductSaleRank AS
(
SELECT EPS.Employee, EPS.Product, EPS.ProductSales,
ROW_NUMBER() OVER (PARTITION BY EPS.Employee ORDER BY EPS.ProductSales DESC)SrNo
FROM EmployeewiseProductSale AS EPS
)
SELECT EPSR.SrNo, EPSR.Employee, EPSR.Product, EPSR.ProductSales
FROM EmployeewiseProductSaleRank EPSR
WHERE EPSR.SrNo <=3

--RANK, DENSE RANK, ROW_NUMBER ON ADVENTUREWORKSDW

--A] RANK

SELECT ProductID, Name, ListPrice,
rank() OVER
(ORDER BY LIST PRICE DESC)PriceRank
FROM Production.Product

--B] DENSE rANK

SELECT ProductID, Name, ListPrice,
DENSE_RANK() OVER
(ORDER BY LIST PRICE DESC)PriceRank
FROM Production.Product

C] ROW NUMBER

SELECT ProductID, Name, ListPrice,
ROW_NUMBER() OVER
(ORDER BY LIST PRICE DESC)PriceRank
FROM Production.Product

--45. SubCategorywise Top 2 selling Products from FactInternetSales
WITH SubCategorywiseProductSale AS
(
SELECT DPS.EnglishProductSubcategoryName SUBCATEGORY, DP.EnglishProductName PRODUCT, 
SUM(FIS.SalesAmount)TOTALSALE
FROM FactInternetSales FIS
JOIN DimProduct DP
ON FIS.ProductKey = DP.ProductKey
JOIN DimProductSubcategory DPS
ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
GROUP BY DPS.EnglishProductSubcategoryName, DP.EnglishProductName
--ORDER BY 1 DESC
), SubCategorywiseProductSaleRank AS
(
SELECT SPS.SUBCATEGORY, SPS.PRODUCT, SPS.TOTALSALE,
DENSE_RANK() OVER (PARTITION BY SPS.SUBCATEGORY ORDER BY SPS.TOTALSALE DESC)SrNo
FROM SubCategorywiseProductSale AS SPS
)
SELECT SPSR.SrNo, SPSR.SUBCATEGORY, SPSR.PRODUCT, SPSR.TOTALSALE
from SubCategorywiseProductSaleRank as SPSR
WHERE SPSR.SrNo <= 2;

--46. Create out put from FRS to list the products where Products total sale is < average sale per product

WITH AvgSale AS
(
SELECT SUM(FRS.SalesAmount)/COUNT(DISTINCT FRS.ProductKey)AvgSalesperProduct
FROM FactResellerSales FRS

)
SELECT DP.EnglishProductName Product, SUM(FRS.SalesAmount)TotalSale, AvgSale.AvgSalesperProduct
FROM AvgSale, FactResellerSales FRS
JOIN DimProduct DP
ON FRS.ProductKey = DP.ProductKey
GROUP BY DP.EnglishProductName, AvgSale.AvgSalesperProduct
HAVING SUM(FRS.SalesAmount) < AvgSale.AvgSalesperProduct
ORDER BY 2 DESC


--47.Give me the list of countries whose sales is greater than AverageSalePerCountry from FactResellerSales
WITH CountrywiseSales AS
(
SELECT DG.EnglishCountryRegionName Country,SUM(FRS.SalesAmount)CountrywiseSale, 
SUM(FRS.SalesAmount)/ COUNT(DISTINCT FRS.ProductKey)TotalAvgSales
FROM FactResellerSales AS FRS
JOIN DimSalesTerritory AS DST
ON FRS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimGeography AS DG
ON DST.SalesTerritoryKey = DG.SalesTerritoryKey
GROUP BY DG.EnglishCountryRegionName
)
SELECT CS.Country, CS.CountrywiseSale, CS.TotalAvgSales
FROM CountrywiseSales AS CS
where CS.CountrywiseSale > CS.TotalAvgSales

SELECT DISTINCT DG.EnglishCountryRegionName
FROM DimGeography DG

--E] LEAD

SELECT 
FROM PURCHASING.PURCHASE 


--Union [Northwind]
-- Sometimes there is a need to combine from multiple tables or views into one comprehensive dataset

SELECT City, Country FROM Customers
where Country = 'Germany'
UNION
SELECT City, Country FROM Suppliers
WHERE Country = 'Germany'
order by 1


SELECT City, Country FROM Customers
where Country = 'Germany'
UNION ALL
SELECT City, Country FROM Suppliers
WHERE Country = 'Germany'
order by 1;

--52-From FactInternetSales display only those employees selling highest and lowest product for fiscalyear 2008

WITH Employees as
(
SELECT DD.FiscalYear, DE.FirstName+' '+DE.LastName Employee, DP.EnglishProductName Product, FIS.SalesAmount Sales
FROM FactInternetSales FIS
JOIN DimSalesTerritory DST
ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE
ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
JOIN DimDate DD
ON FIS.OrderDateKey = DD.DateKey
JOIN DimProduct DP
ON FIS.ProductKey = DP.ProductKey
WHERE DD.FiscalYear = 2008
GROUP BY DD.FiscalYear, DE.FirstName+' '+DE.LastName, DP.EnglishProductName, FIS.SalesAmount
), MaxSale as
(
select E.*, DENSE_RANK() OVER(PARTITION BY E.Employee order by E.Sales DESC)Ranks
from Employees E
), MinSale as
(
select E.*, DENSE_RANK() OVER(PARTITION BY E.Employee order by E.Sales)Ranks
from Employees E
)
SELECT MS.*
FROM MaxSale MS
WHERE Ranks = 1
UNION
SELECT MM.*
FROM MinSale MM
WHERE Ranks = 1


-- From FactInternetSales display only those employees selling highest and lowest product for fiscalyear 2008

WITH ProductSale AS
(
SELECT DD.FiscalYear, DE.FirstName+' '+DE.LastName Employee, DP.EnglishProductName Product, SUM(FIS.SalesAmount) Sales
FROM FactInternetSales FIS
JOIN DimSalesTerritory DST
ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE
ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
JOIN DimDate DD
ON FIS.OrderDateKey = DD.DateKey
JOIN DimProduct DP
ON FIS.ProductKey = DP.ProductKey
WHERE DD.FiscalYear = 2008
GROUP BY DE.FirstName+' '+DE.LastName,DD.FiscalYear, DP.EnglishProductName, FIS.SalesAmount
-- ORDER BY 1, 4 DESC
), MaxSold as
(
SELECT PS.*, ROW_NUMBER() OVER(ORDER BY PS.Sales DESC)Ranks
from ProductSale PS
), MinSold as
(
select PS.*, ROW_NUMBER() OVER(ORDER BY PS.Sales)Ranks
from ProductSale PS
)
SELECT MS.*
FROM MaxSold MS
WHERE MS.Ranks = 1
UNION
SELECT MM.*
FROM MinSold MM
WHERE MM.Ranks = 1