# End-to-End Data Engineering Pipeline on Azure

## Overview
Lightweight, production‑shaped data engineering demo using **Azure Data Factory** for ingestion, **ADLS Gen2** for storage, **Databricks** for ETL with **Delta Lake** (Bronze → Silver → Gold), and **Synapse serverless SQL** for serving.


---

## What it does (at a glance)

- **Ingestion**
  - Batch CSV → **Bronze** (Delta; `orders` partitioned by year/month).
  - Optional **incremental ingestion** with Auto Loader (schema tracking + checkpoints).
- **Transform**
  - **Silver** layer with minimal, practical cleanup (dedupe, trim) and an **explicit schema** for key tables (e.g., `orders`).
- **Publish**
  - **Gold**:
    - `gold.daily_orders`
    - Small **star schema**: `gold.dim_customer`, `gold.dim_product`, `gold.fact_order_items`
- **Serve**
  - **Synapse serverless** via External Data Source + External Table (CETAS-style).
- **Ops touches**
  - ADF pipeline to chain notebooks.
  - Lightweight **DQ metrics** table.
  - Delta **OPTIMIZE / Z-ORDER / VACUUM** examples.
  - Secrets with Databricks Secret Scopes / Key Vault (no hard-coded creds).

---

## 🛠️ Architecture
![Architecture](./docs/architecture_diagram.png)

## Stack
- **Ingestion**: Azure Data Factory (ADF)  
- **Storage**: ADLS Gen2 (`raw`, `curated` containers)  
- **Compute**: Databricks (Spark + Delta Lake)  
- **Serving**: Synapse serverless SQL (External Tables / CETAS)
- **Secrets**: Databricks Secret Scopes / Azure Key Vault

## Project Structure
```
Olist-Ecommerce-Azure-Project/
  adf/
    pipeline_PL_Databricks_Bronze_Silver_Gold.json
    ForEachInput.json
  databricks/
    00_setup.md
    01_bronze_ingest_batch.ipynb # batch CSV → Delta (explicit schema for orders)
    01b_bronze_ingest_autoloader.ipynb # incremental ingestion with Auto Loader
    02_silver_transform.ipynb # dedupe + trim
    02b_upsert_merge.ipynb # Delta MERGE into Silver
    03_gold_marts.ipynb # gold.daily_orders
    03b_gold_star_schema.ipynb # dim_customer, dim_product, fact_order_items
    04_jdbc_export.ipynb # optional MySQL export (secrets)
    04_optional_mongo_export.ipynb # optional Mongo export (secrets)
    05_dq_audit.ipynb # simple DQ metrics (append-only)
    06_delta_maintenance.ipynb # OPTIMIZE / ZORDER / VACUUM
    utils.py
  synapse/
    external_objects.sql
    gold_queries.sql
  data-sample/
    orders_sample.csv
    data-sample/olist_customers_dataset.csv
    olist_geolocation_dataset.csv
    olist_order_items_dataset.csv
    olist_order_payments_dataset.csv
    olist_order_reviews_dataset.csv 
    olist_orders_dataset.csv 
    olist_products_dataset.csv 
    olist_sellers_dataset.csv
    product_category_name_translation.csv
  docs/
    architecture_diagram.png
  .gitignore
  README.md
  requirements.txt
```


## How to run (Databricks)

> Tested on DBR 13.x+ (Spark 3.4+). Paths are passed via widgets.

1. **Set paths** (defaults shown inside notebooks):
   ```python
   raw_inbox    = "abfss://<container>@<storage>.dfs.core.windows.net/inbox"
   raw_base     = "abfss://<container>@<storage>.dfs.core.windows.net/bronze"
   curated_base = "abfss://<container>@<storage>.dfs.core.windows.net/curated"
2. **Bronze**:
    - Batch: run `01_bronze_ingest_batch.ipynb`
    - Incremental (optional): drop new files in `inbox/orders/` and run `01b_bronze_ingest_autoloader.ipynb`

3. **Silver**: run `02_silver_transform.ipynb`

4. **Upsert example** (optional): `02b_upsert_merge.ipynb`

5. **Gold**:

    - `03_gold_marts.ipynb` → `gold.daily_orders`
    - `03b_gold_star_schema.ipynb` → dims + fact

6. **Data quality & maintenance** (optional but useful)

    - `05_dq_audit.ipynb` → writes metrics to `curated/audit/dq_runs`
    - `06_delta_maintenance.ipynb` → **OPTIMIZE / Z-ORDER / VACUUM**

7. **Exports** (optional)

    - `04_jdbc_export.ipynb` (MySQL)
    - `04_optional_mongo_export.ipynb` (MongoDB)

## Minimal Data Quality
- Bronze notebook asserts non‑empty loads.
- Silver notebook ensures **no duplicate `order_id`** and trims string columns.

## Synapse (Serverless) Setup
1. Run `synapse/external_objects.sql`, set your `<storage-account>`, and run to create:
   - `olist_ds` (External Data Source to ADLS Gen2 curated)
   - `parquet_ff` (External File Format)
2. Open `synapse/gold_queries.sql` and run to materialize `ext_gold_daily_orders` using **CETAS**‑style query.

## Orchestration (ADF)
- Import `adf/pipeline_PL_Databricks_Bronze_Silver_Gold.json`.
- Configure your Databricks linked service and schedule if needed.
- The pipeline runs the Bronze → Silver → Gold notebooks with parameters.

## Security & Secrets
- Use **Azure Key Vault** or **Databricks Secret Scopes** for any JDBC user/password.
- Use **Managed Identity** for Synapse to read ADLS Gen2.


