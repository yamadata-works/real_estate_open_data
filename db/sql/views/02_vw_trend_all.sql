CREATE OR REPLACE VIEW public.vw_trend_all AS
 SELECT deal_term,
    count(*) AS n_transactions,
    percentile_cont(0.5::double precision) WITHIN GROUP (ORDER BY (unit_price_yen_per_sqm::double precision)) AS median_unit_price_yen_per_sqm
   FROM mansion_contract mc
  WHERE deal_term IS NOT NULL AND unit_price_yen_per_sqm IS NOT NULL
  GROUP BY deal_term
  ORDER BY deal_term;
;
