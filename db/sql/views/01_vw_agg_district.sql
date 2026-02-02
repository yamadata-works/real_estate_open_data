CREATE OR REPLACE VIEW public.vw_agg_district AS
 SELECT district,
    count(*) AS n_transactions,
    percentile_cont(0.25::double precision) WITHIN GROUP (ORDER BY (unit_price_yen_per_sqm::double precision)) AS p25_unit_price_yen_per_sqm,
    percentile_cont(0.50::double precision) WITHIN GROUP (ORDER BY (unit_price_yen_per_sqm::double precision)) AS median_unit_price_yen_per_sqm,
    percentile_cont(0.75::double precision) WITHIN GROUP (ORDER BY (unit_price_yen_per_sqm::double precision)) AS p75_unit_price_yen_per_sqm,
    avg(unit_price_yen_per_sqm) AS avg_unit_price_yen_per_sqm,
    count(*) >= 30 AS is_n30
   FROM mansion_contract
  WHERE district IS NOT NULL AND unit_price_yen_per_sqm IS NOT NULL
  GROUP BY district;
;
