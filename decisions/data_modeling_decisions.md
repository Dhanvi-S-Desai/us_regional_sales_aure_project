# Data Modeling Decisions

## Staging Layer
The staging schema mirrors raw source data and is treated as immutable.

## Analytics Layer
The analytics schema contains cleaned, typed, and derived fields optimized
for analytical queries.

## Derived Metrics
Margin and discounted price metrics are persisted to ensure consistency
across downstream queries.
