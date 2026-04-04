#!/usr/bin/env bash
# AC1: A person with no prior context can read INSTALL.md, set up .loops/,
# and reach their first intake questionnaire question without needing to
# read anything else first.

set -uo pipefail

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$TESTS_DIR")"

source "$TESTS_DIR/lib/assert.sh"

INSTALL_MD="$REPO_ROOT/INSTALL.md"

echo "--- AC1: INSTALL.md cold-start setup ---"

# File must exist
assert_file_exists "$INSTALL_MD" "INSTALL.md exists at repo root"

# Required sections
assert_heading "$INSTALL_MD" "What you.re installing" "Has 'What you're installing' section"
assert_heading "$INSTALL_MD" "Minimum file set" "Has 'Minimum file set' section"
assert_heading "$INSTALL_MD" "First-time setup" "Has 'First-time setup' section"
assert_heading "$INSTALL_MD" "After setup" "Has 'After setup' section"

# Must point the reader to the intake questionnaire as their next step
assert_contains "$INSTALL_MD" "intake-questionnaire" "References intake-questionnaire.md"

# Must reference agent-onboarding.md so readers know about agent support
assert_contains "$INSTALL_MD" "agent-onboarding" "References agent-onboarding.md"

# Must instruct the reader to create .loops/
assert_contains "$INSTALL_MD" "\.loops/" "Setup steps mention .loops/ folder"

# All files listed in the minimum file set must exist in this repo
# (These are the files a team copies into their project.)
assert_file_exists "$REPO_ROOT/workflow-spec.md"                     "workflow-spec.md exists (minimum file set)"
assert_file_exists "$REPO_ROOT/agent-onboarding.md"                  "agent-onboarding.md exists (minimum file set)"
assert_file_exists "$REPO_ROOT/conventions/folder-structure.md"      "conventions/folder-structure.md exists (minimum file set)"
assert_file_exists "$REPO_ROOT/playbooks/intake-questionnaire.md"    "intake-questionnaire.md exists (minimum file set)"
assert_file_exists "$REPO_ROOT/templates/template-problem-hypothesis.md" "template-problem-hypothesis.md exists (minimum file set)"
assert_file_exists "$REPO_ROOT/templates/template-design-output.md"  "template-design-output.md exists (minimum file set)"
assert_file_exists "$REPO_ROOT/templates/radiator-north-star.md"     "radiator-north-star.md exists (minimum file set)"
assert_file_exists "$REPO_ROOT/templates/radiator-opportunity-map.md" "radiator-opportunity-map.md exists (minimum file set)"
assert_file_exists "$REPO_ROOT/templates/radiator-decision-log.md"   "radiator-decision-log.md exists (minimum file set)"

# Setup must not require external tooling
assert_not_contains "$INSTALL_MD" "npm install"  "No npm install required"
assert_not_contains "$INSTALL_MD" "pip install"  "No pip install required"
assert_not_contains "$INSTALL_MD" "brew install" "No brew install required"

suite_summary "AC1: INSTALL.md cold-start setup"
