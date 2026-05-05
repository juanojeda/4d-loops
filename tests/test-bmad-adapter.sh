#!/usr/bin/env bash
# Full AAA test for the /4d-to-bmad adapter.
#
# Usage:
#   bash tests/test-bmad-adapter.sh [fixture-dir]
#
# fixture-dir defaults to tests/fixtures/do-001.1
# Requires: claude CLI available and authenticated.

set -euo pipefail

FIXTURE_DIR="${1:-tests/fixtures/do-001.1}"
SOURCE="$FIXTURE_DIR/design-output.md"
BRIEF="$FIXTURE_DIR/bmad/project-brief.md"
DETAILS="$FIXTURE_DIR/bmad/further-details.md"

PASS=0
FAIL=0

check() {
  local desc="$1"
  local result="$2"
  if [ "$result" = "pass" ]; then
    echo "  PASS  $desc"
    PASS=$((PASS + 1))
  else
    echo "  FAIL  $desc"
    FAIL=$((FAIL + 1))
  fi
}

# ── Arrange ────────────────────────────────────────────────────────────────────

echo "[arrange] checking fixture: $SOURCE"
if [ ! -f "$SOURCE" ]; then
  echo "Error: fixture not found at $SOURCE"
  exit 1
fi
echo "[arrange] fixture found"

echo "[arrange] removing previous output: $FIXTURE_DIR/bmad"
rm -rf "$FIXTURE_DIR/bmad"
echo "[arrange] clean"

# ── Act ───────────────────────────────────────────────────────────────────────

echo ""
echo "[act] invoking claude -p \"/4d-to-bmad $SOURCE\""
echo "[act] this calls Claude and may take 30–60 seconds..."
echo ""
claude -p --verbose --permission-mode acceptEdits "/4d-to-bmad $SOURCE"
echo ""
echo "[act] done"

# ── Assert ────────────────────────────────────────────────────────────────────

echo "[assert] checking outputs..."
echo ""

[ -f "$BRIEF" ]   && check "project-brief.md exists"   pass || check "project-brief.md exists"   fail
[ -f "$DETAILS" ] && check "further-details.md exists" pass || check "further-details.md exists" fail

if [ ! -f "$BRIEF" ] || [ ! -f "$DETAILS" ]; then
  echo ""
  echo "Cannot continue — output files missing."
  exit 1
fi

head -5 "$BRIEF" | grep -q "UNVALIDATED" \
  && check "UNVALIDATED callout at top of project-brief.md" pass \
  || check "UNVALIDATED callout at top of project-brief.md" fail

FEEDBACK_COUNT=$(grep -c "\[FEEDBACK\] AC:" "$BRIEF" || true)
[ "$FEEDBACK_COUNT" -eq 4 ] \
  && check "[FEEDBACK] AC: count = 4 (got $FEEDBACK_COUNT)" pass \
  || check "[FEEDBACK] AC: count = 4 (got $FEEDBACK_COUNT)" fail

DECIDED_COUNT=$(grep -c "⚠️ DECIDED" "$BRIEF" || true)
[ "$DECIDED_COUNT" -ge 1 ] \
  && check "§5 decisions prefixed ⚠️ DECIDED (found $DECIDED_COUNT)" pass \
  || check "§5 decisions prefixed ⚠️ DECIDED (found $DECIDED_COUNT)" fail

grep -qi "conditions to revisit" "$BRIEF" \
  && check "§6 table has no 'conditions to revisit' column" fail \
  || check "§6 table has no 'conditions to revisit' column" pass

TAG_COUNT=$(grep -c "(4DL:" "$BRIEF" || true)
[ "$TAG_COUNT" -ge 10 ] \
  && check "Sections tagged (4DL: §N) — found $TAG_COUNT tags" pass \
  || check "Sections tagged (4DL: §N) — found $TAG_COUNT tags (expected ≥10)" fail

head -1 "$BRIEF" | grep -q "4D Loops source:" \
  && check "project-brief.md has source header" pass \
  || check "project-brief.md has source header" fail

head -1 "$DETAILS" | grep -q "4D Loops source:" \
  && check "further-details.md has source header" pass \
  || check "further-details.md has source header" fail

grep -q "(4DL: §7)"  "$DETAILS" && S7=pass  || S7=fail
grep -q "(4DL: §11)" "$DETAILS" && S11=pass || S11=fail
grep -q "(4DL: §12)" "$DETAILS" && S12=pass || S12=fail
[ "$S7" = pass ] && [ "$S11" = pass ] && [ "$S12" = pass ] \
  && check "further-details.md contains §7, §11, §12 content" pass \
  || check "further-details.md contains §7, §11, §12 content (missing: §7=$S7 §11=$S11 §12=$S12)" fail

# ── Teardown ──────────────────────────────────────────────────────────────────

echo ""
echo "[teardown] removing $FIXTURE_DIR/bmad"
rm -rf "$FIXTURE_DIR/bmad"
echo "[teardown] done"

# ── Summary ───────────────────────────────────────────────────────────────────

echo ""
echo "Results: $PASS passed, $FAIL failed"

[ "$FAIL" -eq 0 ] && exit 0 || exit 1
