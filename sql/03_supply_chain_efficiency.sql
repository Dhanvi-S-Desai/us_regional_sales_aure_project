SELECT
  WarehouseCode,
  AVG(CAST(DATEDIFF(day, ProcuredDate, ShipDate) AS float)) AS avg_procure_to_ship_days
FROM analytics.sales_clean
WHERE ProcuredDate IS NOT NULL AND ShipDate IS NOT NULL
GROUP BY WarehouseCode
ORDER BY avg_procure_to_ship_days DESC;

##################################
SELECT
  WarehouseCode,
  AVG(CAST(DATEDIFF(day, ShipDate, DeliveryDate) AS float)) AS avg_ship_to_delivery_days
FROM analytics.sales_clean
WHERE ShipDate IS NOT NULL AND DeliveryDate IS NOT NULL
GROUP BY WarehouseCode
ORDER BY avg_ship_to_delivery_days DESC;

##################################
-- Late defined as ship_to_delivery_days > 7 (no promised date in dataset)

WITH x AS (
  SELECT
    WarehouseCode,
    DATEDIFF(day, ShipDate, DeliveryDate) AS ship_to_delivery_days
  FROM analytics.sales_clean
  WHERE ShipDate IS NOT NULL AND DeliveryDate IS NOT NULL
)
SELECT
  WarehouseCode,
  COUNT(*) AS shipments,
  SUM(CASE WHEN ship_to_delivery_days > 7 THEN 1 ELSE 0 END) AS late_shipments,
  CAST(1.0 * SUM(CASE WHEN ship_to_delivery_days > 7 THEN 1 ELSE 0 END) / COUNT(*) AS decimal(6,4)) AS late_rate
FROM x
GROUP BY WarehouseCode
ORDER BY late_rate DESC;
