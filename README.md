# End-to-End Data Engineering Pipeline on Azure

## 📌 Overview
This project demonstrates the design and implementation of a **modern data engineering pipeline** on **Azure**, showcasing skills in **data ingestion, transformation, orchestration, and visualization**.  

The pipeline ingests raw data from multiple sources (HTTP, GitHub, SQL, MongoDB), processes and transforms it using **Azure Databricks**, stores it in **layered data zones (Bronze, Silver, Gold)** on **Azure Data Lake Storage**, and finally makes it available in **Azure Synapse Analytics** for downstream consumption in **Power BI / Tableau / Fabric**.

This project was developed as a portfolio piece to highlight **data engineering best practices** for handling structured and semi-structured data in the cloud.

---

## 🛠️ Architecture
![Architecture](./Architecture%20Diagram.png)

### Flow
1. **Data Ingestion**  
   - Data sources include:
     - Public datasets via **HTTP / GitHub**
     - Relational data from **SQL tables**
     - Semi-structured data from **MongoDB** (for enrichment)  
   - **Azure Data Factory** orchestrates ingestion into **ADLS Gen2**.

2. **Raw Zone (Bronze Layer)**  
   - Landing zone for raw, unprocessed data.
   - Maintains **data lineage** and ensures traceability.

3. **Cleansed Zone (Silver Layer)**  
   - Data is **transformed, joined, and validated** in **Azure Databricks (Spark)**.  
   - Standardized schemas, deduplication, and enrichment using MongoDB data.

4. **Curated Zone (Gold Layer)**  
   - Business-ready, aggregated tables optimized for analytics.  
   - Data stored in **ADLS Gen2 Gold layer** and made available to **Azure Synapse Analytics**.

5. **Data Warehouse & BI**  
   - **Azure Synapse Analytics** (serverless SQL endpoint) enables BI tools to query curated data.  
   - Connected to **Power BI**, **Tableau**, or **Microsoft Fabric** for visualization.

---

## 🚀 Technologies Used
- **Azure Data Factory** – Orchestration & data ingestion  
- **Azure Data Lake Storage Gen2 (ADLS)** – Layered data lake (Bronze/Silver/Gold)  
- **Azure Databricks (Spark)** – Distributed transformations & enrichment  
- **MongoDB** – External dataset for enrichment  
- **MySQL** – Relational data source  
- **Azure Synapse Analytics** – Data warehouse & SQL analytics layer  
- **Power BI / Tableau / Fabric** – Visualization & reporting  

---

## 📂 Data Layers
- **Bronze Layer** – Raw ingestion (as-is from sources)  
- **Silver Layer** – Cleaned, validated, transformed, and enriched data  
- **Gold Layer** – Aggregated, curated datasets for BI & business consumption  

---

## 🧑‍💻 Skills Demonstrated
- End-to-end **data engineering pipeline design**  
- **Orchestration** with Azure Data Factory  
- **ETL / ELT transformations** with Databricks (Spark)  
- **Data lakehouse architecture** (Bronze/Silver/Gold layers)  
- **SQL + NoSQL integration** (MySQL, MongoDB)  
- **Data warehouse modeling** in Synapse  
- **Visualization integration** with BI tools  
- Exposing curated data via **Synapse Serverless SQL endpoint**

---

## 🔑 Why This Project Matters
This project replicates what real data engineering teams do in production:
- Designing **scalable, cloud-native pipelines**  
- Integrating **multiple storage and processing technologies**  
- Applying **best practices** in layered data architecture and enrichment  
- Delivering **business-ready data** for analytics  

---

## 📌 Next Steps
- Add **CI/CD pipelines** (GitHub Actions / Azure DevOps) for Databricks jobs  
- Implement **data quality checks** with Great Expectations  
- Automate infrastructure setup with **Terraform**  
