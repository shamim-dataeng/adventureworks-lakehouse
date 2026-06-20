-- Create the schema 
CREATE SCHEMA gold;
GO
-- Create views in the gold schema that would be accessed by BI suite

-- 1. Calendar View
CREATE VIEW gold.calendar AS
    SELECT * FROM OPENROWSET(
        BULK 'https://awadls112.dfs.core.windows.net/silver/AdventureWorks_Calendar/',
        FORMAT = 'PARQUET'
    ) as calendarQuery;
GO

-- 2. Customer View 
CREATE VIEW gold.customers AS
    SELECT * FROM OPENROWSET(
        BULK 'https://awadls112.dfs.core.windows.net/silver/AdventureWorks_Customers',
        FORMAT = 'PARQUET'
    ) as customerQuery;
GO

-- 3. Product Categories View
CREATE VIEW gold.products_cat AS
    SELECT * FROM OPENROWSET(
        BULK 'https://awadls112.dfs.core.windows.net/silver/AdventureWorks_Product_Categories',
        FORMAT = 'PARQUET'
    ) as prodCatQuery;
GO

-- 4. Product SubCategories View
CREATE VIEW gold.products_sub_cat AS
    SELECT * FROM OPENROWSET(
        BULK 'https://awadls112.dfs.core.windows.net/silver/AdventureWorks_Product_SubCategories',
        FORMAT = 'PARQUET'
    ) as prodSubCatQuery;
GO

-- 5. Product View
CREATE VIEW gold.products AS
    SELECT * FROM OPENROWSET(
        BULK 'https://awadls112.dfs.core.windows.net/silver/AdventureWorks_Products',
        FORMAT = 'PARQUET'
    ) as prodQuery;
GO

-- 6. Returns View
CREATE VIEW gold.returns AS
    SELECT * FROM OPENROWSET(
        BULK 'https://awadls112.dfs.core.windows.net/silver/AdventureWorks_Returns',
        FORMAT = 'PARQUET'
    ) as returnsQuery;
GO

-- 7. Territories View
CREATE VIEW gold.territories AS
    SELECT * FROM OPENROWSET(
        BULK 'https://awadls112.dfs.core.windows.net/silver/AdventureWorks_Territories',
        FORMAT = 'PARQUET'
    ) as terQuery;
GO

-- 8. Sales View
CREATE VIEW gold.sales AS
    SELECT * FROM OPENROWSET(
        BULK 'https://awadls112.dfs.core.windows.net/silver/AdventureWorks_Sales',
        FORMAT = 'PARQUET'
    ) as salesQuery;

-- CHECK THE EXISTENCE OF GOLD SCHEMA IN SERVERLESS SQL DB WHICH USES A METADATA LAYER TO COMMUNICATE WITH THE UNDERLYING DATA LAKE AND MAKES IT A LAKEHOUSE 
SELECT * FROM sys.schemas;

-- Synapse SQL (serverless), uses T-SQL
SELECT TOP 10 * FROM gold.customers;
/*
NOTE:
    GO is a batch separator. It is not actually SQL syntax — it is a command understood by tools like Synapse Studio, SSMS, and Azure Data Studio.
    It tells the SQL engine:
                                "Execute everything above this line as one batch, then start a new batch."
*/