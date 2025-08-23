# Databricks Setup
Widgets:
```python
dbutils.widgets.text("raw_inbox",  "abfss://olistdata@olistecommdatastorage.dfs.core.windows.net/inbox")
dbutils.widgets.text("raw_base",   "abfss://olistdata@olistecommdatastorage.dfs.core.windows.net/bronze")
dbutils.widgets.text("curated_base","abfss://olistdata@olistecommdatastorage.dfs.core.windows.net/curated")
RAW_INBOX = dbutils.widgets.get("raw_inbox").rstrip("/")
RAW       = dbutils.widgets.get("raw_base").rstrip("/")
CUR       = dbutils.widgets.get("curated_base").rstrip("/")
```
