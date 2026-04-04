# Slice 1 — Traversable: Implementation Plan

**Goal:** A team can walk through all four loops without getting stuck. Everything exists at minimum viable fidelity — enough to orient, not enough to be exhaustive.

**Exit condition:** A team can pick up the system cold and navigate from intake through to a post-ship routing decision, using only what exists in the repo.

---

## Current state

The following already exist and satisfy Slice 1's loop coverage:

| Item | File | Status |
|---|---|---|
| Problem hypothesis template | `templates/template-problem-hypothesis.md` | exists |
| Opportunity map radiator | `templates/radiator-opportunity-map.md` | exists |
| Intake questionnaire | `playbooks/intake-questionnaire.md` | exists |
| Design output template | `templates/template-design-output.md` | exists |
| North Star radiator | `templates/radiator-north-star.md` | exists |
| Decision Log radiator | `templates/radiator-decision-log.md` | exists |
| Handoff contract | `workflow-spec.md` §SDD Handoff | exists |
| `[FEEDBACK]` AC pattern | `workflow-spec.md` §Loop 3 | exists |
| Feedback routing | `workflow-spec.md` §The feedback loop | exists |
| Four exit routes | `workflow-spec.md` §The feedback loop | exists |

**Missing — what this plan covers:**

1. `agent-onboarding.md` — navigation protocol for an AI agent to orient itself and route a human to their next step
2. `INSTALL.md` — how to get the workflow into a project, plus a recorded distribution mechanism decision
3. README update — accurately reflects all four loops and current vs. upcoming state

---

## Open questions resolved

These were listed in the build plan. Decisions made here before work begins:

**Loop 4 scope** — Lightweight for Slice 1. The feedback loop and four exit routes in `workflow-spec.md` are sufficient. A full Loop 4 with its own gates and templates is Slice 2+.

**Agent onboarding audience** — An AI agent acting as navigator: a human runs a generic prompt ("where am I, what should I do next?"), the agent reads `agent-onboarding.md` plus the project's `.loops/` state, and routes the human to the right next step. The agent guides; the human executes. Not fully autonomous operation.

**Distribution mechanism** — Copy files for Slice 1. Intentionally low-tech: no tooling dependency, full ownership, works for any team immediately. Git submodule and installable CLI are evaluated in Slice 3. This decision is recorded in `INSTALL.md` and the Decision Log.

**Adapter Guide depth** — Not in scope for Slice 1.

---

## Work items

### 1. `agent-onboarding.md`

**Location:** `/agent-onboarding.md` (repo root, alongside `workflow-spec.md`)

**Purpose:** A navigation protocol. An agent reads this once at session start, then reads the project's `.loops/` state, and can tell the human: "you are here, the next step is X."

This is not a description of the system — `workflow-spec.md` is that. This is a procedure for determining position and producing a routing decision.

---

**Section: Session start protocol**

A step-by-step procedure the agent runs at the start of every session:

1. Read `_index.md` — identify all active work (status not archived or done)
2. For each active item, load the most recent artefact in its folder
3. Read the last Decision Log entry that references this item
4. Determine: which loop is this in, what is the artefact status, is anything blocking
5. Produce a session brief: current position for each active item, next decision or action required, any blockers to surface

The session brief is the agent's output — it tells the human where they are before any work starts.

---

**Section: State → next step map**

For each possible artefact state, what the agent should tell the human. This mirrors the intake questionnaire logic but written for an agent reading files rather than a human answering questions.

| State | What agent tells the human |
|---|---|
| No `.loops/` folder | Run INSTALL.md setup. Then come back and start at the intake questionnaire. |
| `_index.md` empty or no active items | You have no active problems. Start at the intake questionnaire — Q4 if you have a hunch, Q3 if you have a solution in mind. |
| Discovery output — draft | You're mid-framing. The incomplete fields in the discovery output are: [list]. Complete them before proceeding. |
| Discovery output — complete, UNVALIDATED | You've taken a conscious risk. Check the risk log entry for the validation checkpoint. [If checkpoint reached: validate now or make another explicit decision. If not: proceed to Gate 1.] |
| Discovery output — complete, validated | You're ready for Gate 1. Size the problem: reach, impact, effort. |
| Gate 1 passed, no design output yet | You're entering Loop 2. Start with a Decision Frame. |
| Design output — in progress | You're mid-sprint. The incomplete sections are: [list]. Next: [current sprint stage]. |
| Design output — complete | Check the handoff checklist. If clear, hand off to your SDD tooling. |
| Implementation in progress | This workflow ends at the Design Output. Check your SDD tooling for build status. |
| Shipped, no diagnosis yet | You're in Loop 4. Check outcome metrics against what was expected at Gate 1. |
| Metrics moved | Problem solved. Mark done, update Opportunity Map, archive if appropriate. |
| Metrics flat | The solution didn't move the needle. Return to Loop 1 — reframe the problem, don't iterate on the solution. |
| Concept needs iteration | Return to Loop 2 with test data. |
| UNVALIDATED checkpoint reached | Return to Discovery Output validation. Validate the assumption now or make another explicit risk decision. |

---

**Section: Artefact completeness checks**

For each artefact, what the agent checks to assess whether it's complete. These are the fields an agent can inspect — they don't require human judgment to verify presence.

