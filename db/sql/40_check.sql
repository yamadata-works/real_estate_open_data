\set ON_ERROR_STOP on
\pset pager off

-- 1) 件数
SELECT COUNT(*) AS total_rows FROM mansion_contract;

-- 2) 欠損（主要列）
SELECT
  COUNT(*) FILTER (WHERE price_yen IS NULL) AS price_null,
  COUNT(*) FILTER (WHERE area_sqm IS NULL) AS area_null,
  COUNT(*) FILTER (WHERE unit_price_yen_per_sqm IS NULL) AS unit_price_null,
  COUNT(*) FILTER (WHERE deal_term IS NULL) AS deal_term_null
FROM mansion_contract;

-- 3) 価格レンジ
SELECT
  MIN(price_yen) AS min_price,
  MAX(price_yen) AS max_price,
  AVG(price_yen) AS avg_price
FROM mansion_contract
WHERE price_yen IS NOT NULL;

-- 4) ㎡単価レンジ
SELECT
  MIN(unit_price_yen_per_sqm) AS min_unit_price,
  MAX(unit_price_yen_per_sqm) AS max_unit_price,
  AVG(unit_price_yen_per_sqm) AS avg_unit_price
FROM mansion_contract
WHERE unit_price_yen_per_sqm IS NOT NULL;

-- 5) 地区別件数 Top10
SELECT district, COUNT(*) AS n
FROM mansion_contract
GROUP BY district
ORDER BY n DESC
LIMIT 10;
