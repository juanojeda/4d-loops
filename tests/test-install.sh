#!/usr/bin/env bash
# AAA tests for scripts/install.sh and scripts/update.sh.
# No network calls — mock .4d-loops-system/ is pre-created in a temp dir.
#
# Usage:
#   bash tests/test-install.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
INSTALL_SCRIPT="$REPO_ROOT/scripts/install.sh"
UPDATE_SCRIPT="$REPO_ROOT/scripts/update.sh"

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

# Creates a mock .4d-loops-system/ inside $1 with the given command filenames.
make_system_dir() {
  local root="$1"; shift
  local cmds=("$@")
  mkdir -p "$root/.4d-loops-system/.git"
  mkdir -p "$root/.4d-loops-system/.claude/commands"
  mkdir -p "$root/.4d-loops-system/scripts"
  printf '#!/usr/bin/env bash\necho "scaffold (mock)"\n' \
    > "$root/.4d-loops-system/scripts/scaffold.sh"
  chmod +x "$root/.4d-loops-system/scripts/scaffold.sh"
  for cmd in "${cmds[@]}"; do
    echo "# mock $cmd" > "$root/.4d-loops-system/.claude/commands/$cmd"
  done
}

# ── Test 1: Fresh install creates all command files ────────────────────────────

echo "[test 1] fresh install creates all commands"

T=$(mktemp -d)
make_system_dir "$T" "4d-onboard.md" "4d-to-bmad.md"
(cd "$T" && bash "$INSTALL_SCRIPT" > /dev/null)

[ -f "$T/.claude/commands/4d-onboard.md" ] \
  && check "4d-onboard.md created on fresh install" pass \
  || check "4d-onboard.md created on fresh install" fail

[ -f "$T/.claude/commands/4d-to-bmad.md" ] \
  && check "4d-to-bmad.md created on fresh install" pass \
  || check "4d-to-bmad.md created on fresh install" fail

rm -rf "$T"

# ── Test 2: Re-run install skips existing files (idempotent) ──────────────────

echo "[test 2] re-run install skips existing files"

T=$(mktemp -d)
make_system_dir "$T" "4d-onboard.md" "4d-to-bmad.md"
(cd "$T" && bash "$INSTALL_SCRIPT" > /dev/null)

# Overwrite with sentinel so we can detect if install.sh overwrites it
echo "SENTINEL" > "$T/.claude/commands/4d-onboard.md"
(cd "$T" && bash "$INSTALL_SCRIPT" > /dev/null)

grep -q "SENTINEL" "$T/.claude/commands/4d-onboard.md" \
  && check "existing command not overwritten on re-run" pass \
  || check "existing command not overwritten on re-run" fail

rm -rf "$T"

# ── Test 3: Install adds new command absent from project ──────────────────────

echo "[test 3] install adds new command when absent from project"

T=$(mktemp -d)
make_system_dir "$T" "4d-onboard.md" "4d-to-bmad.md"
# Simulate: project already has onboard but not bmad
mkdir -p "$T/.claude/commands"
echo "# existing" > "$T/.claude/commands/4d-onboard.md"

(cd "$T" && bash "$INSTALL_SCRIPT" > /dev/null)

[ -f "$T/.claude/commands/4d-to-bmad.md" ] \
  && check "new command installed when project is missing it" pass \
  || check "new command installed when project is missing it" fail

grep -q "# existing" "$T/.claude/commands/4d-onboard.md" \
  && check "existing command preserved" pass \
  || check "existing command preserved" fail

rm -rf "$T"

# ── Test 4: update.sh refreshes all existing commands ─────────────────────────

echo "[test 4] update.sh overwrites existing commands"

T=$(mktemp -d)
make_system_dir "$T" "4d-onboard.md" "4d-to-bmad.md"
mkdir -p "$T/.claude/commands"
echo "OLD" > "$T/.claude/commands/4d-onboard.md"
echo "OLD" > "$T/.claude/commands/4d-to-bmad.md"

(cd "$T" && SKIP_PULL=1 bash "$UPDATE_SCRIPT" > /dev/null)

grep -q "# mock 4d-onboard.md" "$T/.claude/commands/4d-onboard.md" \
  && check "4d-onboard.md overwritten by update" pass \
  || check "4d-onboard.md overwritten by update" fail

grep -q "# mock 4d-to-bmad.md" "$T/.claude/commands/4d-to-bmad.md" \
  && check "4d-to-bmad.md overwritten by update" pass \
  || check "4d-to-bmad.md overwritten by update" fail

rm -rf "$T"

# ── Test 5: update.sh installs net-new command not previously present ─────────

echo "[test 5] update.sh installs net-new command"

T=$(mktemp -d)
# System dir has a new command that project doesn't have yet
make_system_dir "$T" "4d-onboard.md" "4d-to-bmad.md" "4d-new-feature.md"
mkdir -p "$T/.claude/commands"
echo "# existing" > "$T/.claude/commands/4d-onboard.md"
echo "# existing" > "$T/.claude/commands/4d-to-bmad.md"
# 4d-new-feature.md is absent from project

(cd "$T" && SKIP_PULL=1 bash "$UPDATE_SCRIPT" > /dev/null)

[ -f "$T/.claude/commands/4d-new-feature.md" ] \
  && check "net-new command installed by update" pass \
  || check "net-new command installed by update" fail

rm -rf "$T"

# ── Test 6: update.sh fails when system dir is missing ────────────────────────

echo "[test 6] update.sh exits 1 when system dir missing"

T=$(mktemp -d)
# No .4d-loops-system/ created
set +e
(cd "$T" && SKIP_PULL=1 bash "$UPDATE_SCRIPT" 2>/dev/null)
EXIT_CODE=$?
set -e

[ "$EXIT_CODE" -eq 1 ] \
  && check "update.sh exits 1 when system dir missing" pass \
  || check "update.sh exits 1 when system dir missing (got $EXIT_CODE)" fail

rm -rf "$T"

# ── Summary ───────────────────────────────────────────────────────────────────

echo ""
echo "Results: $PASS passed, $FAIL failed"

[ "$FAIL" -eq 0 ] && exit 0 || exit 1
