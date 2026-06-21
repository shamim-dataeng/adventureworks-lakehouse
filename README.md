# AdventureWorks Lakehouse

An end-to-end data engineering project built on Microsoft Azure, implementing a **medallion (Bronze → Silver → Gold) architecture** to ingest, store, transform, and warehouse the Microsoft AdventureWorks dataset, a fictional bicycle manufacturing company's operational data.

---

## 📐 Architecture

![Architecture Diagram](./assets/architecture-diagram.png)


---

## 🛠️ Tech Stack

 Layer | Service | Purpose |
---|---|---|
Orchestration & Ingestion | Azure Data Factory (ADF) | Bronze layer ingestion pipelines |
Storage | Azure Data Lake Storage Gen2 (ADLS Gen2) | Centralized, hierarchical data lake |
Integration | Azure Databricks ↔ ADLS Gen2 Connector | Secure, scalable access to lake storage from compute |
Transformation | Azure Databricks (PySpark) | Cleaning, modeling, and curating data |
Warehousing | Azure Synapse Analytics (Serverless SQL database to add dwh capabilities) | Serving layer for analytics and BI |

---

## 📊 About the Dataset

This project uses the **Microsoft AdventureWorks** dataset, a widely-used sample dataset representing the operations of a fictional bicycle manufacturer. It spans **10 source files** covering core business domains, including:

- Calendar
- Customers
- Product Categories and Subcategories
- Products
- Returns
- Sales from 2015 to 2017
- Territories

These files collectively support analysis across sales performance, customer behavior, product profitability, and regional trends.

---

## 🔄 Pipeline Walkthrough

The pipeline follows a chronological, layer-by-layer flow from raw ingestion to a query-ready lakehouse.

### 1. Bronze Layer Ingestion — Azure Data Factory
Raw AdventureWorks CSV files are ingested as-is into the data lake using dynamic ADF pipelines. ADF handles:
- Source connections to the raw file repository
- Scheduled/triggered pipeline runs
- Copy activities loading all 10 source files into the **Bronze** zone with no transformation, preserving full data lineage and an immutable raw copy

### 2. Data Lake Storage — Azure Data Lake Storage Gen2
ADLS Gen2 serves as the foundation of the lake, organized into zones:
```
/bronze   → raw, unprocessed source files
/silver   → cleaned, validated, conformed data
/gold     → business-level, aggregated, analytics-ready data
```
Hierarchical namespace is enabled to support efficient folder-level operations and fine-grained access control (ACLs).

### 3. Compute-Storage Integration — Azure Databricks Connector
A secure connector (via Unity Catalog external locations) links Azure Databricks to ADLS Gen2, enabling Databricks notebooks to read from and write to all three lake zones directly.

### 4. Transformation — Azure Databricks
Utilizes PySpark within Databricks notebooks, raw Bronze data is progressively refined:
- **Bronze → Silver:** schema enforcement, data type casting, null/duplicate handling, and standardization across the 10 source files
- **Silver → Gold:** business logic applied — joins across sales, data enrichment for customers, products and creation of fact and dimension tables ready for consumption by downstream users

### 5. Data Warehousing Solution — Azure Synapse Analytics
Curated Gold layer views are loaded into a Synapse serverless database, structured as a **star schema** to support fast, BI-ready querying for downstream reporting and analytics tools.

---

## 📁 Repository Structure

```
├── adf/                     
├── assets/
├── data/                      
├── notebooks/
├── synapse/                  
└── README.md
```
---

## 💡 Key Learnings

- Designing and implementing a medallion architecture across distinct Azure services
- Securely integrating compute (Databricks) and storage (ADLS Gen2)
- Building idempotent, reusable ADF pipelines for raw ingestion
- Writing transformation logic in PySpark to handle schema drift and data quality issues

---

## 🚀 Future Enhancements

- Add Azure Data Factory triggers for fully automated, scheduled runs
- Incorporate data quality checks (e.g., Great Expectations) between layers
- Add CI/CD for Databricks notebooks and Synapse scripts

---

## 👤 Author

**Shamim Ahamed S** <br>
[[LinkedIn](https://www.linkedin.com/in/shamim-ahamed-s-2101a5284/)]
