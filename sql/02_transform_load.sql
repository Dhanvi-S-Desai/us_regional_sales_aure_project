INSERT INTO analytics.sales_clean (
  OrderNumber, SalesChannel, WarehouseCode,
  ProcuredDate, OrderDate, ShipDate, DeliveryDate,
  CurrencyCode, SalesTeamID, CustomerID, StoreID, ProductID,
  OrderQuantity, DiscountApplied, UnitCost, UnitPrice
)
SELECT
  CAST(OrderNumber AS NVARCHAR(50)),
  CAST(SalesChannel AS NVARCHAR(100)),
  CAST(WarehouseCode AS NVARCHAR(50)),

  TRY_CONVERT(date, ProcuredDate),
  TRY_CONVERT(date, OrderDate),
  TRY_CONVERT(date, ShipDate),
  TRY_CONVERT(date, DeliveryDate),

  CAST(CurrencyCode AS NVARCHAR(10)),
  TRY_CONVERT(int, SalesTeamID),
  TRY_CONVERT(int, CustomerID),
  TRY_CONVERT(int, StoreID),
  TRY_CONVERT(int, ProductID),

  TRY_CONVERT(int, OrderQuantity),
  TRY_CONVERT(decimal(6,4), DiscountApplied),
  TRY_CONVERT(decimal(18,2), UnitCost),
  TRY_CONVERT(decimal(18,2), UnitPrice)

FROM staging.us_regional_sales;
GO



############################


SELECT COUNT(*) AS clean_rows
FROM analytics.sales_clean;

SELECT TOP 5 *
FROM analytics.sales_clean
ORDER BY OrderDate DESC;
