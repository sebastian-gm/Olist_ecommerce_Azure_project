-- external_objects.sql
-- CREATE DATABASE SCOPED CREDENTIAL [ManagedIdentityCred] WITH IDENTITY = 'Managed Identity';
CREATE EXTERNAL DATA SOURCE [olist_ds] WITH (LOCATION='abfss://olistdata@olistecommdatastorage.dfs.core.windows.net/curated', CREDENTIAL=[ManagedIdentityCred]);
CREATE EXTERNAL FILE FORMAT [parquet_ff] WITH (FORMAT_TYPE=PARQUET);
