\set ON_ERROR_STOP on
\pset pager off

DROP TABLE IF EXISTS mansion_contract;

CREATE TABLE mansion_contract AS
SELECT
  NULLIF("市区町村コード",'') AS city_code,
  NULLIF("都道府県名",'')     AS pref,
  NULLIF("市区町村名",'')     AS city,
  NULLIF("地区名",'')         AS district,
  NULLIF("最寄駅：名称",'')   AS station,

  -- 数字だけ抽出して int
  NULLIF(regexp_replace(COALESCE("最寄駅：距離（分）",''), '[^0-9]', '', 'g'),'')::int AS station_min,

  -- カンマ等を除去して bigint
  NULLIF(regexp_replace(COALESCE("取引価格（総額）",''), '[^0-9]', '', 'g'),'')::bigint AS price_yen,

  NULLIF("間取り",'') AS layout,

  -- 数字と小数点以外を除去して numeric
  NULLIF(regexp_replace(COALESCE("面積（㎡）",''), '[^0-9\.]', '', 'g'),'')::numeric AS area_sqm,

  -- 4桁年が取れれば int
  CASE
    WHEN "建築年" ~ '[0-9]{4}' THEN substring("建築年" from '([0-9]{4})')::int
    ELSE NULL
  END AS built_year,

  NULLIF("建物の構造",'') AS structure,
  NULLIF("用途",'')       AS usage,
  NULLIF("取引時期",'')   AS deal_term,

  -- 参考として残す（必要なければ後で消してOK）
  NULLIF("価格情報区分",'') AS price_info_type,
  NULLIF("種類",'')         AS kind
FROM mansion_contract_raw;

ANALYZE mansion_contract;

SELECT COUNT(*) AS row_count FROM mansion_contract;
