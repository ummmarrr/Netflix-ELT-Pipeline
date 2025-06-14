# Netflix-ELT-Pipeline

## 🔍 Project Overview
This project demonstrates a modern **ELT (Extract, Load, Transform)** pipeline using Netflix content data. We leverage SQL Server as our transformation engine after initial raw data loading - a paradigm shift that maximizes modern database capabilities.

**Key Distinction:**  
✅ **ELT Approach:**  
Extract → **Load raw data** → Transform in-database  
🚫 **Traditional ETL:**  
Extract → Transform → Load processed data


## ⚡ Why This Project Matters
- Implements **real-world ELT pattern** used by data engineering teams
- Processes **8,800+ Netflix titles** with complex relationships
- Solves practical business questions through pure SQL transformations

## 🚀 ELT Pipeline Architecture

### 1️⃣ Extract Phase
- Source: Netflix movies/TV shows dataset (https://www.kaggle.com/datasets/umarrr/netflix-dataset-for-data-analysis)
- Method: Python-powered data extraction

### 2️⃣ Load Phase
- Target: Microsoft SQL Server
- Schema optimization:
  - `NVARCHAR` for international characters
  - Precision-length columns (no MAX types)
  - Primary key enforcement
  - Data type validation

### 3️⃣ Transform Phase (Pure SQL)
| Transformation          | Technique Used                  |
|-------------------------|---------------------------------|
| Duplicate Handling      | Window functions + CTEs         |
| Data Normalization      | STRING_SPLIT + CROSS APPLY      |
| Missing Value Imputation | Director-Country mapping logic |
| Type Conversion         | CAST/CONVERT with error handling|
| Relationship Modeling   | Star schema implementation     |

## 📊 Analytical Insights
We answer key business questions through SQL-powered analysis:
1. **Hybrid Directors**: Who produces both movies AND TV shows?
2. **Comedy Hotspots**: Which country dominates comedy content?
3. **Annual Champions**: Top director by added-year volume
4. **Genre Runtime**: Average duration by content category
5. **Genre-Blenders**: Directors mastering horror AND comedy

## 🛠️ Technical Stack
- **Extraction**: Python (Pandas)
- **Storage**: SQL Server
- **Transformation**: T-SQL
- **Analysis**: SQL Window Functions

