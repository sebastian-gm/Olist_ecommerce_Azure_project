from pyspark.sql import functions as F
def trim_all_strings(df):
    return df.select([F.trim(F.col(c)).alias(c) if t == "string" else F.col(c) for c,t in df.dtypes])