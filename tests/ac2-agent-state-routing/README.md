# AC2 — Agent State Routing Tests

**AC:** An AI agent reading `agent-onboarding.md` and a project's `.loops/` can produce a "you are here, next step is X" response for any valid workflow state.

These are agent-centric tests: Claude Code runs them by spawning a subagent for each scenario, evaluating the response against expected criteria, and recording PASS or FAIL.

---

## How to run

### Prerequisite check (run first)

Before running scenarios, verify:

1. `agent-onboarding.md` exists at repo root — if not, stop. AC2 cannot pass.
2. `agent-onboarding.md` contains a "Session start protocol" section
3. `agent-onboarding.md` contains a "State → next step map" section covering all states in `scenarios.json`
4. `agent-onboarding.md` contains an "Artefact completeness checks" section
5. `agent-onboarding.md` contains an "Escalation conditions" section

### Running scenarios

For each scenario in `scenarios.json`:

1. Note the `fixture` path (relative to this file's directory) and `expected` criteria.

2. Spawn a subagent with this prompt, substituting the placeholders:

   > You are an AI agent onboarding onto a project that uses the 4D Loops workflow.
   >
   > Step 1: Read `[REPO_ROOT]/agent-onboarding.md`. This is your navigation protocol.
   >
   > Step 2: Read all files under `[FIXTURE_PATH]` as if they are the project's `.loops/` folder. The fixture represents a real project in a specific workflow state.
   >
   > Step 3: Produce a session brief. Your brief must state:
   > - Where this project is in the 4D Loops workflow (which loop, which state)
   > - What the immediate next action or decision is
   > - Any blockers or escalation items
   >
   > Scenario context: [SCENARIO_DESCRIPTION]

3. Evaluate the subagent's response against the scenario's `expected` block:
   - `must_identify_state`: the response must correctly name the workflow state
   - `must_recommend_action`: the response must include the correct next action
   - `must_mention`: the response must reference these items
   - `must_not_recommend`: the response must not suggest these (wrong actions for this state)

4. Record PASS if all criteria are met, FAIL otherwise. Note which criteria failed.

### Pass condition

All 13 scenarios must pass for AC2 to be satisfied. A single failing scenario is a failing AC.

---

## Scenarios at a glance

| # | Name | Workflow state |
|---|---|---|
| 01 | no-loops-folder | Brand new project, no `.loops/` folder |
| 02 | empty-index | `.loops/` exists, `_index.md` has no active items |
| 03 | discovery-draft | Discovery output exists but is incomplete (draft) |
| 04 | discovery-unvalidated | Discovery output UNVALIDATED, checkpoint not yet reached |
| 05 | discovery-unvalidated-checkpoint | Discovery output UNVALIDATED, checkpoint date has passed |
| 06 | discovery-validated | Discovery output validated, Gate 1 not yet passed |
| 07 | gate1-passed | Gate 1 passed, no design output started |
| 08 | design-in-progress | Design output in progress (mid-sprint) |
| 09 | design-complete | Design output complete, ready for handoff |
| 10 | shipped-no-diagnosis | Implementation shipped, Loop 4 not started |
| 11 | metrics-moved | Post-ship: outcome metrics moved (problem solved) |
| 12 | metrics-flat | Post-ship: metrics flat (solution didn't work) |
| 13 | concept-needs-iteration | Post-ship: direction right, execution needs iteration |
