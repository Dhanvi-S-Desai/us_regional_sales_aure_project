--Gross margin per unit (already computed) and total margin

SELECT TOP 20
  ProductID,
  SUM(GrossMarginTotal) AS total_gross_margin
FROM analytics.sales_clean
GROUP BY ProductID
ORDER BY total_gross_margin DESC;

######################################

--Margin erosion due to discounts
--Compare margin with discount vs without discount

SELECT
  WarehouseCode,
  CAST(AVG(UnitPrice - UnitCost) AS decimal(18,2)) AS avg_margin_no_discount,
  CAST(AVG((UnitPrice * (1 - DiscountApplied)) - UnitCost) AS decimal(18,2)) AS avg_margin_after_discount,
  CAST(AVG((UnitPrice - UnitCost) - ((UnitPrice * (1 - DiscountApplied)) - UnitCost)) AS decimal(18,2)) AS avg_margin_eroded_per_unit
FROM analytics.sales_clean
GROUP BY WarehouseCode
ORDER BY avg_margin_eroded_per_unit DESC;

######################################

--Margin by warehouse / channel

SELECT
  WarehouseCode,
  SalesChannel,
  SUM(GrossMarginTotal) AS total_gross_margin,
  SUM(UnitPriceAfterDiscount * OrderQuantity) AS total_revenue_after_discount,
  CASE 
    WHEN SUM(UnitPriceAfterDiscount * OrderQuantity) = 0 THEN NULL
    ELSE SUM(GrossMarginTotal) / SUM(UnitPriceAfterDiscount * OrderQuantity)
  END AS margin_rate
FROM analytics.sales_clean
GROUP BY WarehouseCode, SalesChannel
ORDER BY total_gross_margin DESC;

