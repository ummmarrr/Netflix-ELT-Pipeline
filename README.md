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
| Relationship Modeling   | Star schema implementation      |

#### Before Transformation
![original_table](https://github.com/user-attachments/assets/0a7183ca-64b1-4756-9afe-7f41bf1edcd2)

#### After Transformation
![tranformed_table](https://github.com/user-attachments/assets/a35c0606-bb5f-4f1b-a8b1-9aff0b1a0dd7)

## 📊 Analytical Insights
We answer key business questions through SQL-powered analysis:
1. **Hybrid Directors**: Who produces both movies AND TV shows?
   ![Q1](https://github.com/user-attachments/assets/db60429b-28c0-44d7-bf72-43d0e5182598)

2. **Comedy Hotspots**: Which country dominates comedy content?
   ![Q2](https://github.com/user-attachments/assets/aa7ff5bd-00c3-444b-acca-83fcab88e90b)

5. **Annual Champions**: Top director by added-year volume
    ![Q3](https://github.com/user-attachments/assets/cffcd9bc-742f-47f2-aa0b-63b7a15e0e5e)
    
6. **Genre Runtime**: Average duration by content category
    ![Q4](https://github.com/user-attachments/assets/ecd2e8a7-ab80-4d0c-bfc2-5cd59ec16ea3)

7. **Genre-Blenders**: Directors mastering horror AND comedy
    ![Q5](https://github.com/user-attachments/assets/4ec113bb-f6dd-44e9-81da-1949766742e6)


## 🛠️ Technical Stack
- **Extraction**: Python (Pandas)
- **Storage**: SQL Server
- **Transformation**: SQL

