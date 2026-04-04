# Test AC2 — Agent onboarding produces correct "you are here" routing

**AC:** "An AI agent reading `agent-onboarding.md` and a project's `.loops/` can
produce a 'you are here, next step is X' response for any valid workflow state."

**Source:** `docs/plans/slice-1-traversable.md` § Definition of done

**Expected baseline status:** FAIL — `agent-onboarding.md` does not exist at repo root.

---

## Precondition checks

1. `agent-onboarding.md` exists at `/home/user/4d-loops/agent-onboarding.md`
   - Check: `ls /home/user/4d-loops/agent-onboarding.md`
   - Fail message: `agent-onboarding.md does not exist — AC2 FAIL (file missing)`

---

## Overview

This test runs six sub-cases, one per workflow state from the state → next step map
in `agent-onboarding.md`. Each sub-case:

1. Creates a temp directory with `agent-onboarding.md` + a synthetic `.loops/` state
2. Spawns a sub-agent that reads only those files
3. Evaluates the sub-agent's routing output against expected routing

All six sub-cases must pass for AC2 to pass.

---

## Sub-agent prompt (shared across all sub-cases)

Send this prompt to every sub-agent in this test, unchanged:

> You are an AI agent assisting a product team. You have been given `agent-onboarding.md`
> and a `.loops/` folder representing the current state of a project.
>
> Read `agent-onboarding.md` fully first. Then read the `.loops/` folder.
>
> Produce a session brief with these exact fields:
>
> **YOU ARE HERE:**
> One sentence describing where the project is in the workflow right now.
>
> **NEXT STEP:**
> One sentence describing the specific action the human should take next.
>
> **BLOCKERS:**
> Any issues the agent cannot assess from files alone that must be surfaced to the human.
> If none, write "None."
>
> Do not ask questions. Do not describe the 4D Loops system. Just produce the brief.

---

## Sub-case 1: No `.loops/` folder

### Setup

```bash
TEMP=/tmp/4dl-test-ac2-s1
rm -rf "$TEMP" && mkdir -p "$TEMP"
cp /home/user/4d-loops/agent-onboarding.md "$TEMP/"
# No .loops/ directory — intentionally absent
```

### Expected routing

- **YOU ARE HERE:** something indicating no `.loops/` folder found / not set up
- **NEXT STEP:** run INSTALL.md setup (or equivalent instruction to set up the workflow)

### Assertions

- [ ] "YOU ARE HERE" mentions the absence of `.loops/` or that the project is not set up
- [ ] "NEXT STEP" directs the human to run setup / follow INSTALL.md
- [ ] Does NOT say "go to intake questionnaire" without first mentioning setup

---

## Sub-case 2: Fresh setup, no active work

### Setup

```bash
TEMP=/tmp/4dl-test-ac2-s2
rm -rf "$TEMP" && mkdir -p "$TEMP/.loops/_radiators"
cp /home/user/4d-loops/agent-onboarding.md "$TEMP/"

cat > "$TEMP/.loops/_index.md" << 'EOF'
# Index

No active work items.
EOF
```

### Expected routing

