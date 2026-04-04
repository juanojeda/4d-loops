# Test AC1 — INSTALL.md is sufficient for first-time setup

**AC:** "A person with no prior context can read `INSTALL.md`, set up `.loops/`, and
reach their first intake questionnaire question without needing to read anything else first."

**Source:** `docs/plans/slice-1-traversable.md` § Definition of done

**Expected baseline status:** FAIL — `INSTALL.md` does not exist at repo root.

---

## Precondition checks

Run these before setup. If any check fails, record `FAIL` with the check that failed
and skip the rest of this test.

1. `INSTALL.md` exists at `/home/user/4d-loops/INSTALL.md`
   - Check: `ls /home/user/4d-loops/INSTALL.md`
   - Fail message: `INSTALL.md does not exist — AC1 FAIL (file missing)`

---

## Setup

Create an isolated temp directory simulating a fresh project that has downloaded
the 4D Loops files. The directory contains only the files a new user would have.

```bash
REPO=/home/user/4d-loops
TEMP=/tmp/4dl-test-ac1
rm -rf "$TEMP" && mkdir -p "$TEMP"

# Copy INSTALL.md — the only file the test persona starts from
cp "$REPO/INSTALL.md" "$TEMP/"

# Copy the minimum file set as documented in INSTALL.md
# (These represent the files downloaded from the repo)
mkdir -p "$TEMP/conventions" "$TEMP/playbooks" "$TEMP/templates"
cp "$REPO/workflow-spec.md"                            "$TEMP/"          2>/dev/null || true
cp "$REPO/agent-onboarding.md"                         "$TEMP/"          2>/dev/null || true
cp "$REPO/conventions/folder-structure.md"             "$TEMP/conventions/"
cp "$REPO/playbooks/intake-questionnaire.md"           "$TEMP/playbooks/"
cp "$REPO/templates/template-problem-hypothesis.md"    "$TEMP/templates/"
cp "$REPO/templates/template-design-output.md"         "$TEMP/templates/"
cp "$REPO/templates/radiator-north-star.md"            "$TEMP/templates/"
cp "$REPO/templates/radiator-opportunity-map.md"       "$TEMP/templates/"
cp "$REPO/templates/radiator-decision-log.md"          "$TEMP/templates/"
```

Verify setup succeeded:
```bash
ls "$TEMP"
```

---

## Test

Spawn a sub-agent with the following configuration:

**Working directory for sub-agent:** `/tmp/4dl-test-ac1`

**Sub-agent prompt (send exactly as written):**

> You are a software developer. You have just discovered a workflow system called
> 4D Loops and copied its files into this directory. You have no prior knowledge
> of what it is or how it works.
>
> Your only instruction is: **read `INSTALL.md` and follow it**.
>
> Do the following:
> 1. Read `INSTALL.md` — and only `INSTALL.md` — first.
> 2. Follow its instructions to set up the workflow in this directory.
> 3. When you are done, report back with these exact fields:
>
> **CREATED:**
> List every directory and file you created during setup.
>
> **FIRST QUESTION:**
> Which question number in the intake questionnaire would you now go to?
> (Just the number, e.g. "Q1")
>
> **NEEDED OTHER FILES:**
> Did you need to open any file other than `INSTALL.md` to understand
> what to do and get started? Answer Yes or No, then explain briefly.
>
> **BLOCKED:**
> Were you blocked at any point — a step that referred to something that
> didn't exist, or an instruction you couldn't follow? Answer Yes or No,
> then describe the blocker if Yes.

**After the sub-agent completes, evaluate the following assertions:**

### Assertion 1 — `.loops/` directory created
- Check: `ls /tmp/4dl-test-ac1/.loops/` exits without error
- PASS if the directory exists
- FAIL message: "Sub-agent did not create .loops/"

### Assertion 2 — `_index.md` created
- Check: `ls /tmp/4dl-test-ac1/.loops/_index.md`
- PASS if the file exists
- FAIL message: "Sub-agent did not create .loops/_index.md"

### Assertion 3 — `_radiators/` created with all three radiators
- Check: `ls /tmp/4dl-test-ac1/.loops/_radiators/`
- PASS if directory exists and contains `north-star.md`, `opportunity-map.md`, `decision-log.md`
- FAIL message: "Sub-agent did not create _radiators/ or is missing radiator files"

### Assertion 4 — Sub-agent reports starting at intake questionnaire
- Evaluate: the `FIRST QUESTION` field in sub-agent output
- PASS if value is `Q1` (or equivalent — "the first question", "Question 1")
- FAIL message: "Sub-agent did not reach the intake questionnaire as the next step"

### Assertion 5 — Sub-agent did not need other files to get started
- Evaluate: the `NEEDED OTHER FILES` field in sub-agent output
- PASS if answer is `No`
- FAIL message: "INSTALL.md required the user to read other files before starting"

### Assertion 6 — Sub-agent was not blocked
- Evaluate: the `BLOCKED` field in sub-agent output
- PASS if answer is `No`
- FAIL message: Record the blocker the sub-agent described — this is a gap in INSTALL.md

---

## Pass criteria

All six assertions must pass. If any assertion fails, the test is FAIL. Record
the first failing assertion and its message.

---

## Teardown

```bash
rm -rf /tmp/4dl-test-ac1
```
