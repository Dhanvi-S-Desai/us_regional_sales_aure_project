# Azure US Regional Sales Analytics Pipeline

This project implements an end-to-end Azure-based analytics pipeline to
derive supply chain, purchasing, and margin insights from transactional
sales data.

## Architecture
Raw CSV data is ingested using Azure Data Factory via HTTP, loaded into
Azure SQL staging tables, transformed into an analytics layer, and queried
for business insights.

---


## Key Findings & Business Insights

### Supply Chain Efficiency
- Procurement is the dominant bottleneck: procure-to-ship lead times are extremely long (~125–128 days) across all warehouses, indicating upstream supplier or purchasing-cycle delays.
- Downstream execution is strong: ship-to-delivery times are short and stable (~4–5 days), showing that warehousing and outbound logistics are functioning efficiently.
- Customer impact is concentrated: late delivery rates are moderate (13–18%) and vary by warehouse, with WARE-MKL1006 and WARE-PUJ1005 posing the highest service risk.

**Insight:** End-to-end supply chain performance is constrained by procurement, not delivery execution; upstream fixes will unlock the largest gains.


### Inventory & Purchasing Signals
- Fragmented purchasing behavior is widespread: high order frequency combined with low units per order suggests reactive replenishment rather than planned bulk procurement.
- Demand volatility is high for several products (CV ≈ 0.7–0.9), increasing planning risk and the likelihood of stockouts or excess inventory.
- Small-order dominance (≈65–70% of orders for some products) further amplifies procurement load and lead times.

**Insight:** Inventory inefficiency is driven by the interaction of demand volatility and fragmented purchasing, reinforcing long procurement delays.


### Cost & Margin Analytics
- Gross margin contribution is concentrated but broad-based: while one product dominates, margin risk is spread across many SKUs rather than a single dependency.
- Discounting is the primary source of margin leakage: discounts erode approximately 250–275 units of margin per unit across all warehouses.
- Channel profitability differs by metric: Wholesale/Distributor channels show higher margin rates, but In-Store and Online channels generate the majority of total gross margin due to volume.

**Insight:** Profitability is driven by high-volume channels, while improving discount discipline represents the largest immediate opportunity for margin improvement.


---


## Technologies
- Azure Data Factory
- Azure SQL Database
- Managed Identity authentication
- SQL-based transformations

## Repository Structure
- data/: raw source data
- sql/: schema, transformations, analytics queries
- decisions/: architectural and analytical decisions
- screenshots/: pipeline execution proof

## Notes
Credentials and subscription-specific details are excluded intentionally.
