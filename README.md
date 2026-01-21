# 品川区マンション取引データ：相場把握（㎡単価・四半期推移）

品川区のマンション取引データを用いて地区別の㎡単価（中央値）と四半期ごとの推移を可視化し、相場感を把握できるようにまとめました。

- 対象期間：2022Q2〜2025Q2
- 目的：地区別の㎡単価（中央値）と四半期推移を可視化し、相場感を把握する
- 成果物：outputs/figures（図）・outputs/tables（集計CSV）／再現手順は下部に記載

## 可視化　（Figures）

### 1) 地区別 m²単価（中央値）Top20（n>=30）
![地区別 m²単価（中央値）Top20（n>=30）](outputs/figures/district_rank_top20.png)

### 2) 全体 m²単価（中央値）の四半期推移
![全体 m²単価（中央値）の四半期推移](outputs/figures/trend_all_median.png)

### 3) 上位5地区 m²単価（中央値）の四半期推移
![上位5地区 m²単価（中央値）の四半期推移](outputs/figures/trend_top5_median.png)

## 集計結果（Tables）

- 地区別 ㎡単価（全件）: [price_by_district_all.csv](outputs/tables/price_by_district_all.csv)
- 地区別 ㎡単価（n>=30）: [price_by_district_n30.csv](outputs/tables/price_by_district_n30.csv)
- 四半期推移（全地区）: [trend_all.csv](outputs/tables/trend_all.csv)
- 上位5地区の推移: [trend_top5_district.csv](outputs/tables/trend_top5_district.csv)

## 再現手順

```bash
python -m pip install -r requirements.txt

再現: notebooks/01_eda.ipynb を上から実行すると outputs/ に図表が生成されます。


`pip install -r` は requirements.txt を読み込んでインストールする公式の使い方です。 :contentReference[oaicite:1]{index=1}

---

## 2) requirements.txt は「ファイルの中に入れる」ってこと？
はい。**requirements.txt の中身が本体**です。フォーマットは「1行に1つ」パッケージ名（必要なら `==` でバージョン固定）です。 :contentReference[oaicite:2]{index=2}

---

## A（最短）: いまの環境から requirements.txt を埋める方法
いま notebook が動いてるなら、まずはこれが一番ラクです。

```bash
# プロジェクト直下で
python -m pip freeze > requirements.txt
cat requirements.txt | head

git add requirements.txt
git commit -m "chore: fill requirements.txt"
git push origin main
