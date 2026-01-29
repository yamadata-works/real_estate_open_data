-- 60_trend_all.sql
-- 全体の㎡単価（中央値）の四半期推移（VIEW）

CREATE OR REPLACE VIEW vw_trend_all AS
SELECT
  mc.deal_term,
  COUNT(*) AS n_transactions,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY mc.unit_price_yen_per_sqm) AS median_unit_price_yen_per_sqm
FROM mansion_contract mc
WHERE mc.deal_term IS NOT NULL
  AND mc.unit_price_yen_per_sqm IS NOT NULL
GROUP BY mc.deal_term
ORDER BY mc.deal_term;
