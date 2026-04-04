# Test AC5 — Full intake questionnaire Q1–Q14 walkable using only repo files

**AC:** "The full intake questionnaire path — Q1 through Q14 — can be walked using
only files in the repo."

**Source:** `docs/plans/slice-1-traversable.md` § Definition of done

**Expected baseline status:** FAIL — Q13 references "Adapter Guide ready for your
chosen SDD tooling" and the Adapter Guide is listed as "still to come" in the README.
No Adapter Guide file exists in the repo.

---

## Precondition checks

1. `playbooks/intake-questionnaire.md` exists
   - Check: `ls /home/user/4d-loops/playbooks/intake-questionnaire.md`
   - Fail message: `intake-questionnaire.md does not exist — AC5 FAIL (unexpected)`

---

## Setup

No temp directory needed for the inline assertions. The sub-agent walkthrough uses
a temp dir with the full repo file set.

---

## Test — Part 1: Static file reference audit (inline)

Read `playbooks/intake-questionnaire.md` and verify every file or folder reference
within it resolves to something that exists in the repo.

### File and folder references to check

Walk through each question and check every explicit file/folder reference:

| Question | Reference | Expected location | Check |
|---|---|---|---|
| Q1 | `.loops/` folder | Created by team during setup — not in repo (expected) | Skip — runtime artefact |
| Q1 | `_index.md` | `.loops/_index.md` — runtime artefact | Skip |
| Q4 | `_discovery/_questions/` | `.loops/_discovery/_questions/` — runtime artefact | Skip |
| Q5 | `_discovery/_data/` | `.loops/_discovery/_data/` — runtime artefact | Skip |
| Q5 | `_discovery/_findings/` | `.loops/_discovery/_findings/` — runtime artefact | Skip |
| Q5 | `_discovery/_insights/` | `.loops/_discovery/_insights/` — runtime artefact | Skip |
| Q6 | problem hypothesis template | `templates/template-problem-hypothesis.md` | **Must exist** |
| Q7 | `_index.md` | Runtime artefact | Skip |
| Q7 | `_problems/` | Runtime artefact | Skip |
| Q9 | "Loop 2" / "Decision Frame" | `workflow-spec.md` (§Loop 2) | **Must exist** |
| Q12 | design output sections | `templates/template-design-output.md` | **Must exist** |
| Q13 | "Adapter Guide" | Should exist in repo | **Must exist** |
| Q13 | SDD tooling handoff | `workflow-spec.md` (§SDD Handoff) | **Must exist** |

### Assertion 1 — Problem hypothesis template exists

- Check: `ls /home/user/4d-loops/templates/template-problem-hypothesis.md`
- PASS if file exists
- FAIL message: "template-problem-hypothesis.md missing — Q6 has a dead end"

### Assertion 2 — Workflow spec exists and covers Loop 2

- Check: `ls /home/user/4d-loops/workflow-spec.md`
- Check: `workflow-spec.md` contains content about Loop 2 / Decision Frame
- PASS if file exists and contains "Decision Frame" or "Loop 2"
- FAIL message: "workflow-spec.md missing or does not cover Loop 2 — Q9 has a dead end"

### Assertion 3 — Design output template exists

- Check: `ls /home/user/4d-loops/templates/template-design-output.md`
- PASS if file exists
- FAIL message: "template-design-output.md missing — Q12 checklist references it"

### Assertion 4 — Adapter Guide exists (Q13 blocker)

This is the expected current failure point.

- Check: an Adapter Guide file exists somewhere in the repo. Look for:
  - `adapter-guide.md` at repo root
  - `playbooks/adapter-guide.md`
  - Any file with "adapter" in the name: `ls /home/user/4d-loops/**/*adapter*`
  - Any file with "adapter guide" mentioned in Q13 that has a corresponding file
- PASS if an Adapter Guide file is found
- FAIL message: "No Adapter Guide file found in repo — Q13 references it as a required
  checklist item ('Adapter Guide ready for your chosen SDD tooling') with no file to
  point to. A team cannot complete Q13 or proceed to Q14 without it. Options:
  (a) create a minimal adapter-guide.md stub, or (b) update Q13 to remove the
  Adapter Guide requirement for Slice 1."

### Assertion 5 — Workflow spec covers the SDD handoff

- Check: `workflow-spec.md` contains content matching the Q13 handoff concept
  (look for "handoff", "Loop 3", or "SDD")
- PASS if found
- FAIL message: "workflow-spec.md does not cover the SDD handoff — Q13 has no backing content"

### Assertion 6 — All question routing is internally consistent

Verify that every routing target within the questionnaire refers to a valid question
number that exists in the file. There should be no routing to a question that doesn't exist.

Check the following routing chains are fully defined:
- Q1 → Q2, Q3 (both exist ✓)
- Q2 → Q6, Q9, Q10, Q12, Q14 (all must exist)
- Q3 → Q4 (exists ✓)
- Q4 → Q5 (exists ✓); stop
- Q5 → Q5B, Q5C, Q6 (all must exist)
- Q6 → Q7; stop (exists ✓)
- Q7 → Q8 (exists ✓)
- Q8 → Q9; stop (exists ✓)
- Q9 → Q12; Loop 2 (exists ✓)
- Q10 → Q11 (exists ✓)
- Q11 → Q9, Q12; stop (exists ✓)
- Q12 → Q13; stop (exists ✓)
- Q13 → Loop 3; stop (exists ✓)
- Q14 → Q6, Q10, Q8; done; stop (all exist ✓)

