# 4D Loops — Slice 1 Tests

Tests for the five Slice 1 acceptance criteria. All tests are designed to be run by Claude Code without manual intervention.

---

## Running the tests

### ACs 1, 3, 4, 5 — automated bash tests

```bash
bash tests/run-all.sh
```

These tests check file existence and content structure. They fail until the Slice 1 deliverables are created.

### AC2 — agent scenario tests

See `tests/ac2-agent-state-routing/README.md` for the full protocol.

In brief: Claude Code spawns a subagent for each of 13 fixture states, passes it `agent-onboarding.md` + the fixture `.loops/` folder, and evaluates the session brief against expected criteria in `scenarios.json`.

---

## Acceptance criteria covered

| AC | Description | Test |
|---|---|---|
| AC1 | `INSTALL.md` enables cold-start setup without prior context | `ac1-install-cold-start.sh` |
| AC2 | Agent can navigate any valid workflow state to a "you are here, next step is X" response | `ac2-agent-state-routing/` |
| AC3 | README describes all four loops with no placeholder stubs | `ac3-readme-loops.sh` |
| AC4 | Distribution mechanism decision recorded in `INSTALL.md` | `ac4-distribution-decision.sh` |
| AC5 | Intake questionnaire Q1–Q14 is self-contained and fully traversable | `ac5-questionnaire-paths.sh` |

---

## Expected state before deliverables exist

| AC | Expected result now |
|---|---|
| AC1 | FAIL — `INSTALL.md` and `agent-onboarding.md` do not exist yet |
| AC2 | FAIL — `agent-onboarding.md` does not exist yet |
| AC3 | FAIL — README Loop 4 description is a stub ("To be documented") |
| AC4 | FAIL — `INSTALL.md` does not exist yet |
| AC5 | PASS — questionnaire is already complete |

Run `bash tests/run-all.sh` now to confirm baseline failures before implementing the deliverables.

---

## Deliverables needed to make all tests pass

1. `agent-onboarding.md` at repo root (required by AC1, AC2)
2. `INSTALL.md` at repo root (required by AC1, AC4)
3. README update — replace Loop 4 stub, add new files to structure section (required by AC3)
