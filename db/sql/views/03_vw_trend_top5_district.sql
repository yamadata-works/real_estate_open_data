CREATE OR REPLACE VIEW public.vw_trend_top5_district AS
 WITH top5 AS (
         SELECT vw_agg_district.district
           FROM vw_agg_district
          WHERE vw_agg_district.is_n30 = true
          ORDER BY vw_agg_district.median_unit_price_yen_per_sqm DESC
         LIMIT 5
        )
 SELECT mc.deal_term,
    mc.district,
    count(*) AS n_transactions,
    percentile_cont(0.5::double precision) WITHIN GROUP (ORDER BY (mc.unit_price_yen_per_sqm::double precision)) AS median_unit_price_yen_per_sqm
   FROM mansion_contract mc
     JOIN top5 t ON t.district = mc.district
  WHERE mc.deal_term IS NOT NULL AND mc.unit_price_yen_per_sqm IS NOT NULL
  GROUP BY mc.deal_term, mc.district
  ORDER BY mc.deal_term, mc.district;
;
