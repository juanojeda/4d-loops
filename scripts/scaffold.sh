#!/usr/bin/env bash
# 4D Loops — scaffold
# Creates the .loops/ directory structure in the current working directory.
# Safe to re-run: existing files are never overwritten.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/../templates"

ROOT="${1:-.}"
LOOPS="$ROOT/.loops"

created=0
skipped=0

copy_template() {
  local src="$1"
  local dest="$2"
  if [ -e "$dest" ]; then
    echo "  skip  $dest"
    skipped=$((skipped + 1))
  else
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "  create  $dest"
    created=$((created + 1))
  fi
}

create_file() {
  local path="$1"
  local content="$2"
  if [ -e "$path" ]; then
    echo "  skip  $path"
    skipped=$((skipped + 1))
  else
    mkdir -p "$(dirname "$path")"
    printf '%s' "$content" > "$path"
    echo "  create  $path"
    created=$((created + 1))
  fi
}

create_empty() {
  local path="$1"
  if [ -e "$path" ]; then
    echo "  skip  $path"
    skipped=$((skipped + 1))
  else
    mkdir -p "$(dirname "$path")"
    touch "$path"
    echo "  create  $path"
    created=$((created + 1))
  fi
}

echo "Scaffolding .loops/ in $ROOT"
echo ""

# ── Index ─────────────────────────────────────────────────────────────────────

create_file "$LOOPS/_index.md" \
'# Problem Index

| ID | Slug | Type | Status | Notes |
|---|---|---|---|---|
'

# ── Discovery ─────────────────────────────────────────────────────────────────

create_empty "$LOOPS/_discovery/_questions/.gitkeep"
create_empty "$LOOPS/_discovery/_data/.gitkeep"
create_empty "$LOOPS/_discovery/_findings/.gitkeep"
create_empty "$LOOPS/_discovery/_insights/.gitkeep"

# ── Problems ──────────────────────────────────────────────────────────────────

create_empty "$LOOPS/_problems/_archive/.gitkeep"

# ── Radiators ─────────────────────────────────────────────────────────────────

copy_template "$TEMPLATES_DIR/radiator-north-star.md"     "$LOOPS/_radiators/north-star.md"
copy_template "$TEMPLATES_DIR/radiator-opportunity-map.md" "$LOOPS/_radiators/opportunity-map.md"
copy_template "$TEMPLATES_DIR/radiator-decision-log.md"   "$LOOPS/_radiators/decision-log.md"

# ── Summary ───────────────────────────────────────────────────────────────────

echo ""
echo "Done. $created file(s) created, $skipped skipped."

if [ "$created" -gt 0 ]; then
  echo ""
  echo "Next: run the intake questionnaire to find your starting point."
  echo "  playbooks/intake-questionnaire.md"
fi
