# Retail, Customer and Sales Analytics Project | Power BI & SQL

An interactive retail business intelligence project built with Power BI and MySQL. The project analyzes sales transactions, store performance, product and category performance, inventory movements, and customer insights for the 2024 calendar year.

The solution combines SQL-based data preparation and ETL exercises with a multi-page Power BI report containing executive KPIs, geographic analysis, product analysis, inventory monitoring, customer insights, bookmarks, and a custom tooltip page.

## 🎥 Project Demo (Video Walkthrough)

Watch the complete project walkthrough to explore the dashboard, its interactive features, sales insights, customer analysis and visualizations.

▶️ [Watch the Retail, Customer and Sales Analytics Dashboard Demo on YouTube] Link: https://www.youtube.com/watch?v=J050LDI8jAk

## Project objectives

- Monitor retail sales, quantity and profit.
- Compare sales and profitability across product categories, subcategories, brands and stores.
- Analyze store and regional performance.
- Monitor inventory opening stock, purchases, sales quantity and closing stock.
- Understand customer demographics, loyalty tiers and repeat-purchase behaviour.
- Prepare and combine fact and dimension datasets for reporting.
- Create an interactive Power BI report for business users.

## Technology stack

- **Business Intelligence:** Microsoft Power BI Desktop
- **Data preparation:** Power Query
- **Calculations:** DAX measures
- **Database and querying:** MySQL, SQL
- **Data modeling:** Fact and dimension tables
- **Reporting:** KPI cards, slicers, maps, charts, tables, decomposition tree, treemap, gauges/other interactive visuals, bookmarks and custom tooltips

## Dataset overview

The project includes six CSV datasets:

| File | Rows | Columns | Description |
|---|---:|---:|---|
| `Sales_Fact.csv` | 3,000 | 7 | Sales transaction ID, date, product, store, customer, quantity and discount |
| `Inventory_Fact.csv` | 65,880 | 8 | Daily inventory records including opening stock, purchase quantity, sales quantity and closing stock |
| `Customer_Dim.csv` | 500 | 8 | Customer name, gender, city, state, age, join date and loyalty tier |
| `Product_Dim.csv` | 180 | 7 | Product name, category, subcategory, brand, cost price and selling price |
| `Store_Dim.csv` | 10 | 5 | Store name, city, region and manager |
| `Calendar_Dim.csv` | 366 | 6 | Calendar date, month, quarter, year, fiscal month and fiscal year |

The supplied datasets cover January 1 to December 31, 2024. The sales fact contains 3,000 transaction rows and 7,394 total units sold. The inventory fact contains 65,880 records.

The supplied CSV files have no missing values or exact duplicate rows in the initial file-level checks. Sales product, customer and store IDs, as well as inventory product and store IDs, all matched the corresponding supplied dimension keys in the checks performed.

## SQL and ETL workflow

The SQL script `All SQL Queries ETL.sql` contains exercises and transformations in the following areas:

### 1. Data cleaning and standardization

- Trimming and standardizing product category text.
- Casting transaction and customer dates to DATE.
- Selecting consistent fields from the fact and dimension tables.

### 2. Missing-value handling

- Using `COALESCE` for missing closing stock values.
- Assigning a default loyalty tier where missing.
- Demonstrating a store-region fallback using a region reference table.

### 3. Joining tables

Combining sales with product, customer and store data using joins to create a wider analytical view.

### 4. Date transformations

Extracting year, month, month name, day, quarter, week and year-month attributes.

### 5. Aggregations and business analysis

- Quantity by date, product and store.
- Monthly quantity by product and store.
- Average selling price calculation.
- Repeating customer identification using `GROUP BY` and `HAVING`.
- Sales contribution analysis.

### 6. Data quality checks and final ETL table

- Duplicate SaleID checks.
- Negative quantity checks.
- Referential integrity checks for product IDs.
- Creation of a denormalized `fact_sales` table by joining sales, product, customer and store data.

**SQL validation note:** The script is an exercise/working ETL script and should be reviewed before production use. For example, the sales contribution query joins `product_dim.ProductID` to `sales_fact.StoreID`, which appears to be an incorrect join key. The `ASP` query divides the sum of product selling prices by total quantity rather than calculating weighted revenue divided by quantity. The final `fact_sales` query selects unit selling price as `TotalAmount`, rather than multiplying selling price by quantity. The script also refers to `region_referencetable`, which is not among the supplied CSV files. Validate and correct these expressions before presenting their outputs as business results.

## Power BI report pages

The supplied report PDF and PBIX show five main report pages and one hidden tooltip page.

### 1. Sales Overview

- Total Sales, Total Quantity and Total Profit KPI cards.
- Sales by product category.
- Sales by product subcategory.
- Monthly sales trend.
- Monthly profit trend.
- Total quantity by store region.
- Navigation buttons to other report pages.

### 2. Store Performance

