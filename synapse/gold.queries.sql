-- gold_queries.sql
CREATE EXTERNAL TABLE [ext_gold_daily_orders]
WITH (LOCATION='gold/daily_orders', DATA_SOURCE=[olist_ds], FILE_FORMAT=[parquet_ff])
AS
SELECT * FROM OPENROWSET(BULK 'silver/orders/*', DATA_SOURCE='olist_ds', FORMAT='PARQUET') AS s;
