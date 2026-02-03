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

#### 上位5地区の四半期推移（中央値）の読み方

* ㎡単価（中央値）で地区ごとの相場トレンドを比較（外れ値の影響が小さい）
* 件数が少ない期はブレやすいので、複数期で傾向を確認する
* 地区間で動きがズレる場合は、駅距離・供給・築年帯などエリア固有要因の仮説につなげる

### 集計結果（Tables）

※ CSV は生成物のため **Gitにはコミットしません**（.gitignore 対象）  
ローカルで `notebooks/01_eda.ipynb`（または `scripts/export_tables.sh`）を実行すると `outputs/tables/` に出力されます。

- 出力先：`outputs/tables/`
- 出力形式：`*.csv`



## 再現手順

```bash
python -m pip install -r requirements.txt
```

notebooks/01_eda.ipynb を上から実行すると outputs/ に図表・集計CSVが生成されます。

## （任意）Docker+PostgreSQLでSQL集計する手順

### 前提
- Docker Desktop が起動している
- `docker compose ps` で `real_estate_pg` が `Up` になっている

### 補足（任意）
- Python 3.11 を想定
- outputs/ が無い場合は実行時に作成されます

　 **注意**
- もし `pip install -r requirements.txt` の行の上にある ```bash を閉じてないと、  
  その下に書いた文章が全部 “コード扱い” になっちゃいます。

`pip install -r` は requirements.txt を読み込んでインストールする公式の使い方です。 

---

## 2) requirements.txt は「ファイルの中に入れる」ってこと？
はい。**requirements.txt の中身が本体**です。フォーマットは「1行に1つ」パッケージ名（必要なら `==` でバージョン固定）です。

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
```

# real_estate_open_data

不動産オープンデータを用いて、**中古マンションの相場把握**を目的とした分析プロジェクトです。  
本リポジトリでは、実務を想定し「データ取得 → 前処理 → EDA → SQL集計 → 可視化」を段階的に進めています。

---

## 目的

- 市区町村別・時系列で **価格水準と分布感** を把握する
- 価格予測や市場分析を行う前段として、  
  **相場の全体像を整理すること**を目的とする

---

## 使用データ

- 不動産オープンデータ（中古マンション取引情報）
- 対象期間：複数年（四半期単位で集計）
- 主な項目：
  - 取引価格
  - 専有面積
  - 市区町村
  - 取引時期（四半期）

※ 個人情報・スクレイピングは行っていません。

---

## ▶実行方法（EDA）

```bash
pip install -r requirements.txt
```

---

## EDA（探索的データ分析）の内容

- ㎡単価を用いた価格水準の比較
- 市区町村別の価格分布・件数確認
- 四半期ごとの価格推移の可視化
- 件数が少なすぎる市区町村を除外した分析（n≥30）

---

## 主な成果物（EDA）

### 図表（PNG）
- `outputs/figures/district_rank_top20.png`  
  → 市区町村別 ㎡単価 上位ランキング  
- `outputs/figures/trend_all_median.png`  
  → 全体の価格推移（中央値）  
- `outputs/figures/trend_top5_median.png`  
  → 上位市区町村の価格推移比較  

### 集計結果（CSV）
- `outputs/tables/price_by_district_all.csv`
- `outputs/tables/price_by_district_n30.csv`
- `outputs/tables/trend_all.csv`
- `outputs/tables/trend_top5_district.csv`

---

## ディレクトリ構成（抜粋）

```text
real_estate_open_data/
├── notebooks/
│   └── 01_eda.ipynb
├── outputs/
│   ├── figures/
│   └── tables/
├── data/
├── README.md
```