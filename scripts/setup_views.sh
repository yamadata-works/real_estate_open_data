set -euo pipefail
ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"
CONTAINER="${1:-real_estate_pg}"
DB="${2:-real_estate}"
USER="${3:-yama}"

for f in db/sql/views/*.sql; do
  echo "Applying: $f"
  docker exec -i "$CONTAINER" psql -U "$USER" -d "$DB" -v ON_ERROR_STOP=1 < "$f"
done
echo "Done."
