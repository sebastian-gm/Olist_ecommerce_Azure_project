# Databricks Setup (Widgets & Secrets)

Use these widgets at the top of each notebook so paths are configurable:

```python
dbutils.widgets.text("raw_base", "abfss://raw@<storage-account>.dfs.core.windows.net/olist")
dbutils.widgets.text("curated_base", "abfss://curated@<storage-account>.dfs.core.windows.net/olist")

RAW = dbutils.widgets.get("raw_base").rstrip("/")
CUR = dbutils.widgets.get("curated_base").rstrip("/")
```

**Secrets (Databricks)**  
Create a Secret Scope (or integrate with Azure Key Vault) and store any JDBC creds there:
- `mysql_user`
- `mysql_pwd`

In notebooks:
```python
user = dbutils.secrets.get("scope", "mysql_user")
pwd  = dbutils.secrets.get("scope", "mysql_pwd")
```

**Cluster Runtime**  
- Databricks Runtime 13.x or later (Spark 3.4+).  
- Enable Delta Lake (default).

**Storage**  
Grant the workspace's managed identity access to ADLS Gen2 containers `raw` and `curated`.
