#!/usr/bin/env bash
# AC4: Distribution mechanism decision is recorded in INSTALL.md.

set -uo pipefail

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$TESTS_DIR")"

source "$TESTS_DIR/lib/assert.sh"

INSTALL_MD="$REPO_ROOT/INSTALL.md"

echo "--- AC4: Distribution mechanism decision ---"

assert_file_exists "$INSTALL_MD" "INSTALL.md exists at repo root"

# Must have a distribution section
assert_heading "$INSTALL_MD" "Distribution" "Has distribution mechanism section"

# Must state the decision explicitly
assert_contains "$INSTALL_MD" "Copy files" "States 'Copy files' as the decision"

# Must include rationale
assert_contains "$INSTALL_MD" "Why"        "Includes reasoning for the decision"

# Must acknowledge the tradeoff and what comes next
assert_contains "$INSTALL_MD" "watching"   "States what we're watching"

# Must be explicit that no package manager is needed
assert_contains "$INSTALL_MD" "[Nn]o package|[Nn]o tooling" \
  "States no package manager or tooling required"

suite_summary "AC4: Distribution mechanism decision"