- Check: read `intake-questionnaire.md` and confirm all Q references in routing
  arrows refer to questions that are defined in the file
- PASS if all routing targets exist
- FAIL message: list any routing targets that point to undefined questions

---

## Test — Part 2: End-to-end walkthrough (sub-agent)

Spawn a sub-agent to walk the questionnaire from cold start and confirm no dead ends
are hit on the happy path through the system.

### Setup

```bash
TEMP=/tmp/4dl-test-ac5
rm -rf "$TEMP" && mkdir -p "$TEMP/playbooks" "$TEMP/templates" "$TEMP/conventions"
REPO=/home/user/4d-loops

# Copy only the files available to a team that has completed INSTALL.md setup
# (i.e. the minimum file set — no .loops/ state, as we're testing the questionnaire itself)
cp "$REPO/workflow-spec.md"                         "$TEMP/"          2>/dev/null || true
cp "$REPO/agent-onboarding.md"                      "$TEMP/"          2>/dev/null || true
cp "$REPO/playbooks/intake-questionnaire.md"        "$TEMP/playbooks/"
cp "$REPO/templates/template-problem-hypothesis.md" "$TEMP/templates/"
cp "$REPO/templates/template-design-output.md"      "$TEMP/templates/"
cp "$REPO/templates/radiator-north-star.md"         "$TEMP/templates/"
cp "$REPO/templates/radiator-opportunity-map.md"    "$TEMP/templates/"
cp "$REPO/templates/radiator-decision-log.md"       "$TEMP/templates/"
cp "$REPO/conventions/folder-structure.md"          "$TEMP/conventions/"
```

### Sub-agent prompt

> You are a new team member with no prior knowledge of 4D Loops. You have been
> given the files in this directory.
>
> Your task: walk through the intake questionnaire (`playbooks/intake-questionnaire.md`)
> from Q1, following the path for a team that:
> - Has no existing `.loops/` state (answer Q1 → No)
> - Has a hunch about a user problem but no external confirmation yet (answer Q3 → No for solution, Q4 → No for external confirmation)
>
> For each question you encounter:
> 1. State the question number
> 2. State which answer applies for this scenario
> 3. State where you are routed next
> 4. If you're told to "Stop here", note it
> 5. If you hit a reference to a file or template, check whether that file exists in
>    this directory. Report it as FOUND or MISSING.
>
> Continue until you reach a "Stop here" or terminal state.
>
> At the end, report:
>
> **PATH TAKEN:** List the questions you visited in order (e.g. Q1 → Q3 → Q4 → Stop)
>
> **DEAD ENDS:** Any question where the routing led to a file that was MISSING.
>
> **STUCK AT:** The question where you stopped and why.

### Assertions

#### Assertion 7 — Sub-agent reaches a valid terminal state

- Evaluate: "STUCK AT" field in sub-agent output
- PASS if sub-agent reaches "Stop here" at Q4 (expected for hunch-only scenario)
  OR reaches Q4 and correctly stops
- FAIL message: "Sub-agent got stuck somewhere unexpected — record where and why"

#### Assertion 8 — No dead ends reported on happy path

- Evaluate: "DEAD ENDS" field in sub-agent output
- PASS if "None" or empty
- FAIL message: Record every dead end the sub-agent found, with the question and
  missing file reference

### Second walkthrough — happy path to Q14

Run a second sub-agent with the same files but a different scenario:

> Follow the intake questionnaire for a team that:
> - Has no existing `.loops/` (Q1 → No)
> - Has a preformed solution in mind (Q3 → Yes)
> - Cannot state the underlying problem in one sentence (Q3 → treat as hunch → Q4)
> - Has external confirmation the problem exists (Q4 → Yes)
> - Has a validated pattern across multiple sources and can interpret it (Q5 → pattern, Q5B → confirming, Q5C → Yes → Q6)
> - Can frame the problem (Q6 → Yes → Q7)
> - Problem is new, never worked on before (Q7 → No → Q8)
> - Has full evidence: external source cited, framed as user problem, confirmed (Q8 → Yes → Q9)
> - Has a candidate direction but untested (Q9 → "Have a candidate direction" → Loop 2)
> - Assume Loop 2 completes: design output is complete (Q12 → Yes → Q13)
> - Assume all Q13 checklist items are ready including Adapter Guide → Q13 all checked → Loop 3
> - Assume shipped and outcome metrics moved (Q14 → "Outcome metrics moved" → Done)
>
> For each question, state the question, your answer, and where you go next.
> Report every file reference as FOUND or MISSING.
> Report PATH TAKEN and DEAD ENDS.

#### Assertion 9 — Q14 is reachable from Q1

- Evaluate: "PATH TAKEN" field — does it include Q14?
- PASS if sub-agent reaches Q14
- FAIL message: "No path from Q1 reaches Q14 — questionnaire has a gap before Q14"

#### Assertion 10 — Any dead ends are recorded for triage

- Evaluate: "DEAD ENDS" field from second walkthrough
- PASS if no dead ends, OR if dead ends are recorded with enough detail to action
- Note: a FAIL here does not mean the test infrastructure is broken — it surfaces
  a gap in the repo that needs to be fixed before AC5 can pass

---

## Pass criteria

All ten assertions must pass. Record which fail and what the specific gap is.

The most likely current failure is Assertion 4 (Adapter Guide missing), which cascades
to Assertions 9 and 10 (Q14 unreachable via Q13).

---

## Teardown

```bash
rm -rf /tmp/4dl-test-ac5
```
