SELECT 
  COUNT(*) AS row_count,
  COUNT(DISTINCT OrderNumber) AS orders,
  COUNT(DISTINCT _ProductID) AS products,
  COUNT(DISTINCT WarehouseCode) AS warehouses
FROM staging.us_regional_sales;
#############################################
CREATE SCHEMA analytics;
GO
CREATE SCHEMA mart;
GO
#############################################

CREATE TABLE analytics.sales_clean (
  OrderNumber        NVARCHAR(50),
  SalesChannel       NVARCHAR(100),
  WarehouseCode      NVARCHAR(50),
  ProcuredDate       DATE,
  OrderDate          DATE,
  ShipDate           DATE,
  DeliveryDate       DATE,
  CurrencyCode       NVARCHAR(10),
  SalesTeamID        INT,
  CustomerID         INT,
  StoreID            INT,
  ProductID          INT,
  OrderQuantity      INT,
  DiscountApplied    DECIMAL(6,4),
  UnitCost           DECIMAL(18,2),
  UnitPrice          DECIMAL(18,2),

  -- derived fields
  UnitPriceAfterDiscount AS CAST(UnitPrice * (1 - DiscountApplied) AS DECIMAL(18,2)) PERSISTED,
  GrossMarginPerUnit     AS CAST((UnitPrice * (1 - DiscountApplied)) - UnitCost AS DECIMAL(18,2)) PERSISTED,
  GrossMarginTotal       AS CAST((((UnitPrice * (1 - DiscountApplied)) - UnitCost) * OrderQuantity) AS DECIMAL(18,2)) PERSISTED
);
GO
#############################################
INSERT INTO analytics.sales_clean (
  OrderNumber, SalesChannel, WarehouseCode,
  ProcuredDate, OrderDate, ShipDate, DeliveryDate,
  CurrencyCode, SalesTeamID, CustomerID, StoreID, ProductID,
  OrderQuantity, DiscountApplied, UnitCost, UnitPrice
)
SELECT
  CAST([OrderNumber] AS NVARCHAR(50)) AS OrderNumber,
  CAST([Sales Channel] AS NVARCHAR(100)) AS SalesChannel,
  CAST([WarehouseCode] AS NVARCHAR(50)) AS WarehouseCode,

  TRY_CONVERT(date, [ProcuredDate], 103) AS ProcuredDate,
  TRY_CONVERT(date, [OrderDate], 103)    AS OrderDate,
  TRY_CONVERT(date, [ShipDate], 103)     AS ShipDate,
  TRY_CONVERT(date, [DeliveryDate], 103) AS DeliveryDate,

  CAST([CurrencyCode] AS NVARCHAR(10)) AS CurrencyCode,

  TRY_CONVERT(int, [_SalesTeamID]) AS SalesTeamID,
  TRY_CONVERT(int, [_CustomerID])  AS CustomerID,
  TRY_CONVERT(int, [_StoreID])     AS StoreID,
  TRY_CONVERT(int, [_ProductID])   AS ProductID,

  TRY_CONVERT(int, [Order Quantity]) AS OrderQuantity,
  TRY_CONVERT(decimal(6,4), [Discount Applied]) AS DiscountApplied,

  TRY_CONVERT(decimal(18,2),
    REPLACE(REPLACE(REPLACE([Unit Cost], '$',''), ',',''), ' ', '')
  ) AS UnitCost,

  TRY_CONVERT(decimal(18,2),
    REPLACE(REPLACE(REPLACE([Unit Price], '$',''), ',',''), ' ', '')
  ) AS UnitPrice

FROM staging.us_regional_sales;
GO

#############################################
SELECT COUNT(*) AS clean_rows FROM analytics.sales_clean;

SELECT TOP 5 *
FROM analytics.sales_clean
ORDER BY OrderDate DESC;




