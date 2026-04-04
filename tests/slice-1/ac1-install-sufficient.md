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

Two directories are created to model the real-world scenario:

- **source** — a copy of the 4D Loops repo, representing what the user has downloaded
- **project** — an empty directory representing their own project where they will set up the workflow

The sub-agent is only told about these two directories and instructed to follow
`INSTALL.md`. The test does not prescribe which files to copy or what to create —
that is entirely the job of `INSTALL.md`.

```bash
SOURCE=/tmp/4dl-test-ac1-source
PROJECT=/tmp/4dl-test-ac1-project
rm -rf "$SOURCE" "$PROJECT"
cp -r /home/user/4d-loops "$SOURCE"
mkdir -p "$PROJECT"
```

Verify setup:
```bash
ls "$SOURCE/INSTALL.md" && echo "SOURCE ready" && ls "$PROJECT" && echo "PROJECT empty"
```

---

## Test

Spawn a sub-agent with access to both directories.

**Sub-agent prompt (send exactly as written):**

> You are a software developer. You want to adopt a workflow system called 4D Loops
> in your project. You have no prior knowledge of what it is or how it works.
>
> The 4D Loops files you have downloaded are at: `/tmp/4dl-test-ac1-source`
> Your project directory is: `/tmp/4dl-test-ac1-project`
>
> Your only instruction is: **read `/tmp/4dl-test-ac1-source/INSTALL.md` and follow it**
> to set up the workflow in your project directory.
>
> Important rules:
> - Read `INSTALL.md` first, before opening any other file.
> - Follow whatever instructions it gives — do not invent steps that aren't in INSTALL.md.
> - All setup actions (creating folders, copying files) should happen inside `/tmp/4dl-test-ac1-project`.
>
> When you are done, report back with these exact fields:
>
> **CREATED:**
> List every directory and file you created inside the project directory during setup.
>
> **FIRST QUESTION:**
> Which question number in the intake questionnaire would you now go to?
> (Just the number, e.g. "Q1")
>
> **NEEDED OTHER FILES:**
> Did you need to open any file other than `INSTALL.md` to understand what to do
> and get started? Answer Yes or No, then explain briefly.
>
> **BLOCKED:**
> Were you blocked at any point — a step that referred to something that didn't
> exist, or an instruction you couldn't follow? Answer Yes or No, then describe
> the blocker if Yes.

**After the sub-agent completes, evaluate the following assertions:**

### Assertion 1 — `.loops/` directory created in the project directory
- Check: `ls /tmp/4dl-test-ac1-project/.loops/` exits without error
- PASS if the directory exists
- FAIL message: "Sub-agent did not create .loops/ — INSTALL.md either didn't instruct this or was unclear"

### Assertion 2 — `_index.md` created
- Check: `ls /tmp/4dl-test-ac1-project/.loops/_index.md`
- PASS if the file exists
- FAIL message: "Sub-agent did not create .loops/_index.md — INSTALL.md either didn't instruct this or was unclear"

### Assertion 3 — `_radiators/` created with all three radiators
- Check: `ls /tmp/4dl-test-ac1-project/.loops/_radiators/`
- PASS if directory exists and contains `north-star.md`, `opportunity-map.md`, `decision-log.md`
- FAIL message: "Sub-agent did not create _radiators/ or is missing radiator files — INSTALL.md either didn't instruct this or was unclear"

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
rm -rf /tmp/4dl-test-ac1-source /tmp/4dl-test-ac1-project
```
