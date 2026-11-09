create database retail;
use retail;

select * from product_dim;
select * from calendar_dim;
select * from customer_dim;
select * from store_dim;
select * from inventory_fact;
select * from sales_fact;

-- UseCase 1 - Data cleaning and Standardizing
select ProductID, ProductName, upper(trim(Category)) as CleanCategory, Brand, CostPrice, SellingPrice from product_dim;

select SaleID, ProductID, CustomerID, StoreID, cast(date as Date) as SalesDate, Quantity, Discount from sales_fact;

select CustomerID, Name, Gender, City, State, Age, cast(JoinDate as Date) as JoinDate, LoyaltyTier from customer_dim;

select cast(date as Date) as Date, Month, Quarter, Year, FiscalMonth, FiscalYear from calendar_dim;

select InventoryID, cast(date as Date) as Date, ProductID, StoreID, OpeningStock, PurchaseQty, SalesQty, ClosingStock 
from inventory_fact;

-- UseCase 2 - Handling the null values, missing values and data correction

-- Null Value handling
select InventoryID, Date, ProductID, StoreID, OpeningStock, PurchaseQty, SalesQty, coalesce(ClosingStock, 0) as ClosingStock 
from inventory_fact;

-- Missing Value Handling
select CustomerID, Name, Gender, City, State, Age, JoinDate, coalesce(LoyaltyTIer, 'Silver') as LoyaltyTier from customer_dim;

-- Handling Missing Values where things matters, like LoyaltyTier set default as Silver not make much impact but making default any region impact a lot
select s.StoreID, s.StoreName, coalesce(s.region, r.defaultregion) as Region
from store_dim s
left join region_referencetable r on s.storename = r.storename;

-- Usecase 3 - Joining the tables

select s.SaleID, s.Date, s.Quantity, p.ProductName, p.Category, c.Name, c.City, st.Region, st.StoreName
from sales_fact s
join product_dim p on s.ProductID = p.ProductID
join customer_dim c on s.CustomerID = c.CustomerID
join store_dim st on s.StoreID = st.StoreID;

-- UseCase 4 - 
select
Date, year(date) as Year,
month(date) as Month,
monthname(date) as MonthName,
day(date) as Day,
quarter(date) as Quarter,
week(date) as WeekofYear,
format(date, 'MM-YYYY') as YearMonth from calendar_dim;

-- UseCase 5 > Aggregation Function
select s.Date, p.ProductID, p.ProductName, s.StoreID, sum(s.Quantity) as TotalQty
from sales_fact s
join product_dim p on s.ProductID = p.ProductID
group by date, ProductID, StoreID
order by TotalQty desc;

select year(Date) as Year,
month(Date) as Month,
ProductID, StoreID, sum(Quantity) as TotalQty
from sales_fact
group by year, month, ProductID, StoreID;

-- UseCase 6 > Business KPIs
select p.ProductID, p.ProductName, round(sum(p.SellingPrice)/sum(s.Quantity),0) as ASP
from sales_fact s
join product_dim p on p.ProductID = s.ProductID
group by p.ProductID;

-- Contribution of the column
alter table sales_fact
add column TotalAmount decimal(12,2);

update sales_fact s
join product_dim p on p.ProductID = s.ProductID
set s.TotalAmount = p.SellingPrice * s.Quantity;

select p.Category, sum(p.SellingPrice) as TotalSales,
(sum(p.SellingPrice) *100 / sum(s.TotalAmount)) as Contribution
from sales_fact s
join product_dim p on p.ProductID = s.StoreID
group by p.Category;

-- Repeating customer
select CustomerID, count(*) as PurchaseCount
from sales_fact
group by CustomerID
having count(*) >1;

-- SCD Slowly Changing Dimensions
select p.ProductID, p.ProductName, s.Date, coalesce(p.sellingprice, s.discount) as EffectivePrice
from sales_fact s
join product_dim p 
on s.ProductID = p.ProductID
and s.Date between '2024-06-09' and '2024-06-24';

-- Data Quality
-- 1 Checking duplicate values
select SaleID, count(*)
from sales_fact
group by SaleID
having count(*) >1;

-- 2 Checking Negative Values
select * from sales_fact
where quantity <0;

-- 3 Checking null values
select s.ProductID
from sales_fact s
left join product_dim p 
on s.ProductID = p.ProductID
where p.ProductID is null;

-- Final ETL Fact table
create table fact_sales as
select s.SaleID, s.Date as SalesDate, S.ProductID, 
p.Category, p.Brand, st.StoreID, st.Region as StoreRegion, 
s.CustomerID, s.Quantity, p.SellingPrice as TotalAmount
from sales_fact s
join product_dim p on s.ProductID = p.ProductID
join customer_dim c on s.CustomerID = c.CustomerID
join store_dim st on s.StoreID = st.StoreID;

select * from fact_sales
order by SaleID asc;