\set ON_ERROR_STOP on
\pset pager off

ALTER TABLE mansion_contract
  ADD COLUMN IF NOT EXISTS unit_price_yen_per_sqm numeric;

UPDATE mansion_contract
SET unit_price_yen_per_sqm =
  CASE
    WHEN price_yen IS NULL OR area_sqm IS NULL OR area_sqm = 0 THEN NULL
    ELSE (price_yen::numeric / area_sqm)
  END;

-- check
SELECT
  district, price_yen, area_sqm,
  ROUND(unit_price_yen_per_sqm) AS unit_price_rounded
FROM mansion_contract
WHERE unit_price_yen_per_sqm IS NOT NULL
LIMIT 10;
