# E-Commerce SQL Analytics Pipeline

## Business Problem
A Brazilian e-commerce marketplace needs deep visibility into
order performance, seller quality, delivery efficiency, and
customer retention — across 100,000+ orders and 8 data tables.

## What Makes This Project Different
Unlike single-table analysis, this project works with a real
**8-table relational schema** — the same complexity you encounter
in production databases at real companies.

## Dataset
- Source: Olist Brazilian E-Commerce (Kaggle)
- Size: 100K+ orders | 8 CSV files | 2016–2018
- Link: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

## Tools & Techniques
| Tool/Technique | Purpose |
|---|---|
| SQL Server | 9-table relational database |
| CTEs (WITH clause) | Readable multi-step queries |
| Window functions (RANK, LAG) | Ranking and trend analysis |
| SQL Views | Reusable reporting layer |
| Stored Procedures | Parameterised state reports |
| Python + pyodbc | Live DB connection for analysis |
| pandas + seaborn | Visualisation and EDA |

## Key Findings
1. Revenue peaked Nov 2017 — Black Friday effect (3x normal volume)
2. 92%+ of orders delivered on time
3. Repeat purchase rate: ~3% — major opportunity for loyalty programmes
4. SP state accounts for 40%+ of all orders and sellers
5. Seller quality varies dramatically — top sellers earn 10x bottom sellers

## SQL Techniques Demonstrated
- Multi-table JOINs (up to 5 tables in one query)
- CTEs (chained, multi-step)
- Window functions (RANK, DENSE_RANK)
- Cohort retention analysis
- Order funnel analysis
- Stored procedures with parameters
- SQL Views as reporting layer

## Project Structure
```
ecommerce-sql-analytics/
├── data/raw/           ← 9 Olist CSV files
├── data/processed/     ← cleaned outputs
├── notebooks/          ← Python analysis notebook
├── sql/
│   ├── queries/        ← 8 analysis query files
│   ├── views/          ← 2 reusable views
│   └── stored_procs/   ← parameterised procedures
└── dashboards/
    └── screenshots/    ← all chart exports
```
