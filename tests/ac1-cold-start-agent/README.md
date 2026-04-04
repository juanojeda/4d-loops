# AC1 — Cold Start Agent Test

**AC:** A person with no prior context can read `INSTALL.md`, set up `.loops/`, and reach their first intake questionnaire question without needing to read anything else first.

This test is stronger than the bash structural check (`ac1-install-cold-start.sh`). Rather than verifying that INSTALL.md *looks* followable, it actually follows the instructions in a clean environment and asserts the result.

---

## How to run

### Step 1 — Create a clean working directory

```bash
COLD_START_DIR=$(mktemp -d)
echo "Working in: $COLD_START_DIR"
```

### Step 2 — Spawn a cold-start subagent

Spawn a subagent with the following prompt, substituting `[REPO_ROOT]` and `[COLD_START_DIR]`:

---

> You are a new team member who has just been handed the 4D Loops workflow. You have access to exactly one file to start: `[REPO_ROOT]/INSTALL.md`.
>
> **Your task:** Follow the instructions in `INSTALL.md` to set up 4D Loops in the project directory at `[COLD_START_DIR]`.
>
> **Constraints — you must follow these exactly:**
>
> 1. You may only take actions that `INSTALL.md` explicitly tells you to take. Do not fill in gaps with prior knowledge.
> 2. When `INSTALL.md` tells you to copy files, copy them from `[REPO_ROOT]` into `[COLD_START_DIR]`.
> 3. You may read any file that `INSTALL.md` explicitly tells you to read (e.g. files it says to copy a template from).
> 4. Complete steps 1–5 of the first-time setup. Stop before step 6 (running the intake questionnaire) — the test only covers setup, not the questionnaire session itself.
> 5. If at any point you need information that `INSTALL.md` does not provide and cannot be found in a file `INSTALL.md` told you to read, **stop immediately** and report:
>    `BLOCKED: [describe exactly what instruction is missing or unclear]`
> 6. If you complete setup successfully, report:
>    `SETUP COMPLETE`
>    followed by a list of every file and directory you created.

---

### Step 3 — Evaluate the subagent's result

**If the subagent reported `BLOCKED`:**
- Test FAILS. Record the blocker reason — it identifies a gap in `INSTALL.md`.

**If the subagent reported `SETUP COMPLETE`:**
- Run the bash assertions below against `[COLD_START_DIR]`.

### Step 4 — Run post-setup assertions

```bash
COLD_START_DIR="<value from step 1>"
REPO_ROOT="<repo root>"

assert_dir_exists  "$COLD_START_DIR/.loops"
assert_file_exists "$COLD_START_DIR/.loops/_index.md"
assert_dir_exists  "$COLD_START_DIR/.loops/_radiators"
assert_file_exists "$COLD_START_DIR/.loops/_radiators/north-star.md"
assert_file_exists "$COLD_START_DIR/.loops/_radiators/opportunity-map.md"
assert_file_exists "$COLD_START_DIR/.loops/_radiators/decision-log.md"
```

You can run these using `tests/lib/assert.sh`:

```bash
source tests/lib/assert.sh
# ... paste the assert calls above ...
suite_summary "AC1: cold-start agent setup"
```

### Step 5 — Clean up

```bash
rm -rf "$COLD_START_DIR"
```

---

## Pass condition

- Subagent reports `SETUP COMPLETE` (not `BLOCKED`)
- All six post-setup assertions pass

A `BLOCKED` report is a content failure in `INSTALL.md`, not a test failure — it means the instructions are incomplete and `INSTALL.md` needs to be fixed before AC1 can be satisfied.

---

## What this test does that the bash test does not

`ac1-install-cold-start.sh` checks that `INSTALL.md` *has* the required sections. This test checks that the instructions are *actually followable in sequence* — that no step assumes knowledge from outside `INSTALL.md`, that file references resolve, and that following the steps produces the right output structure.
