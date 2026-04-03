# Design Output
**ID:** DO-[XXX]
**Status:** [draft | in-review | approved | superseded]
**Version:** [n]
**Created:** [date]
**Author:** [name]
**Source Discovery Output:** DO-[XXX]
**Source Decision Log entries:** DL-[XXX], DL-[XXX]
**Sprint ref:** Sprint-[XXX]
**Approved by:** [name]
**Approval date:** [date]

> ⚠️ **UNVALIDATED** — this output is based on an unvalidated problem assumption. See Risk log entry DL-[XXX]. Treat all problem-level claims as hypotheses, not facts.
> *(Remove this block if the Discovery Output passed validation.)*

---

## 1. Concept summary

> [One paragraph. What are we building, for whom, and what problem does it solve? Written for a new team member or agent with no prior context. Do not assume familiarity with earlier discussions.]

---

## 2. User and context

**Confidence:** [validated | assumed]  
**Evidence ref:** [interview IDs, analytics source, or note if assumed]

| Field | Detail |
|---|---|
| **Who** | [specific user type — not "users in general"] |
| **Situation** | [what they're doing when they encounter this problem] |
| **Device / platform** | [where this will be used] |
| **Prior context** | [what they've already done or know before reaching this point] |
| **Goal** | [what they're trying to accomplish] |
| **Current friction** | [what's getting in the way — links back to problem hypothesis] |

---

## 3. Decision Frame

*The frame used to evaluate concepts during the sprint. Included here so downstream agents understand what the solution is optimised for.*

**Problem we're solving:**  
[One sentence — should match the Discovery Output exactly.]

**Success looks like:**  
[Outcome, not feature. What would be measurably different for the user if this works?]

**Hard constraints:**  
*(Things the solution must respect. Non-negotiable.)*
- [constraint]
- [constraint]

**Soft constraints:**  
*(Things we'd prefer but could trade off if necessary.)*
- [constraint]
- [constraint]

**What we're explicitly not solving here:**  
- [out of scope item — and why it's out of scope]
- [out of scope item]

---

## 4. Chosen concept

**Concept name:** [short name used during sprint]  
**Confidence in this direction:** [high | medium | low]

### Description
[Two to four sentences describing the solution. What does it do? How does it work from the user's perspective? Avoid implementation detail — describe the experience.]

### Key interaction or flow
[Describe the core user interaction in plain language. If a prototype was built, reference it here: `[prototype link or file ref]`.]

### Why this concept
[One to two sentences connecting this concept directly to the Decision Frame. Why does this approach serve the stated user and problem better than the alternatives?]

---

## 5. Key decisions

*Decisions made during the sprint that the spec and build process must respect. Each entry should match a Decision Log entry.*

### Decision 1 — [short title]
**DL ref:** DL-[XXX]  
**Decision:** [what was decided]  
**Rationale:** [why — reference the Decision Frame or constraints]  
**Impact on spec:** [what this means for the spec author or build agent]

### Decision 2 — [short title]
**DL ref:** DL-[XXX]  
**Decision:** [what was decided]  
**Rationale:** [why]  
**Impact on spec:** [what this means downstream]

*(Add entries as needed. One entry per significant decision.)*

---

## 6. Rejected directions

*This section is required. It defines what is out of scope and why. Agents must not re-propose these directions without new evidence that changes the evaluation.*

| Concept | Why it was rejected | Conditions to revisit |
|---|---|---|
| [concept name] | [specific failure mode against the Decision Frame — not "it wasn't as good"] | [what would need to change for this to be worth reconsidering] |
| [concept name] | [failure mode] | [conditions] |

---

## 7. Validation evidence

**Testing method:** [usability sessions | hallway testing | synthetic persona review | not tested]  
**Participants:** [n real users | note if synthetic only]  
**When:** [date or sprint week]  
**Stimulus used:** [lo-fi prototype | wireframe | description only]

### What we tested
[What specific assumptions or risks did the testing target?]

### What we learned
[Key findings. Be specific. "Users understood the flow" is not a finding. "3 of 5 users completed onboarding without prompting; 2 missed the skip option" is a finding.]

### How this changed the concept
[What was adjusted after testing, if anything? If nothing changed, say so and why.]

### Remaining uncertainty
[What do we still not know? What risks remain going into build?]

**Overall confidence in concept:** [high | medium | low]  
**If medium or low:** [what would increase confidence, and when will we know?]

---

## 8. Constraints for the spec

*Hard boundaries the spec must respect. These are non-negotiable inputs to the build loop — not suggestions.*

**Technical constraints:**
- [constraint — e.g. must work offline, must use existing auth system]

**Design / UX constraints:**
- [constraint — e.g. must conform to existing design system, must be accessible at WCAG AA]

**Business / compliance constraints:**
- [constraint — e.g. must not store PII, must comply with existing data retention policy]

**Platform constraints:**
- [constraint — e.g. iOS and Android, minimum OS version]

**Feedback instrumentation requirements** *(required — spec is incomplete without this)*

The following signals must be capturable after ship for the feedback loop to close. For each, the spec must include a `[FEEDBACK]` acceptance criterion. A spec with no `[FEEDBACK]` ACs is incomplete.

| Signal name | What it measures | Links to outcome metric | Minimum fidelity |
|---|---|---|---|
| [event name — e.g. onboarding_completed] | [the user behaviour this captures] | [metric from North Star doc] | [event fires / funnel step / time-on-task / error rate] |
| [event name] | [behaviour] | [metric] | [fidelity] |

**Guidance:** These are not implementation instructions — they define what must be observable. The spec author decides how to implement them. If a signal cannot be captured with the current architecture, that is an open question (Section 9), not a reason to omit it.

---

## 9. Open questions

*Things unresolved that the spec author or build agent needs to handle. Each question must be answered before or during spec writing — not deferred to build.*

| # | Question | Owner | Required by |
|---|---|---|---|
| 1 | [question] | [name or role] | [date or milestone] |
| 2 | [question] | [name or role] | [date or milestone] |

---

## 10. Assumptions carried forward

*Claims in this brief that have not been fully validated. Agents working from this brief must treat these as hypotheses and flag them in downstream artefacts.*

| # | Assumption | Confidence | What would change it |
|---|---|---|---|
| 1 | [assumption] | [high / medium / low] | [evidence or event that would confirm or refute] |
| 2 | [assumption] | [high / medium / low] | [evidence or event] |

---

## AI agent guidance

When consuming this Design Output:

- **Section 5 (Key decisions)** defines what has already been decided. Do not revisit these without a new Decision Log entry.
- **Section 6 (Rejected directions)** defines what is out of scope. Do not propose these approaches unless the conditions to revisit have been met.
- **Section 8 (Constraints)** contains non-negotiable boundaries. Flag any spec requirement that would violate these before proceeding. The feedback instrumentation requirements in Section 8 must each produce at least one `[FEEDBACK]` acceptance criterion in the spec — if any are missing, the spec is incomplete.
- **Section 9 (Open questions)** must be resolved before the spec is complete. If you cannot resolve a question, surface it explicitly rather than making an assumption.
- **Section 10 (Assumptions)** lists claims that are not fully validated. Carry these forward as typed assumptions in the spec — do not treat them as facts.
- If this brief carries an **UNVALIDATED** flag, treat all problem-level claims in Section 2 as hypotheses. The solution direction may be sound; the problem framing may not be.

