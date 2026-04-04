#!/usr/bin/env bash
# Shared test assertion helpers.
# Usage: source "$(dirname "${BASH_SOURCE[0]}")/lib/assert.sh"

ASSERT_PASS=0
ASSERT_FAIL=0

_pass() {
  echo "  [PASS] $1"
  ASSERT_PASS=$((ASSERT_PASS + 1))
}

_fail() {
  echo "  [FAIL] $1"
  if [ -n "${2:-}" ]; then
    echo "         → $2"
  fi
  ASSERT_FAIL=$((ASSERT_FAIL + 1))
}

assert_file_exists() {
  local path="$1"
  local label="${2:-$path exists}"
  if [ -f "$path" ]; then
    _pass "$label"
  else
    _fail "$label" "File not found: $path"
  fi
}

assert_dir_exists() {
  local path="$1"
  local label="${2:-$path exists}"
  if [ -d "$path" ]; then
    _pass "$label"
  else
    _fail "$label" "Directory not found: $path"
  fi
}

assert_contains() {
  local file="$1"
  local pattern="$2"
  local label="${3:-$(basename "$file") contains: $pattern}"
  if [ -f "$file" ] && grep -qE "$pattern" "$file"; then
    _pass "$label"
  else
    _fail "$label" "Pattern not found: '$pattern' in $file"
  fi
}

assert_not_contains() {
  local file="$1"
  local pattern="$2"
  local label="${3:-$(basename "$file") does not contain: $pattern}"
  if [ ! -f "$file" ] || ! grep -qE "$pattern" "$file"; then
    _pass "$label"
  else
    _fail "$label" "Forbidden pattern found: '$pattern'"
  fi
}

assert_heading() {
  local file="$1"
  local heading="$2"
  local label="${3:-Heading '$heading' present in $(basename "$file")}"
  if [ -f "$file" ] && grep -qE "^#{1,4} .*${heading}" "$file"; then
    _pass "$label"
  else
    _fail "$label" "Markdown heading not found: '$heading'"
  fi
}

suite_summary() {
  local name="$1"
  echo ""
  if [ "$ASSERT_FAIL" -eq 0 ]; then
    echo "[PASS] $name ($ASSERT_PASS assertions passed)"
    return 0
  else
    echo "[FAIL] $name ($ASSERT_FAIL failed, $ASSERT_PASS passed)"
    return 1
  fi
}
