CREATE MASTER KEY ENCRYPTION BY PASSWORD ='AdventureWorks_Synapse_Ext_Table'

CREATE DATABASE SCOPED CREDENTIAL cred_shamim
WITH 
    IDENTITY='Managed Identity'

CREATE EXTERNAL DATA SOURCE source_silver
WITH 
(
    LOCATION='https://awadls112.dfs.core.windows.net/silver/',
    CREDENTIAL= cred_shamim
)

CREATE EXTERNAL DATA SOURCE source_gold
WITH 
(
    LOCATION='https://awadls112.dfs.core.windows.net/gold/',
    CREDENTIAL= cred_shamim
)

CREATE EXTERNAL FILE FORMAT format_parquet
WITH 
(
    FORMAT_TYPE=PARQUET,
    DATA_COMPRESSION='org.apache.hadoop.io.compress.SnappyCodec'
)
-- USE CETAS FOR CREATING EXT_TABLE in gold layer of adls gen2
CREATE EXTERNAL TABLE gold.extSales
WITH
(
    LOCATION='extsales',
    DATA_SOURCE=source_gold,
    FILE_FORMAT=format_parquet
) 
AS 
SELECT * FROM gold.sales;

select top 10 * from gold.extSales;
/*
WHAT WAS THE REQUIREMENT TO CREATE AN EXTERNAL TABLE ?
        Views do not store the data, only the skeleton is stored
        External Tables store the data in gold layer of ADLS gen2

*/
