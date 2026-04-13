#!/usr/bin/env bash
# 4D Loops — update
# Run this from the root of your project to pull the latest framework changes.

set -euo pipefail

SYSTEM_DIR=".4d-loops-system"
COMMAND_SRC="$SYSTEM_DIR/.claude/commands/4d-onboard.md"
COMMAND_DEST=".claude/commands/4d-onboard.md"

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

# ── Refresh Claude Code command ────────────────────────────────────────────────

mkdir -p "$(dirname "$COMMAND_DEST")"
cp "$COMMAND_SRC" "$COMMAND_DEST"
echo "  updated  $COMMAND_DEST"

echo ""
echo "Done."
