# Agent Onboarding — 4D Loops Navigation Protocol

**Purpose:** This document is a procedure, not a description. Read it once at session start, then read the project's `.loops/` state, and produce a routing decision for the human.

For a description of the workflow itself, see `workflow-spec.md`.

---

## Session start protocol

Run this procedure at the start of every session before doing anything else.

1. **Read `.loops/_index.md`** — identify all items whose status is not `archived` or `done`. These are the active items.

2. **For each active item**, load the most recent artefact in its folder:
   - Problem-level items: look for `discovery-output.md` in `.loops/_problems/[id]-[slug]/`
   - Solution-level items: look for `design-output.md` in `.loops/_problems/[id]/[id.n]-[slug]/`

3. **Read the last Decision Log entry** in `.loops/_radiators/decision-log.md` that references this item.

4. **Determine** for each active item:
   - Which loop is this in?
   - What is the artefact status?
   - Is anything blocking progress?

5. **Produce a session brief** — the output the human needs before any work starts:
   - Current position for each active item
   - Next decision or action required
   - Any blockers to surface (see Escalation conditions)

The session brief is your output. It tells the human where they are. Do not start doing work until you have produced it.

---

## State → next step map

For every possible state you might find, what to tell the human.

| State | What to tell the human |
|---|---|
| No `.loops/` folder exists | Run INSTALL.md setup. Then return and start at the intake questionnaire. |
| `_index.md` is empty or has no active items | You have no active problems. Start at the intake questionnaire — Q4 if you have a hunch, Q3 if you have a solution in mind. |
| Discovery output — draft (incomplete fields present) | You're mid-framing. The incomplete fields in the discovery output are: [list them]. Complete these before proceeding. |
| Discovery output — complete, status: `UNVALIDATED` | You've taken a conscious risk. Check the Decision Log for the risk log entry. [If the review checkpoint has passed: validate now or make another explicit decision. If not: proceed to Gate 1.] |
| Discovery output — complete, status: `validated` | You're ready for Gate 1. Size the problem: reach, impact, effort (order of magnitude). |
| Gate 1 passed, no design output yet | You're entering Loop 2. Start by writing the Decision Frame. |
| Design output — in progress (incomplete sections present) | You're mid-sprint. The incomplete sections are: [list them]. Next: [current sprint stage — Decision Frame, concept generation, evaluation, AI challenge pass, prototype, testing]. |
| Design output — complete | Check the SDD handoff checklist in `workflow-spec.md`. If clear, hand off to your SDD tooling. |
| Implementation in progress | This workflow ends at the Design Output. Check your SDD tooling for build status. Return here after ship. |
| Shipped, no diagnosis yet | You're in Loop 4. Check outcome metrics against what was expected when the problem was sized at Gate 1. |
| Metrics moved | Problem solved. Mark done in `_index.md`, update the Opportunity Map, archive the folder if appropriate. |
| Metrics flat | The solution didn't move the needle. Return to Loop 1 — reframe the problem, don't iterate on the solution. |
| Concept needs iteration | Return to Loop 2 with the test data from diagnosis. |
| UNVALIDATED checkpoint reached | Return to Discovery Output validation. Validate the assumption now with real evidence, or make another explicit risk decision and log it. |

---

## Artefact completeness checks

For each artefact, the specific fields to check in order to assess whether it is complete. These checks are on presence — you cannot verify quality from file content alone.

### Discovery output — complete when:

- Problem hypothesis present and framed as a user experience or outcome (not a feature or solution)
- At least one external source cited — agent can check field is populated, not that the source is truly external (see Escalation conditions)
- Status field set to `validated` or `UNVALIDATED` — if `UNVALIDATED`, a risk log entry must be present in the Decision Log
- Sizing fields populated: reach, impact, effort (order of magnitude)

### Design output — complete when:

- Chosen concept and reasoning present
- Rejected directions section present and non-empty
- Validation evidence and confidence level present
- Hard constraints present
- Feedback instrumentation requirements (Section 8) present and non-empty
- Open questions section present — either resolved or explicitly deferred with a note

### Risk log entry — complete when:

- Assumption field present
- Validation signal field present (what evidence and by when)
- Review checkpoint field present (specific date, metric, or event)

---

## Escalation conditions

These are things you cannot assess from file content alone. Surface them to the human rather than assuming.

**External validation** — you can check whether the source field is populated, but cannot verify that the source is truly external. Surface: "The discovery output cites [X] as external validation — confirm this is a source outside the team before proceeding to Gate 1."

**Confidence levels** — you can read a stated confidence level but cannot assess whether it's calibrated. Surface low-confidence items without a path to improvement: "This design output is marked [medium/low] confidence with no stated path to higher confidence. Confirm this is acceptable before handing off to Loop 3."

**Checkpoint dates** — you can read a checkpoint date and compare to today's date. Surface passed checkpoints: "The risk log checkpoint for [item] was [date]. It has passed — a decision is required before continuing."

**User testing** — you cannot verify that sessions happened with real users. Surface before Loop 3 handoff: "The design output states testing was completed. Confirm sessions were run with real (not synthetic) users before proceeding to Loop 3."

---

## Artefact quick-reference

| Artefact | Location | Produced in | Purpose |
|---|---|---|---|
| Index | `.loops/_index.md` | Setup | Registry of all active and archived work |
| North Star | `.loops/_radiators/north-star.md` | Setup | What success looks like; always current |
| Opportunity Map | `.loops/_radiators/opportunity-map.md` | Loop 1 | Living map of the problem space |
| Decision Log | `.loops/_radiators/decision-log.md` | All loops | Every significant fork, append-only |
| Discovery output | `.loops/_problems/[id]-[slug]/discovery-output.md` | Loop 1 | Validated problem with evidence and sizing |
| Design output | `.loops/_problems/[id]/[id.n]-[slug]/design-output.md` | Loop 2 | Tested solution with decisions and rejected directions |
| Risk log entry | Inside the Decision Log | Any gate | Records when work proceeds with unvalidated assumptions |
