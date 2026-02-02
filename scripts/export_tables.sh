#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"

CONTAINER="${1:-real_estate_pg}"
DB="${2:-real_estate}"
USER="${3:-yama}"

OUTDIR="outputs/tables"
mkdir -p "$OUTDIR"

docker exec -i "$CONTAINER" psql -U "$USER" -d "$DB" -v ON_ERROR_STOP=1 \
  -c "COPY (SELECT * FROM vw_trend_all ORDER BY deal_term) TO STDOUT WITH (FORMAT csv, HEADER true)" \
  > "$OUTDIR/trend_all.csv"

docker exec -i "$CONTAINER" psql -U "$USER" -d "$DB" -v ON_ERROR_STOP=1 \
  -c "COPY (SELECT * FROM vw_trend_top5_district ORDER BY deal_term, district) TO STDOUT WITH (FORMAT csv, HEADER true)" \
  > "$OUTDIR/trend_top5_district.csv"

echo "Wrote:"
echo " - $OUTDIR/trend_all.csv"
echo " - $OUTDIR/trend_top5_district.csv"
