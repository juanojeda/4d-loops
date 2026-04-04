# Test AC4 — Distribution mechanism decision recorded in INSTALL.md

**AC:** "Distribution mechanism decision is recorded in `INSTALL.md`."

**Source:** `docs/plans/slice-1-traversable.md` § Definition of done

**Expected baseline status:** FAIL — `INSTALL.md` does not exist at repo root.

---

## Precondition checks

1. `INSTALL.md` exists at `/home/user/4d-loops/INSTALL.md`
   - Check: `ls /home/user/4d-loops/INSTALL.md`
   - Fail message: `INSTALL.md does not exist — AC4 FAIL (file missing)`

---

## Setup

No temp directory needed. This test reads `INSTALL.md` directly.

---

## Test

Read `/home/user/4d-loops/INSTALL.md` and evaluate the following assertions inline.

### Assertion 1 — INSTALL.md contains a distribution mechanism section

- Check: `INSTALL.md` contains a heading or section that covers the distribution
  mechanism decision. Acceptable forms include:
  - A heading containing "distribution" (case-insensitive)
  - A heading containing "how to install" or "installation method"
  - A clearly labelled decision block
- PASS if such a section exists
- FAIL message: "INSTALL.md has no distribution mechanism section"

### Assertion 2 — A specific mechanism is named

- Check: the distribution section states a specific choice. The chosen mechanism
  per `docs/plans/slice-1-traversable.md` is "copy files manually." Acceptable
  forms include:
  - "copy files" / "copy manually"
  - "no package manager" / "no submodule" / "no CLI"
  - An explicit statement that one option was chosen over others
- PASS if a specific mechanism is named
- FAIL message: "INSTALL.md does not state which distribution mechanism was chosen"

### Assertion 3 — Reasoning for the decision is provided

- Check: the distribution section explains why this mechanism was chosen. Look for:
  - Reasoning about simplicity, tooling independence, or team ownership
  - Reference to the tradeoffs (e.g., manual updates required)
  - OR a "Why" or "Reasoning" label with content
- PASS if reasoning is present
- FAIL message: "INSTALL.md names a distribution mechanism but does not explain why"

### Assertion 4 — Alternative mechanisms are acknowledged

The decision should show it was deliberate, not a default. Per the plan, git submodule
and installable CLI should be acknowledged as alternatives evaluated for a later slice.

- Check: the distribution section acknowledges at least one alternative option
  that was NOT chosen (e.g., "git submodule", "CLI", "package manager")
- PASS if at least one alternative is mentioned
- FAIL message: "INSTALL.md does not acknowledge alternative distribution options"

### Assertion 5 — Decision is written as a decision, not as a to-do

- Check: the distribution section does NOT contain any of:
  - `to be decided`
  - `TBD`
  - `decision needed`
  - `TODO`
  - `[ ]` (unchecked checkbox)
- PASS if section reads as a made decision, not an open question
- FAIL message: "INSTALL.md still has the distribution mechanism as an open question or to-do"

---

## Pass criteria

All five assertions must pass. If any fails, AC4 is FAIL. Record which assertion
failed and the relevant excerpt from `INSTALL.md`.

---

## Teardown

No cleanup needed.
