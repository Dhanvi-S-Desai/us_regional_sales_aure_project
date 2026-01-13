# Azure US Regional Sales Analytics Pipeline

This project implements an end-to-end Azure-based analytics pipeline to
derive supply chain, purchasing, and margin insights from transactional
sales data.

## Architecture
Raw CSV data is ingested using Azure Data Factory via HTTP, loaded into
Azure SQL staging tables, transformed into an analytics layer, and queried
for business insights.

## Key Insights
- Supply chain lead times by warehouse
- Late delivery rates
- Inventory demand volatility
- Purchasing behavior patterns
- Margin erosion due to discounts

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
