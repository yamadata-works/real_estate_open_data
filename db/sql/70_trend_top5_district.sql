CREATE OR REPLACE VIEW vw_trend_top5_district AS
WITH top5 AS (
  SELECT district
  FROM vw_agg_district
  WHERE is_n30 = true
  ORDER BY median_unit_price_yen_per_sqm DESC
  LIMIT 5
)
SELECT
  mc.deal_term,
  mc.district,
  COUNT(*) AS n_transactions,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY mc.unit_price_yen_per_sqm) AS median_unit_price_yen_per_sqm
FROM mansion_contract mc
JOIN top5 t ON t.district = mc.district
WHERE mc.deal_term IS NOT NULL
  AND mc.unit_price_yen_per_sqm IS NOT NULL
GROUP BY mc.deal_term, mc.district
ORDER BY mc.deal_term, mc.district;
