# BMAD Adapter Guide — Mapping Rules

This file is read by the `/4d-to-bmad` slash command at runtime.
It defines how to transform a 4D Loops Design Output into BMAD artefacts.

---

## Output files

| File | Purpose | Consumed by |
|---|---|---|
| `bmad/project-brief.md` | BMAD PM agent input | PM agent |
| `bmad/further-details.md` | Human reference only | Not consumed by BMAD agents |

Both files are written inside the same directory as the source `design-output.md`.

---

## Source header (both files)

First line of both output files:

```
> 4D Loops source: {relative-path-to-design-output.md} (DO-{ID}, v{Version}, approved {date}). Sections tagged (4DL: §N).
```

If the source file has no approval date, write `unapproved`.

---

## UNVALIDATED flag

If the source file contains the `⚠️ UNVALIDATED` block, copy it verbatim immediately after the source header in `project-brief.md`.

**This must not be omitted.** If the flag is present in the source and absent in the output, the brief is incomplete.

---

## Section mapping — `project-brief.md`

Process sections in this order. Tag each section at the end: `(4DL: §N)`.

### Executive Summary
- **Source:** §1 Concept summary
- **Rule:** Direct copy.

### Problem Statement
- **Source:** §3 "Problem we're solving" + §2 "Current friction"
- **Rule:** Merge into one paragraph. Do not use subheadings.

### Target Users
- **Source:** §2 User and context table
- **Rule:** Convert table rows to prose. One short paragraph per user type. Do not reproduce the raw table.

### Proposed Solution
- **Source:** §4 Description + Key interaction or flow
- **Rule:** Combine description and flow. Preserve numbered steps if present. Omit "Why this concept" — that belongs in further-details if anywhere.

### Goals & Success Metrics
- **Source:** §3 "Success looks like"
- **Rule:** Direct copy.

### Required [FEEDBACK] Acceptance Criteria
- **Source:** §8 Feedback instrumentation table
- **Rule:** One line per row, formatted exactly as:

  ```
  [FEEDBACK] AC: When {signal_name} fires, {what_it_measures} must be observable. Minimum fidelity: {fidelity}. Links to: {outcome_metric}.
  ```

- **Enforcement:** Count rows in the §8 instrumentation table. Count `[FEEDBACK] AC:` lines written. If they do not match, the brief is incomplete — stop and report the discrepancy.

### MVP Scope — In Scope
- **Source:** §3 Hard constraints + Soft constraints
- **Rule:** Bulleted list. Label hard vs soft.

### Out of Scope
- **Source:** §6 Rejected directions — concept name and rejection reason columns only
- **Rule:** Table with two columns: `Concept` and `Why rejected`. **Do not include "Conditions to revisit" column** — that goes to `further-details.md`.

### Already-Decided Constraints
- **Source:** §5 Key decisions
- **Rule:** One entry per decision, formatted as:

  ```
  ⚠️ DECIDED (DL-XXX) — do not revisit: {decision text}
  ```

  Include rationale as a subordinate note, not as a separate section.

### Technical Constraints
- **Source:** §8 Technical constraints
- **Rule:** Direct copy.

### Design/UX Constraints
- **Source:** §8 Design/UX constraints
- **Rule:** Direct copy.

### Business/Compliance Constraints
- **Source:** §8 Business/compliance constraints
- **Rule:** Direct copy.

### Assumptions
- **Source:** §10 Assumptions carried forward
- **Rule:** Direct copy. Preserve confidence levels exactly as typed (high/medium/low).

### Open Questions
- **Source:** §9 Open questions
- **Rule:** Direct copy. For any question with a DL reference indicating resolution, append `[Resolved: DL-XXX]` inline after the question text.

---

## Section mapping — `further-details.md`

| Section | 4D source | Notes |
|---|---|---|
| Validation evidence | §7 | Copy verbatim |
| Conditions to revisit | §6 col 3 | One row per rejected concept; pair with concept name |
| Deferred opportunities | §11 | Copy verbatim if present |
| Review triggers | §12 | Copy verbatim if present |

---

## Non-negotiable rules

1. UNVALIDATED flag present → must appear at top of `project-brief.md`. Never omit.
2. Every §8 feedback signal → exactly one `[FEEDBACK] AC:` line. Missing = incomplete brief. Stop and flag.
3. §5 decisions → all prefixed `⚠️ DECIDED`. PM agent must not reopen.
4. §6 rejection table in brief → no "conditions to revisit" column.
5. Every section in `project-brief.md` → tagged `(4DL: §N)` at end.

---

## Completion report

After writing both files, report:

```
Sections mapped to project-brief.md: [list]
Sections moved to further-details.md: [list]
[FEEDBACK] ACs written: N (expected: M)
Missing or empty source sections: [list, or "none"]
Warnings: [list, or "none"]
```
