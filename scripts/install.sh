#!/usr/bin/env bash
# 4D Loops — install
# Run this once from the root of your project to set up 4D Loops.
# Safe to re-run: existing files and the framework clone are never overwritten.

set -euo pipefail

REPO_URL="https://github.com/juanojeda/4d-loops.git"
SYSTEM_DIR=".4d-loops-system"

COMMANDS=(
  "4d-onboard.md"
  "4d-to-bmad.md"
)

echo "Installing 4D Loops..."
echo ""

# ── Clone framework ────────────────────────────────────────────────────────────

if [ -d "$SYSTEM_DIR/.git" ]; then
  echo "  skip  $SYSTEM_DIR/ (already installed — run scripts/update.sh to update)"
else
  echo "  clone  $SYSTEM_DIR/"
  git clone --quiet "$REPO_URL" "$SYSTEM_DIR"
fi

# ── Install Claude Code commands ───────────────────────────────────────────────

mkdir -p ".claude/commands"
for cmd in "${COMMANDS[@]}"; do
  src="$SYSTEM_DIR/.claude/commands/$cmd"
  dest=".claude/commands/$cmd"
  if [ -e "$dest" ]; then
    echo "  skip  $dest"
  else
    cp "$src" "$dest"
    echo "  create  $dest"
  fi
done

# ── Scaffold .loops/ ───────────────────────────────────────────────────────────

echo ""
bash "$SYSTEM_DIR/scripts/scaffold.sh"

# ── Suggest .gitignore ─────────────────────────────────────────────────────────

if grep -qs "\.4d-loops-system" .gitignore 2>/dev/null; then
  : # already present
else
  echo ""
  echo "Tip: add .4d-loops-system/ to your .gitignore:"
  echo "  echo '.4d-loops-system/' >> .gitignore"
fi
