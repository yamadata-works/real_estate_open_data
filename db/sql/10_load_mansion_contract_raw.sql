\set ON_ERROR_STOP on
\pset pager off

-- raw（文字列のまま）で取り込む
DROP TABLE IF EXISTS mansion_contract_raw;

CREATE TABLE mansion_contract_raw (
  "種類" text,
  "価格情報区分" text,
  "市区町村コード" text,
  "都道府県名" text,
  "市区町村名" text,
  "地区名" text,
  "最寄駅：名称" text,
  "最寄駅：距離（分）" text,
  "取引価格（総額）" text,
  "間取り" text,
  "面積（㎡）" text,
  "建築年" text,
  "建物の構造" text,
  "用途" text,
  "今後の利用目的" text,
  "都市計画" text,
  "建ぺい率（％）" text,
  "容積率（％）" text,
  "取引時期" text,
  "改装" text,
  "取引の事情等" text
);

-- ★UTF-8 + LF に直した方を使う（_utf8_lf.csv）
\copy mansion_contract_raw FROM '/work/data/processed/reinfolib/shinagawa_mansion_contract_2022Q2-2025Q2_utf8_lf.csv' WITH (FORMAT csv, HEADER true, QUOTE '"', ESCAPE '"');

-- check
SELECT COUNT(*) AS row_count FROM mansion_contract_raw;
