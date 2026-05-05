#!/usr/bin/env bash
# 4D Loops — update
# Run this from the root of your project to pull the latest framework changes.

set -euo pipefail

SYSTEM_DIR=".4d-loops-system"

COMMANDS=(
  "4d-onboard.md"
  "4d-to-bmad.md"
)

if [ ! -d "$SYSTEM_DIR/.git" ]; then
  echo "Error: $SYSTEM_DIR/ not found. Run install first:"
  echo "  curl -sSf https://raw.githubusercontent.com/juanojeda/4d-loops/main/scripts/install.sh | bash"
  exit 1
fi

echo "Updating 4D Loops..."
echo ""

# ── Pull latest framework ──────────────────────────────────────────────────────

git -C "$SYSTEM_DIR" pull --quiet
echo "  updated  $SYSTEM_DIR/"

# ── Refresh Claude Code commands ───────────────────────────────────────────────

mkdir -p ".claude/commands"
for cmd in "${COMMANDS[@]}"; do
  cp "$SYSTEM_DIR/.claude/commands/$cmd" ".claude/commands/$cmd"
  echo "  updated  .claude/commands/$cmd"
done

echo ""
echo "Done."
