#!/usr/bin/env bash
set -euo pipefail

# Read-only Proxmark3 audit helper.
# Purpose: identify/tag-inspect cards without performing write/clone operations.

PM3_BIN="${PM3_BIN:-pm3}"
PORT="${1:-/dev/ttyACM0}"
OUT_DIR="${2:-./artifacts}"
TS="$(date +%Y%m%d_%H%M%S)"
RUN_DIR="${OUT_DIR}/audit_${TS}"
LOG="${RUN_DIR}/audit.log"

mkdir -p "${RUN_DIR}"

if ! command -v "${PM3_BIN}" >/dev/null 2>&1; then
  echo "[ERROR] Proxmark3 client not found: ${PM3_BIN}" >&2
  echo "Set PM3_BIN=/path/to/pm3 or add it to PATH." >&2
  exit 1
fi

# Extra guard: block obvious write/clone commands in this script.
BLOCKLIST='(cload|csetuid|restore|wrbl|write|gen3uid|magicwrite|wupc|sim|hf mf csetblk)'

cat > "${RUN_DIR}/commands.pm3" <<'EOF'
hw version
hf search
hf 14a info
hf mf info
hf mf chk
script run hardnested --help
quit
EOF

if grep -Eiq "${BLOCKLIST}" "${RUN_DIR}/commands.pm3"; then
  echo "[ERROR] Unsafe command detected in command set. Aborting." >&2
  exit 1
fi

echo "[INFO] Starting read-only audit on ${PORT}"
echo "[INFO] Output: ${RUN_DIR}"

# Use -c command string to avoid interactive mistakes.
# Commands are read-only identification and key-check attempts.
"${PM3_BIN}" -p "${PORT}" -c "hw version; hf search; hf 14a info; hf mf info; hf mf chk; quit" \
  | tee "${LOG}"

cat > "${RUN_DIR}/SUMMARY.txt" <<EOF
Read-only audit completed.

Files:
- audit.log: full proxmark output
- commands.pm3: command template used for this audit

Notes:
- This script intentionally avoids write/clone operations.
- Use only on cards/systems you own or are authorized to test.
EOF

echo "[OK] Done. See ${RUN_DIR}"
