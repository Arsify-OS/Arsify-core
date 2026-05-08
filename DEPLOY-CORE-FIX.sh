#!/bin/bash
set -uo pipefail
PDIR="/root/upshalter-scripts/python"
SDIR="/root/upshalter-scripts"
BASE="$(cd $(dirname $0) && pwd)"
mkdir -p "$PDIR"
echo "=== ARSIFY CORE FIX ==="
cp "$BASE/python/senator-execution.py" "$PDIR/" && echo "✓ senator-execution.py"
cp "$BASE/python/skp-cleaner.py" "$PDIR/" && echo "✓ skp-cleaner.py"
cp "$BASE/python/skp_adapter.py" "$PDIR/" && echo "✓ skp_adapter.py"
cp "$BASE/scripts/senator-cycle-v5.sh" "$SDIR/" && chmod +x "$SDIR/senator-cycle-v5.sh" && echo "✓ senator-cycle-v5.sh"
echo ""
echo "--- SKP CLEANUP preview ---"
DRY_RUN=true python3 "$PDIR/skp-cleaner.py" 2>&1 | head -30
echo ""
echo "--- TEST senator-execution (dry-run + mock) ---"
SCRIPT_DIR="$SDIR" python3 "$PDIR/senator-execution.py" --domain akademisi --dry-run --test-mode 2>&1
echo ""
echo "--- Update crontab ---"
(crontab -l 2>/dev/null | grep -v "senator-cycle-v[45]"; echo "0 */6 * * * SCRIPT_DIR=$SDIR bash $SDIR/senator-cycle-v5.sh >> /root/upshalter-logs/senator.log 2>&1") | crontab -
echo "✓ Crontab: senator-cycle-v5 aktif"
echo ""
echo "=== DONE ==="
echo "Jalankan manual: OPENROUTER_API_KEY=sk-or-XXX bash $SDIR/senator-cycle-v5.sh"
