#!/usr/bin/env bash
# Runs all bash-based Slice 1 tests (ACs 1, 3, 4, 5).
# AC2 agent scenario tests are run separately — see tests/ac2-agent-state-routing/README.md.
#
# Usage: bash tests/run-all.sh

set -uo pipefail

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PASS=0
FAIL=0

run_test() {
  local file="$1"
  if bash "$file"; then
    PASS=$((PASS + 1))
  else
    FAIL=$((FAIL + 1))
  fi
  echo ""
}

echo "========================================"
echo "  4D Loops — Slice 1 Tests"
echo "========================================"
echo ""

run_test "$TESTS_DIR/ac1-install-cold-start.sh"
run_test "$TESTS_DIR/ac3-readme-loops.sh"
run_test "$TESTS_DIR/ac4-distribution-decision.sh"
run_test "$TESTS_DIR/ac5-questionnaire-paths.sh"

echo "========================================"
if [ "$FAIL" -eq 0 ]; then
  echo "  PASS — $PASS suites passed"
else
  echo "  FAIL — $FAIL failed, $PASS passed"
fi
echo "========================================"

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
