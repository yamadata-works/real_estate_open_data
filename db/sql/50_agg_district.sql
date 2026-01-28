\pset pager off

DROP TABLE IF EXISTS agg_district;

CREATE TABLE agg_district AS
SELECT
  district,
  COUNT(*) AS n,

  -- ㎡単価（円/㎡）
  ROUND( (percentile_cont(0.5) WITHIN GROUP (ORDER BY unit_price_yen_per_sqm))::numeric )::bigint
    AS median_unit_price_yen_per_sqm,
  ROUND(AVG(unit_price_yen_per_sqm))::bigint AS avg_unit_price_yen_per_sqm,
  ROUND(MIN(unit_price_yen_per_sqm))::bigint AS min_unit_price_yen_per_sqm,
  ROUND(MAX(unit_price_yen_per_sqm))::bigint AS max_unit_price_yen_per_sqm,

  -- 価格（円）
  ROUND( (percentile_cont(0.5) WITHIN GROUP (ORDER BY price_yen))::numeric )::bigint
    AS median_price_yen,
  ROUND(AVG(price_yen))::bigint AS avg_price_yen,

  -- 面積（㎡）
  ROUND( (percentile_cont(0.5) WITHIN GROUP (ORDER BY area_sqm))::numeric, 2 )
    AS median_area_sqm,
  ROUND(AVG(area_sqm), 2) AS avg_area_sqm

FROM mansion_contract
WHERE district IS NOT NULL
  AND unit_price_yen_per_sqm IS NOT NULL
  AND price_yen IS NOT NULL
  AND area_sqm IS NOT NULL
GROUP BY district
ORDER BY n DESC, median_unit_price_yen_per_sqm DESC;

-- 表示チェック（上位20）
SELECT district, n, median_unit_price_yen_per_sqm, avg_unit_price_yen_per_sqm
FROM agg_district
ORDER BY median_unit_price_yen_per_sqm DESC
LIMIT 20;