- **YOU ARE HERE:** no active problems / nothing in progress
- **NEXT STEP:** start at the intake questionnaire (Q4 if a hunch exists, Q3 if there's a preformed solution)

### Assertions

- [ ] "YOU ARE HERE" mentions no active problems or no items in the index
- [ ] "NEXT STEP" references the intake questionnaire

---

## Sub-case 3: Discovery output in draft

### Setup

```bash
TEMP=/tmp/4dl-test-ac2-s3
rm -rf "$TEMP" && mkdir -p "$TEMP/.loops/_problems/001-checkout-friction" "$TEMP/.loops/_radiators"
cp /home/user/4d-loops/agent-onboarding.md "$TEMP/"

cat > "$TEMP/.loops/_index.md" << 'EOF'
# Index

| ID | Name | Status |
|---|---|---|
| 001 | Checkout friction | Discovery — draft |
EOF

cat > "$TEMP/.loops/_problems/001-checkout-friction/discovery-output.md" << 'EOF'
# Discovery Output — 001 Checkout Friction

**Status:** draft

## Problem hypothesis

_[not yet written]_

## External source

_[not yet cited]_

## Sizing

- Reach: _[not estimated]_
- Impact: _[not estimated]_
- Effort: _[not estimated]_
EOF
```

### Expected routing

- **YOU ARE HERE:** mid-framing / discovery output is draft / incomplete fields present
- **NEXT STEP:** complete the missing fields in the discovery output (problem hypothesis, external source, sizing)

### Assertions

- [ ] "YOU ARE HERE" identifies the project as mid-discovery / discovery draft
- [ ] "NEXT STEP" references completing the discovery output
- [ ] Agent lists specific incomplete fields (problem hypothesis, external source, or sizing)

---

## Sub-case 4: Discovery output complete and validated

### Setup

```bash
TEMP=/tmp/4dl-test-ac2-s4
rm -rf "$TEMP" && mkdir -p "$TEMP/.loops/_problems/001-checkout-friction" "$TEMP/.loops/_radiators"
cp /home/user/4d-loops/agent-onboarding.md "$TEMP/"

cat > "$TEMP/.loops/_index.md" << 'EOF'
# Index

| ID | Name | Status |
|---|---|---|
| 001 | Checkout friction | Discovery — validated |
EOF

cat > "$TEMP/.loops/_problems/001-checkout-friction/discovery-output.md" << 'EOF'
# Discovery Output — 001 Checkout Friction

**Status:** validated

## Problem hypothesis

New users who reach the checkout page abandon before completing purchase because
the payment form requires account creation before showing the total.

## External source

UserZoom session recordings (March 2026) — 14 of 18 participants expressed
confusion or frustration at the account-creation gate. Source: external usability study.

## Confirmed by

Three participants independently described the same friction point unprompted
during post-session interviews.

## Sizing

- Reach: ~4,000 users/month hit checkout page
- Impact: high — direct revenue impact
- Effort: medium — payment flow refactor required
EOF
```

### Expected routing

- **YOU ARE HERE:** discovery complete and validated / ready for Gate 1
- **NEXT STEP:** size the problem (reach, impact, effort) and proceed to Gate 1

### Assertions

- [ ] "YOU ARE HERE" identifies the project as having a validated discovery output
- [ ] "NEXT STEP" mentions Gate 1 or sizing or entering Loop 2

---

## Sub-case 5: Design output complete, ready for handoff

### Setup

```bash
TEMP=/tmp/4dl-test-ac2-s5
rm -rf "$TEMP" && mkdir -p "$TEMP/.loops/_problems/001-checkout-friction/001.1-guest-checkout" "$TEMP/.loops/_radiators"
cp /home/user/4d-loops/agent-onboarding.md "$TEMP/"

cat > "$TEMP/.loops/_index.md" << 'EOF'
# Index

| ID | Name | Status |
|---|---|---|
| 001 | Checkout friction | Design — complete |
EOF

cat > "$TEMP/.loops/_problems/001-checkout-friction/discovery-output.md" << 'EOF'
# Discovery Output — 001 Checkout Friction

**Status:** validated

## Problem hypothesis

New users abandon checkout because account creation is required before the total is shown.

## External source

UserZoom study, March 2026.

## Sizing

- Reach: ~4,000/month
- Impact: high
- Effort: medium
EOF

cat > "$TEMP/.loops/_problems/001-checkout-friction/001.1-guest-checkout/design-output.md" << 'EOF'
# Design Output — 001.1 Guest Checkout

**Status:** complete

## Chosen concept

Guest checkout flow: show order total immediately, allow purchase without account
creation, offer account creation post-purchase.

## Reasoning

Tested with 5 users. All understood the flow. 4 of 5 completed purchase in prototype.
Confidence: high.

## Rejected directions

- Progressive disclosure (show total only after email entry) — tested, users still
  confused about whether account was required. Conditions to revisit: if new
  research shows email-first is preferred.

## Validation evidence

UserZoom prototype sessions, 5 participants, March 2026.

## Hard constraints

- Must not break existing account-based checkout flow
- Payment provider integration unchanged

## Feedback instrumentation requirements

- [FEEDBACK] Guest checkout completion rate tracked in Mixpanel
- [FEEDBACK] Post-purchase account creation opt-in rate tracked

## Open questions

All resolved. See Decision Log entry 2026-03-28.
EOF
```

### Expected routing

- **YOU ARE HERE:** design complete / ready for handoff to build
- **NEXT STEP:** check the handoff checklist and hand off to SDD tooling

### Assertions

- [ ] "YOU ARE HERE" identifies the project as having a complete design output
- [ ] "NEXT STEP" mentions the handoff checklist or handing off to Loop 3 / SDD tooling

---

## Sub-case 6: Shipped, no diagnosis yet

### Setup

```bash
TEMP=/tmp/4dl-test-ac2-s6
rm -rf "$TEMP" && mkdir -p "$TEMP/.loops/_problems/001-checkout-friction/001.1-guest-checkout/001.1.1-implementation" "$TEMP/.loops/_radiators"
cp /home/user/4d-loops/agent-onboarding.md "$TEMP/"

cat > "$TEMP/.loops/_index.md" << 'EOF'
# Index

| ID | Name | Status |
|---|---|---|
| 001 | Checkout friction | Shipped — awaiting diagnosis |
EOF

cat > "$TEMP/.loops/_problems/001-checkout-friction/001.1-guest-checkout/001.1.1-implementation/status.md" << 'EOF'
# Implementation Status — 001.1.1

**Shipped:** 2026-03-30
**Diagnosis:** not started

Outcome metrics to monitor:
- Guest checkout completion rate (target: >60%, baseline: 0%)
- Post-purchase account opt-in rate (informational)

No diagnosis data collected yet.
EOF
```

### Expected routing

- **YOU ARE HERE:** shipped / in Loop 4 / diagnosis not started
- **NEXT STEP:** check outcome metrics against expectations from Gate 1

### Assertions

- [ ] "YOU ARE HERE" identifies the project as shipped / awaiting diagnosis
- [ ] "NEXT STEP" mentions checking outcome metrics or Loop 4 or diagnosis

---

## Pass criteria

All six sub-cases must pass all their assertions. If any sub-case fails, AC2 is FAIL.
Record which sub-case(s) failed and which assertions were not met.

---

## Teardown

```bash
rm -rf /tmp/4dl-test-ac2-s1 /tmp/4dl-test-ac2-s2 /tmp/4dl-test-ac2-s3 \
        /tmp/4dl-test-ac2-s4 /tmp/4dl-test-ac2-s5 /tmp/4dl-test-ac2-s6
```
