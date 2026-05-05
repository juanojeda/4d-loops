# BMAD Adapter — Agent Spec

## What this is

Self-contained brief for an AI agent to build and maintain the 4D Loops → BMAD adapter.
Read this file, then build the outputs listed in §2.

---

## 1. Background

### 4D Loops

4D Loops is a design-and-build framework structured around four loops: Discovery, Design, Build, Diagnose.
Each loop produces artefacts that feed the next.

The **Design loop** produces a **Design Output** (`design-output.md`) — a 12-section document that captures:
- What was decided and why (§4, §5)
- What was rejected (§6)
- Constraints the build must respect (§8)
- Unresolved assumptions (§10)

Design Output template: `templates/template-design-output.md`

### BMAD

BMAD (Breakthrough Method for Agile AI-Driven Development) is an AI-agent orchestration framework.
Its agent chain is: **Analyst → PM → Architect → SM → Dev**.

- The **Analyst** produces a `project-brief.md` — a structured brief that gives the PM agent enough context to generate a full PRD without discovery conversations.
- PM consumes `project-brief.md` directly; if it is complete, PM skips discovery entirely.

### Why this adapter exists

A 4D Loops Design Output covers the same ground as a BMAD Analyst brief — problem, users, solution, constraints, decisions, assumptions.
This adapter transforms Design Output → `project-brief.md` so the BMAD PM agent can be handed the brief directly, with no conversation needed.

The mapping is mechanical. The adapter must enforce four structural rules (§4 below) that protect downstream agents from re-opening settled decisions or acting on incomplete instrumentation.

---

## 2. What to build

When this spec is executed, the agent creates:

```
adapters/bmad/
  adapter-guide.md          ← mapping rules (this file instructs the slash command)

.claude/commands/
  4d-to-bmad.md             ← slash command
```

When the slash command runs (in a consuming project):
```
{sprint-folder}/bmad/
  project-brief.md          ← BMAD PM agent input
  further-details.md        ← human reference only (not consumed by BMAD agents)
```

---

## 3. Section mapping

### Into `project-brief.md`

| Section | 4D Loops source | Rule |
|---|---|---|
| Source header (top of file) | Header block (ID, Version, Approval date, file path) | `> 4D Loops source: {path} (DO-{ID}, v{Version}, approved {date}). Sections tagged (4DL: §N).` |
| UNVALIDATED warning | Header UNVALIDATED flag | If flag present → copy verbatim as callout at top; must not be omitted |
| Executive Summary | §1 | Direct copy `(4DL: §1)` |
| Problem Statement | §3 "Problem we're solving" + §2 "Current friction" | Merge into one paragraph `(4DL: §2, §3)` |
| Target Users | §2 User and context table | Convert table to persona prose `(4DL: §2)` |
| Proposed Solution | §4 Description + Key interaction flow | Combine; keep numbered steps `(4DL: §4)` |
| Goals & Success Metrics | §3 "Success looks like" | Direct copy `(4DL: §3)` |
| Required [FEEDBACK] ACs | §8 Feedback instrumentation table | One line per signal: `[FEEDBACK] AC: When {signal_name} fires, {what_it_measures} must be observable. Minimum fidelity: {fidelity}. Links to: {outcome_metric}. (4DL: §8)` |
| MVP Scope — In Scope | §3 Hard + soft constraints | Bulleted `(4DL: §3)` |
| Out of Scope | §6 Rejected directions | Table: concept name + one-line rejection reason only — no "conditions to revisit" column `(4DL: §6)` |
| Already-Decided Constraints | §5 Key decisions | Each prefixed `⚠️ DECIDED (DL-XXX) — do not revisit:` `(4DL: §5)` |
| Technical Constraints | §8 Technical constraints | Direct `(4DL: §8)` |
| Design/UX Constraints | §8 Design/UX constraints | Direct `(4DL: §8)` |
| Business/Compliance Constraints | §8 Business/compliance constraints | Direct `(4DL: §8)` |
| Assumptions | §10 | Direct copy; preserve typed confidence levels `(4DL: §10)` |
| Open Questions | §9 | Direct copy; mark resolved ones `[Resolved: DL-XXX]` inline `(4DL: §9)` |

### Into `further-details.md`

| Content | 4D source | Why excluded from brief |
|---|---|---|
| Validation evidence | §7 | Testing metadata; not needed for spec generation |
| Conditions to revisit | §6 col 3 | Rejection stays in brief; conditions belong here |
| Deferred opportunities | §11 | Out of current scope |
| Review triggers + hypothesis eval | §12 | 4D cadence; no BMAD equivalent |

`further-details.md` also gets the source header: `> 4D Loops source: {path}`. Not consumed by BMAD agents — provides human context for validation and review cadence.

---

## 4. Non-negotiable rules

The agent executing the slash command must enforce these:

1. **UNVALIDATED flag present → must appear at top of `project-brief.md`.** Never omit.
2. **Every §8 feedback signal → exactly one `[FEEDBACK] AC:` line.** If any are missing, the brief is incomplete; agent must flag it and refuse to complete.
3. **§5 decisions → all prefixed `⚠️ DECIDED`.** PM agent must not reopen.
4. **§6 rejection table in brief → no "conditions to revisit" column.** That column goes to `further-details.md`.
5. **Every section in `project-brief.md` → tagged `(4DL: §N)` at end of section.**

---

## 5. Slash command spec

File: `.claude/commands/4d-to-bmad.md`

The agent writes this exact content:

```markdown
# 4D Loops → BMAD Adapter

You are running the 4D → BMAD adapter.

1. Read the adapter guide for the full mapping rules and non-negotiable constraints. Find it at whichever path exists: `.4d-loops-system/adapters/bmad/adapter-guide.md` (consuming project) or `adapters/bmad/adapter-guide.md` (framework repo).
2. Read the design-output.md at the path provided in $ARGUMENTS.
3. Apply the section mapping exactly as specified in the adapter guide.
4. Create the `bmad/` folder inside the same directory as the source file.
5. Write `bmad/project-brief.md` and `bmad/further-details.md`.
6. After writing, report: which sections were mapped, which were moved to further-details, and flag any source sections that were empty or missing from the input.
```

---

## 6. Verification

After building the adapter and running the slash command against a test fixture:

- [ ] `project-brief.md` has UNVALIDATED callout at top
- [ ] `project-brief.md` has exactly 4 `[FEEDBACK] AC:` lines
- [ ] §5 decisions all prefixed `⚠️ DECIDED`
- [ ] §6 table has no "conditions to revisit" column
- [ ] Every section tagged `(4DL: §N)`
- [ ] `further-details.md` contains §7, §11, §12 content
- [ ] Both files open with source header pointing to `design-output.md`