**Discovery output — complete when:**
- Problem hypothesis present and framed as user experience or outcome (not a feature or solution)
- At least one external source cited (field populated — agent cannot verify it's truly external)
- Status field set to `validated` or `UNVALIDATED` with a risk log entry present
- Sizing fields populated (reach, impact, effort — order of magnitude)

**Design output — complete when:**
- Chosen concept and reasoning present
- Rejected directions section present and non-empty
- Validation evidence and confidence level present
- Hard constraints present
- Feedback instrumentation requirements (Section 8) present and non-empty
- Open questions section present — either resolved or explicitly deferred with a note

**Risk log entry — complete when:**
- Assumption field present
- Validation signal field present (what evidence and by when)
- Review checkpoint field present (specific date, metric, or event)

---

**Section: Escalation conditions**

Things the agent cannot assess from file content alone, and must surface explicitly to the human rather than assuming:

- **External validation** — the agent can check whether the field is populated, but cannot verify that the source is truly external. Surface: "The discovery output cites [X] as external validation — confirm this is a source outside the team."
- **Confidence levels** — the agent can read a stated confidence level but cannot assess whether it's calibrated. Surface low-confidence items: "This design output is marked medium confidence with no stated path to higher confidence."
- **Checkpoint dates** — the agent can read a checkpoint date and compare to today. Surface: "The risk log checkpoint for [item] was [date]. It has passed — a decision is required."
- **User testing** — the agent cannot verify that sessions happened with real users. Surface: "The design output states testing was completed. Confirm sessions were run with real (not synthetic) users before proceeding to Loop 3."

---

**Section: Artefact quick-reference**

| Artefact | Location | Produced in | Purpose |
|---|---|---|---|
| Index | `.loops/_index.md` | Setup | Registry of all active and archived work |
| North Star | `.loops/_radiators/north-star.md` | Setup | What success looks like; always current |
| Opportunity Map | `.loops/_radiators/opportunity-map.md` | Loop 1 | Living map of the problem space |
| Decision Log | `.loops/_radiators/decision-log.md` | All loops | Every significant fork, append-only |
| Discovery output | `.loops/_problems/[id]-[slug]/discovery-output.md` | Loop 1 | Validated problem with evidence and sizing |
| Design output | `.loops/_problems/[id]/[id.n]-[slug]/design-output.md` | Loop 2 | Tested solution with decisions and rejected directions |
| Risk log entry | Inside the Decision Log | Any gate | Records when work proceeds with unvalidated assumptions |

---

### 2. `INSTALL.md`

**Location:** `/INSTALL.md` (repo root)

**Purpose:** How to get the workflow running in a project from scratch. Minimal — enough to unblock the first session.

---

**Section: What you're installing**

One paragraph: 4D Loops is a set of files. There's no package, no server, no tooling dependency. You copy files, create one folder, and you're running.

---

**Section: Minimum file set**

The files a team needs to copy into their project:

```
workflow-spec.md
agent-onboarding.md
conventions/folder-structure.md
playbooks/intake-questionnaire.md
templates/template-problem-hypothesis.md
templates/template-design-output.md
templates/radiator-north-star.md
templates/radiator-opportunity-map.md
templates/radiator-decision-log.md
INSTALL.md
```

Where to put them: a `/loops/` or `/docs/loops/` folder, or repo root — team's choice. The only constraint is that `agent-onboarding.md` and `workflow-spec.md` are findable at session start.

---

**Section: First-time setup**

Step-by-step:

1. Copy the minimum file set into your project
2. Create `.loops/` at your repo root
3. Create `.loops/_index.md` — copy the index template from `conventions/folder-structure.md`
4. Create `.loops/_radiators/` — copy the three radiator templates into it, rename to remove the `radiator-` prefix
5. Fill in `north-star.md` with your team's current North Star and outcome metrics (even rough ones)
6. Run the intake questionnaire — start at Q1

---

**Section: Distribution mechanism decision**

State the decision and its reasoning so teams know this was deliberate:

> **Decision:** Copy files manually. No package manager, no submodule, no CLI.
>
> **Why:** The simplest mechanism that works for any team immediately. No tooling dependency, full ownership of the files, works offline. The tradeoff is that updates to the core workflow require manual re-copy — acceptable at this stage.
>
> **What we're watching:** Whether teams need to stay in sync with upstream changes (which would favour a submodule) or whether they diverge intentionally (which would favour a copy). Git submodule and installable CLI are options being evaluated for Slice 3.

---

**Section: After setup**

One line: "Start at the intake questionnaire, or give your AI agent the `agent-onboarding.md` prompt and let it orient you."

---

### 3. README update

**Purpose:** Ensure README accurately reflects what exists now, with no "to be documented" stubs for things that exist.

**Specific changes:**

- **Loop 4 description** — currently says "to be documented." Update to describe it accurately: monitor outcome metrics, four exit routes (solved / flat / iterate / checkpoint), route findings back to the relevant loop. Reference `workflow-spec.md §The feedback loop`.

- **Repo structure** — add `agent-onboarding.md` and `INSTALL.md` once created.

- **"What's still to come"** — audit against current state. Remove anything that now exists. The list should reflect Slice 2 targets, not Slice 1 targets.

- **No new aspirational content** — don't describe things that don't exist. If it's not in the repo, it either goes on the "still to come" list or doesn't appear.

---

## Definition of done

Before Slice 1 is called complete:

- [ ] A person with no prior context can read `INSTALL.md`, set up `.loops/`, and reach their first intake questionnaire question without needing to read anything else first
- [ ] An AI agent reading `agent-onboarding.md` and a project's `.loops/` can produce a "you are here, next step is X" response for any valid workflow state
- [ ] README describes all four loops accurately with no placeholder stubs
- [ ] Distribution mechanism decision is recorded in `INSTALL.md`
- [ ] The full intake questionnaire path — Q1 through Q14 — can be walked using only files in the repo

---

## Order of work

1. Write `agent-onboarding.md`
2. Write `INSTALL.md` (references `agent-onboarding.md`, do second)
3. Update README
4. Walk the exit condition check from cold start
