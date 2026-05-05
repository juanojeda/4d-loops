#!/usr/bin/env bash
# 4D Loops — update
# Run this from the root of your project to pull the latest framework changes.

set -euo pipefail

SYSTEM_DIR=".4d-loops-system"

if [ ! -d "$SYSTEM_DIR/.git" ]; then
  echo "Error: $SYSTEM_DIR/ not found. Run install first:"
  echo "  curl -sSf https://raw.githubusercontent.com/juanojeda/4d-loops/main/scripts/install.sh | bash"
  exit 1
fi

echo "Updating 4D Loops..."
echo ""

# ── Pull latest framework ──────────────────────────────────────────────────────

if [ "${SKIP_PULL:-}" != "1" ]; then
  git -C "$SYSTEM_DIR" pull --quiet
fi
echo "  updated  $SYSTEM_DIR/"

# ── Refresh Claude Code commands ───────────────────────────────────────────────

mkdir -p ".claude/commands"
for cmd_path in "$SYSTEM_DIR/.claude/commands/"*.md; do
  [ -e "$cmd_path" ] || continue
  cmd=$(basename "$cmd_path")
  cp "$cmd_path" ".claude/commands/$cmd"
  echo "  updated  .claude/commands/$cmd"
done

echo ""
echo "Done."
