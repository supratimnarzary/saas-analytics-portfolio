# SaaS Analytics Portfolio Project

End-to-end analytics engineering project modelling 99,441 e-commerce 
orders across a Brazilian marketplace, built to demonstrate production-grade 
data engineering practices.

## Business Problem
97% of customers place exactly one order and never return. This project 
builds the data infrastructure to identify, quantify, and act on this 
retention crisis.

## Tech Stack
| Layer | Tool |
|-------|------|
| Warehouse | Snowflake |
| Transformation | dbt Core 1.11 |
| Testing | dbt tests (32 passing) |
| CI/CD | GitHub Actions |
| Visualization | Looker Studio |

## Data Architecture
### Models Built
**Staging:** stg_orders, stg_customers, stg_order_items, 
stg_order_payments, stg_products, stg_sellers

**Intermediate:** int_orders_enriched, int_order_items_enriched, 
int_monthly_orders

**Marts:** fact_orders, fact_monthly_revenue, dim_customers, dim_products

## Data Quality
32 automated tests covering:
- Primary key uniqueness and nullability
- Referential integrity across models
- Custom business logic (no negative revenue, valid delivery dates)

## Key Findings
- **97%** of 96,478 customers are one-time buyers — avg LTV of $159.86
- **SP, RJ, MG** account for 62.5% of total revenue — concentration risk
- **91.9%** of orders delivered on time, averaging 12.5 days vs 
  24.4 days estimated — an underutilised retention lever

## Dashboard
[View Live Dashboard](https://datastudio.google.com/reporting/ceb194da-6054-4219-94f8-79302cb447ce)

## Analytics Brief
See [`/analytics_briefs/retention_analysis_brief.md`](analytics_briefs/retention_analysis_brief.md) 
for executive findings and retention recommendations derived from 
this data model.

## Author
Supratim Narzary — [GitHub](https://github.com/supratimnarzary)