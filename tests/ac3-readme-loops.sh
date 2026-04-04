#!/usr/bin/env bash
# AC3: README describes all four loops accurately with no placeholder stubs.

set -uo pipefail

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$TESTS_DIR")"

source "$TESTS_DIR/lib/assert.sh"

README="$REPO_ROOT/README.md"

echo "--- AC3: README loop descriptions ---"

assert_file_exists "$README" "README.md exists"

# All four loops must be present
assert_contains "$README" "Loop 1" "README mentions Loop 1"
assert_contains "$README" "Loop 2" "README mentions Loop 2"
assert_contains "$README" "Loop 3" "README mentions Loop 3"
assert_contains "$README" "Loop 4" "README mentions Loop 4"

# Loop 4 must have a real description, not a stub
assert_not_contains "$README" "To be documented" "README has no 'To be documented' stubs"
assert_not_contains "$README" "to be documented" "README has no 'to be documented' stubs"
assert_not_contains "$README" "\[TBD\]"           "README has no [TBD] stubs"

# Loop 4 must describe Diagnosis accurately
assert_contains "$README" "Diagnosis"  "Loop 4 is named Diagnosis"
assert_contains "$README" "outcome"    "Loop 4 mentions outcome monitoring"
assert_contains "$README" "feedback"   "Loop 4 mentions routing findings back"

# New deliverables must appear in the repo structure section
assert_contains "$README" "agent-onboarding.md" "README lists agent-onboarding.md"
assert_contains "$README" "INSTALL.md"           "README lists INSTALL.md"

suite_summary "AC3: README loop descriptions"
