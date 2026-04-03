# Decision Log
**Product:** [product name]  
**Status:** append-only — entries are never edited or deleted  
**Owner:** [name — person responsible for ensuring entries are made]  
**Last updated:** [date]

---

## How to use this log

Every significant fork in the road gets an entry. A fork is significant if:
- It determines which problem gets worked on next
- It determines which solution direction gets built
- It involves a conscious risk being taken (UNVALIDATED brief proceeding)
- It closes a previously open question that downstream work depends on

Entries are appended in chronological order. Never edit or delete an entry — if a decision is reversed, add a new entry that references the original and explains what changed and why.

**This log is read by both humans and AI agents.** Agents use it to understand the boundaries of the current solution space, avoid re-proposing rejected directions, and understand which assumptions are load-bearing.

---

## Entry format

Each entry uses the following structure. Copy the template block and fill it in at the moment the decision is made — not reconstructed afterwards.

```
### [DL-XXX] [Short title of the decision]
Date: [date]
Type: [problem selection | solution direction | risk accepted | question closed]
Made by: [name]
Refs: [Discovery Output ID / Sprint ID / other relevant artefact]

**Decision:**
[One to two sentences. What was decided?]

**Reasoning:**
[Why this, over the alternatives? Reference the Decision Frame or north star where relevant.]

**Alternatives considered:**
- [Option]: [why it was rejected — specific, not comparative]
- [Option]: [why it was rejected]

**When we'd revisit this:**
[What conditions or new evidence would warrant reopening this decision?]

**Confidence:** [high | medium | low]
**If medium or low:** [what would increase confidence?]
```

For risk log entries (UNVALIDATED briefs proceeding), use this format instead:

```
### [DL-XXX] ⚠️ Risk accepted — [short description]
Date: [date]
Type: risk accepted
Made by: [name]
Refs: [Discovery Output ID]

**Assumption being accepted:**
[What are we treating as true without validation?]

**Validation signal:**
[What specific evidence would confirm or refute this, and by when?]

**Review checkpoint:**
[Specific trigger — date, metric threshold, or event — at which this is revisited.]

**Fallback:**
[If the assumption proves wrong, what do we do?]
```

---

## Log entries

*Entries below, newest first.*

---

### [DL-001] [Example: Prioritised onboarding drop-off over search discoverability]
Date: [date]  
Type: problem selection  
Made by: [name]  
Refs: PB-003, PB-007

**Decision:**
Prioritised onboarding drop-off (PB-003) over search discoverability (PB-007) for the next sprint.

**Reasoning:**
Onboarding drop-off affects 60% of new users in their first session and directly blocks north star metric (week-two retention). Search discoverability affects engaged users who are already retained — important but not urgent.

**Alternatives considered:**
- Search discoverability (PB-007): real problem but affects a smaller, already-retained cohort. Deprioritised, not closed.

**When we'd revisit this:**
If week-two retention improves to target and search becomes the next drop-off point in funnel analysis.

**Confidence:** high

---

*Add new entries above this line, newest first.*

