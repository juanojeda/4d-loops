# Slice 1 Test Suite — Run Instructions

Run all Slice 1 acceptance tests in order. Each test is a self-contained procedure
in its own file. Read the file, execute the steps, record the result.

---

## How to run

For each test:
1. Read the test file
2. Run precondition checks — if any fail, record FAIL and skip to next test
3. Run setup (create temp dirs, stage files)
4. Execute test steps (inline assertions and/or sub-agent tasks)
5. Evaluate pass criteria
6. Record PASS or FAIL with a one-line reason
7. Run teardown

**Sub-agent tests:** where a test says "spawn sub-agent", use the Agent tool with
`subagent_type: general-purpose`, `isolation: worktree` is not needed — pass the
temp dir path and the exact prompt from the test file. Evaluate the sub-agent's
output against the listed assertions.

---

## Tests

| # | File | AC |
|---|---|---|
| 1 | [slice-1/ac1-install-sufficient.md](slice-1/ac1-install-sufficient.md) | Person with no context can read INSTALL.md and reach intake Q1 |
| 2 | [slice-1/ac2-agent-onboarding-routing.md](slice-1/ac2-agent-onboarding-routing.md) | Agent reading agent-onboarding.md can route any valid workflow state |
| 3 | [slice-1/ac3-readme-accurate.md](slice-1/ac3-readme-accurate.md) | README describes all four loops with no placeholder stubs |
| 4 | [slice-1/ac4-distribution-decision.md](slice-1/ac4-distribution-decision.md) | Distribution mechanism decision recorded in INSTALL.md |
| 5 | [slice-1/ac5-intake-walkthrough.md](slice-1/ac5-intake-walkthrough.md) | Full Q1–Q14 path walkable using only repo files |

---

## Report template

Fill this in after running all tests:

| Test | Status | Reason |
|---|---|---|
| AC1 — INSTALL.md sufficient | | |
| AC2 — Agent onboarding routing | | |
| AC3 — README accurate | | |
| AC4 — Distribution decision | | |
| AC5 — Intake walkthrough | | |

---

## TDD baseline

Before any Slice 1 deliverables are created, the expected status of each test is:

| Test | Expected | Because |
|---|---|---|
| AC1 | FAIL | `INSTALL.md` does not exist |
| AC2 | FAIL | `agent-onboarding.md` does not exist |
| AC3 | FAIL | README Loop 4 section contains "To be documented" placeholder; `agent-onboarding.md` and `INSTALL.md` absent from repo structure |
| AC4 | FAIL | `INSTALL.md` does not exist |
| AC5 | FAIL | `Q13` references "Adapter Guide" which is listed as "still to come" and does not exist in the repo |

Slice 1 is complete when all five tests report PASS.
