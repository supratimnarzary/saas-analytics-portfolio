# Retention & Revenue Analysis Brief
**To:** Chief Financial Officer
**From:** Analytics Engineering Team
**Date:** June 2026
**Re:** Customer Retention Crisis & Revenue Concentration Risk

---

## Executive Summary

Analysis of 99,441 orders and 96,478 customers across the Olist 
marketplace reveals a critical retention problem: 97% of customers 
place exactly one order and never return. This single pattern is the 
largest suppressant of lifetime value in the business. At an average 
order value of $160.99, converting just 5% of one-time buyers into 
repeat customers would generate approximately $775,000 in incremental 
revenue without acquiring a single new customer.

---

## Key Findings

### 1. One-Time Customer Dominance
97% of customers (96,478 out of 99,441) place exactly one order and 
never return. The average lifetime value sits at $159.86 — effectively 
a single transaction value. There is no meaningful repeat customer 
segment in the current data, meaning the business is entirely dependent 
on new customer acquisition to grow revenue. This is the highest-risk 
growth model possible: every month of revenue requires a full month of 
new acquisition spend.

**Data source:** `dim_customers.customer_segment`, 
`dim_customers.lifetime_value`

### 2. Revenue Geographic Concentration
Three states — SP, RJ, and MG — account for 62.5% of total revenue:

| State | Revenue | Share |
|-------|---------|-------|
| SP | $5,770,266 | 37.4% |
| RJ | $2,055,690 | 13.3% |
| MG | $1,819,278 | 11.8% |

São Paulo alone drives more than one third of all revenue. A regional 
economic shock, a competitor entering the SP market, or a logistics 
disruption in the southeast would immediately threaten the majority 
of the revenue base.

**Data source:** `fact_orders` partitioned by `customer_state`

### 3. Delivery Performance is a Retention Lever
91.9% of orders are delivered on time, with an average actual delivery 
time of 12.5 days against an estimated 24.4 days. This is a hidden 
strength; customers are receiving orders nearly twice as fast as 
promised. This positive surprise is an underutilised retention tool 
that is currently not being communicated or leveraged in post-purchase 
messaging.

**Data source:** `fact_orders.delivered_on_time`, 
`fact_orders.days_to_deliver`

---

## Recommendations

### Immediate Actions (0–30 days)

1. **Launch a post-purchase retention sequence.** Every delivered 
   order should trigger an automated email at day 7 and day 30 with 
   personalised product recommendations based on the purchased 
   category. Even a 2% conversion to repeat purchase converts ~1,929 
   customers and generates ~$310,000 in revenue at current AOV.

2. **Communicate delivery speed proactively.** Customers are receiving 
   orders 11.9 days earlier than estimated on average. A shipping 
   confirmation email highlighting this — "Your order is arriving 
   faster than expected" — creates a positive brand moment that 
   directly increases repurchase intent.

### Medium-Term Actions (30–90 days)

3. **Diversify revenue beyond SP.** SP at 37.4% of revenue is a 
   concentration risk. Targeted marketing investment in MG, RS, and PR 
   — which show organic demand without proportional marketing spend — 
   would reduce geographic dependency while expanding the total 
   addressable customer base.

4. **Introduce a loyalty programme.** The current data shows no repeat 
   customer infrastructure. A simple points-based programme with a 
   discount on the second order would directly attack the 97% one-time 
   buyer problem. Industry benchmarks suggest a well-executed loyalty 
   programme converts 8–12% of one-time buyers into repeat customers 
   within 6 months.

---

## Methodology

All findings derived from the `saas_analytics` dbt data mart built on 
the Olist Brazilian E-Commerce public dataset (99,441 orders, 2016–2018). 
The data model comprises 13 dbt models across staging, intermediate, and 
mart layers, validated by 32 automated data quality tests covering 
uniqueness, nullability, referential integrity, and custom business logic.

Full model lineage and test results available at:
[GitHub Repository](https://github.com/supratimnarzary/saas-analytics-portfolio)