#!/usr/bin/env bash
# AC5: The full intake questionnaire path — Q1 through Q14 — can be walked
# using only files in the repo.

set -uo pipefail

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$TESTS_DIR")"

source "$TESTS_DIR/lib/assert.sh"

Q_FILE="$REPO_ROOT/playbooks/intake-questionnaire.md"

echo "--- AC5: Intake questionnaire Q1-Q14 completeness ---"

assert_file_exists "$Q_FILE" "intake-questionnaire.md exists"

# All 14 main questions must be present
for n in 1 2 3 4 5 6 7 8 9 10 11 12 13 14; do
  assert_contains "$Q_FILE" "## Q${n}\." "Q${n} is present"
done

# Sub-questions Q5B and Q5C must be present
assert_contains "$Q_FILE" "Q5B" "Q5B (saturation check) is present"
assert_contains "$Q_FILE" "Q5C" "Q5C (interpretation) is present"

# All intra-questionnaire routing references must resolve:
# extract every "go to Q[n]" reference and verify Q[n] exists
while IFS= read -r qref; do
  qn="${qref//[^0-9]/}"
  if [ -n "$qn" ] && [ "$qn" -ge 1 ] && [ "$qn" -le 14 ]; then
    assert_contains "$Q_FILE" "## Q${qn}\." "Routing target Q${qn} exists"
  fi
done < <(grep -oE 'go to Q[0-9]+' "$Q_FILE" | grep -oE 'Q[0-9]+' | sort -u)

# Terminal states must be present
assert_contains "$Q_FILE" "Stop here"  "Has terminal 'Stop here' states"
assert_contains "$Q_FILE" "Loop 2"     "References Loop 2 as a routing target"
assert_contains "$Q_FILE" "Loop 3"     "References Loop 3 as a routing target"
assert_contains "$Q_FILE" "Done\."     "Has 'Done.' terminal state"

# No unresolved placeholders
assert_not_contains "$Q_FILE" "\[TBD\]" "No [TBD] placeholders"
assert_not_contains "$Q_FILE" "TODO"    "No TODO items"

# Routing summary table must be present (proves self-documenting coverage)
assert_contains "$Q_FILE" "Routing summary" "Has routing summary table"

# The folder structure conventions must be documented (questionnaire references .loops/ paths)
assert_file_exists "$REPO_ROOT/conventions/folder-structure.md" \
  "conventions/folder-structure.md exists (referenced by questionnaire)"

suite_summary "AC5: Intake questionnaire Q1-Q14 completeness"