- Sales distribution by store.
- Total sales by city using a map.
- Store-region slicer.
- Total quantity by store.
- Total profit by store.
- Purchase quantity by manager.

### 3. Product & Category

- Average selling price by quantity.
- Quantity by product subcategory.
- Total sales by brand.
- Total sales by category.
- Decomposition tree using store region, category and product attributes.
- Monthly category count table.

### 4. Inventory & Stock

- Current stock by brand.
- Opening stock and closing stock table by product.
- Sales by store and stock-out visual.
- Sales distribution by store.
- Purchase quantity by store.

### 5. Customer Insights

- Customer gender distribution.
- Customer count by store region.
- Customer distribution by city and state.
- Loyalty-tier customer analysis.
- Recurring customers by store.
- Customer by store waterfall visual.

### 6. Custom Tool Tip (hidden page)

- Dedicated report tooltip page.
- Contextual KPI cards.
- Profit analysis by category.
- Supports contextual exploration from report visuals.

## DAX and reporting concepts

The report's visible measure table and visuals reference measures including:

- Avg Price
- Avg SP
- Current Stock
- MTD Sales
- Product Rank
- Profit %
- Recurring Customer
- Stock-Out Flag
- Top 10 Product
- Total Cost
- Total Customer
- Total Profit
- Total Quantity
- Total Sales
- YOY % Growth
- YTD Sales

The report also uses a Calendar Table, customer, inventory, product and sales tables, and report bookmarks such as Sales Reset, Customer Insights, Store Page, Product Page and Inventory Page.

The exact DAX expressions and model relationship cardinalities should be verified in Power BI Desktop before documenting the formula logic in detail.

## Suggested repository structure

```text
retail-customer-sales-analytics/
│
├── PowerBI/
│   └── Retail, Customer and Sales Analytics Project.pbix
│
├── SQL/
│   └── All SQL Queries ETL.sql
│
├── Data/
│   ├── Calendar_Dim.csv
│   ├── Customer_Dim.csv
│   ├── Inventory_Fact.csv
│   ├── Product_Dim.csv
│   ├── Sales_Fact.csv
│   └── Store_Dim.csv
│
├── Screenshots/
│   ├── Sales_Overview.png
│   ├── Store_Performance.png
│   ├── Product_Category.png
│   ├── Inventory_Stock.png
│   └── Customer_Insights.png
│
└── README.md
```

Adjust paths and filenames to match the repository you actually publish. Confirm that the data is yours to redistribute before uploading it publicly.

## How to open the project

1. Install Microsoft Power BI Desktop.
2. Clone or download this repository.
3. Open the PBIX file in Power BI Desktop.
4. If Power BI requests source paths, update them in **Transform data → Data source settings** or in Power Query to point to the local `Data` folder.
5. Refresh the model.
6. Explore the report pages using navigation buttons, slicers, bookmarks and visual interactions.

To run the SQL exercises, create or select the `retail` database in MySQL, load the CSV data into tables named `sales_fact`, `inventory_fact`, `customer_dim`, `product_dim`, `store_dim` and `calendar_dim`, then review the SQL script's validation notes before executing the full script.

## Business questions explored

- How do sales, quantity and profit vary by month?
- Which categories, subcategories and brands contribute most to sales?
- Which stores and regions contribute most to sales and quantity?
- How do purchase quantities and inventory levels vary across stores?
- Which products and brands have higher or lower stock levels?
- How are customers distributed by gender, city, region and loyalty tier?
- Which stores have more recurring customers?
- How can managers navigate from executive KPIs to store, product, inventory and customer detail?

## Data and metric validation notes

- The sales dataset contains quantity and discount, but no precomputed revenue or profit columns. Revenue, discount treatment, cost and profit depend on the DAX or SQL business definitions used in the report.
- The SQL script contains calculations and joins that need validation, as described above.
- Inventory stock-out logic should be checked against the intended business definition and the inventory data grain.
- Calendar and fiscal-year definitions should be confirmed before making year-over-year or fiscal comparisons.
- The report screenshots show rounded or abbreviated KPI values. Use the PBIX measure definitions and filter context for exact values rather than treating screenshot labels as raw-data totals.
- The report is based on one year of supplied data (2024), so year-over-year growth should only be interpreted if additional periods exist in the model or the measure has another explicit comparison basis.

## Resume-ready project summary

Developed a multi-page Power BI retail analytics dashboard using sales, inventory, product, store, customer and calendar datasets. Created business KPIs and interactive reports for sales trends, store performance, product/category analysis, inventory monitoring and customer insights. Used SQL for data cleaning, joins, aggregations, data quality checks and ETL preparation, and implemented Power BI bookmarks, slicers, drill-through-style navigation and custom tooltips.

## Disclaimer

This is an educational portfolio/business intelligence project. Reported metrics depend on the data model, DAX definitions, SQL transformations, filter context and business assumptions. Validate calculations before using them for operational or financial decisions.
