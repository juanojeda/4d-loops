# Test AC3 — README describes all four loops with no placeholder stubs

**AC:** "README describes all four loops accurately with no placeholder stubs."

**Source:** `docs/plans/slice-1-traversable.md` § Definition of done

**Expected baseline status:** FAIL — README Loop 4 section contains "To be documented"
placeholder; `agent-onboarding.md` and `INSTALL.md` are absent from the repo structure block.

---

## Precondition checks

1. `README.md` exists at `/home/user/4d-loops/README.md`
   - Check: `ls /home/user/4d-loops/README.md`
   - Fail message: `README.md does not exist — AC3 FAIL (unexpected: file should already exist)`

---

## Setup

No temp directory needed. This test reads `README.md` directly.

---

## Test

Read `/home/user/4d-loops/README.md` and evaluate the following assertions inline.

### Assertion 1 — Loop 1 (Discovery) is described with no placeholder

- Check: README contains a section or paragraph describing Loop 1 / Continuous Discovery
- Check: that section does NOT contain any of these strings:
  - `to be documented`
  - `coming soon`
  - `TBD`
  - `[placeholder]`
  - `TODO`
- PASS if Loop 1 has substantive content and no placeholder strings
- FAIL message: "README Loop 1 section is missing or contains a placeholder"

### Assertion 2 — Loop 2 (Design) is described with no placeholder

- Check: README contains a section or paragraph describing Loop 2 / Design Sprint
- Check: that section does NOT contain any placeholder strings (see Assertion 1 list)
- PASS if Loop 2 has substantive content and no placeholder strings
- FAIL message: "README Loop 2 section is missing or contains a placeholder"

### Assertion 3 — Loop 3 (Development) is described with no placeholder

- Check: README contains a section or paragraph describing Loop 3 / Development / BYO SDD
- Check: that section does NOT contain any placeholder strings
- PASS if Loop 3 has substantive content and no placeholder strings
- FAIL message: "README Loop 3 section is missing or contains a placeholder"

### Assertion 4 — Loop 4 (Diagnosis) is described with no placeholder

- Check: README contains a section or paragraph describing Loop 4 / Diagnosis
- Check: that section does NOT contain any of these strings (case-insensitive):
  - `to be documented`
  - `coming soon`
  - `TBD`
  - `[placeholder]`
  - `TODO`
- Check: the Loop 4 description mentions at least two of:
  - outcome metrics
  - routing findings back
  - the four exit routes (solved / flat / iterate / checkpoint)
  - `workflow-spec.md`
- PASS if Loop 4 has substantive content, no placeholder strings, and meets content check
- FAIL message: "README Loop 4 section contains a placeholder or is not substantively described"
  (Current failure: Loop 4 reads "To be documented." — this must be replaced)

### Assertion 5 — `agent-onboarding.md` appears in repo structure

- Check: README repo structure block contains `agent-onboarding.md`
- PASS if the string `agent-onboarding.md` appears in README
- FAIL message: "README repo structure does not include agent-onboarding.md"

### Assertion 6 — `INSTALL.md` appears in repo structure

- Check: README repo structure block contains `INSTALL.md`
- PASS if the string `INSTALL.md` appears in README
- FAIL message: "README repo structure does not include INSTALL.md"

### Assertion 7 — "What's still to come" does not list Slice 1 deliverables

The "What's still to come" section should reflect Slice 2+ targets only. Items
that are now complete should not appear as to-do items.

- Check: "What's still to come" (or equivalent section) does NOT list any of these
  as pending items:
  - Agent onboarding prompt (now exists as `agent-onboarding.md`)
  - Distribution mechanism decision (now recorded in `INSTALL.md`)
  - Loop 4 / Diagnosis (now documented)
- PASS if none of the above appear as unchecked to-do items in the "still to come" list
- FAIL message: "What's still to come still lists completed Slice 1 items as pending"

---

## Pass criteria

All seven assertions must pass. If any fails, AC3 is FAIL. Record which assertion
failed and what was found vs. expected.

---

## Teardown

No cleanup needed.
