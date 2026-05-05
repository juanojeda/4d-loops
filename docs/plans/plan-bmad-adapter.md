 Plan: 4D Loops → BMAD Adapter — Agent-Ready Implementation Spec

 What we're building

 Two files that live in the 4D Loops framework repo and can be actioned by an AI agent with no conversation context:

 1. .4d-loops-system/adapters/bmad/adapter-spec.md — the implementation spec (agent reads + executes this)
 2. .claude/commands/4d-to-bmad.md — the resulting slash command (agent creates this as part of executing the spec)

 What adapter-spec.md must contain (fully self-contained for an agent)

 The spec document should be written so an agent can pick it up cold and build the complete adapter. It needs:

 1. Background (agent orientation)

 - What 4D Loops is and what a Design Output contains (the 12 sections + AI agent guidance)
 - What BMAD is and what each agent role expects (Analyst → PM → Architect → SM → Dev chain)
 - Why this adapter exists: Design Output maps to BMAD's Analyst output (project-brief.md); PM agent can skip discovery entirely if brief is
  complete

 2. What to build (file list)

 .4d-loops-system/adapters/bmad/
   adapter-guide.md           ← the mapping rules (written by the agent as part of this task)

 .claude/commands/
   4d-to-bmad.md              ← slash command (written by the agent as part of this task)

 When the slash command runs (per-project, not framework):
 {sprint-folder}/bmad/
   project-brief.md           ← BMAD PM agent input
   further-details.md         ← human reference only

 3. Section mapping (the core of the adapter)

 Into project-brief.md:

 ┌─────────────────────────┬─────────────────────────────────┬──────────────────────────────────────────────────────────────────────────┐
 │         Section         │         4D Loops source         │                                   Rule                                   │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ Source header (top of   │ Header block (ID, Version,      │ > 4D Loops source: {path} (DO-{ID}, v{Version}, approved {date}).        │
 │ file)                   │ Approval date, file path)       │ Sections tagged (4DL: §N).                                               │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ UNVALIDATED warning     │ Header UNVALIDATED flag         │ If flag present → copy verbatim as callout at top; must not be omitted   │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ Executive Summary       │ §1                              │ Direct copy (4DL: §1)                                                    │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ Problem Statement       │ §3 "Problem we're solving" + §2 │ Merge into one paragraph (4DL: §2, §3)                                   │
 │                         │  "Current friction"             │                                                                          │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ Target Users            │ §2 User and context table       │ Convert table to persona prose (4DL: §2)                                 │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ Proposed Solution       │ §4 Description + Key            │ Combine; keep numbered steps (4DL: §4)                                   │
 │                         │ interaction flow                │                                                                          │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ Goals & Success Metrics │ §3 "Success looks like"         │ Direct copy (4DL: §3)                                                    │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │                         │ §8 Feedback instrumentation     │ One line per signal: [FEEDBACK] AC: When {signal_name} fires,            │
 │ Required [FEEDBACK] ACs │ table                           │ {what_it_measures} must be observable. Minimum fidelity: {fidelity}.     │
 │                         │                                 │ Links to: {outcome_metric}. (4DL: §8)                                    │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ MVP Scope — In Scope    │ §3 Hard + soft constraints      │ Bulleted (4DL: §3)                                                       │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ Out of Scope            │ §6 Rejected directions          │ Table: concept name + one-line rejection reason only — no "conditions to │
 │                         │                                 │  revisit" column (4DL: §6)                                               │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ Already-Decided         │ §5 Key decisions                │ Each prefixed ⚠️ DECIDED (DL-XXX) — do not revisit: (4DL: §5)            │
 │ Constraints             │                                 │                                                                          │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ Technical Constraints   │ §8 Technical constraints        │ Direct (4DL: §8)                                                         │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ Design/UX Constraints   │ §8 Design/UX constraints        │ Direct (4DL: §8)                                                         │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ Business/Compliance     │ §8 Business/compliance          │ Direct (4DL: §8)                                                         │
 │ Constraints             │ constraints                     │                                                                          │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ Assumptions             │ §10                             │ Direct copy; preserve typed confidence levels (4DL: §10)                 │
 ├─────────────────────────┼─────────────────────────────────┼──────────────────────────────────────────────────────────────────────────┤
 │ Open Questions          │ §9                              │ Direct copy; mark resolved ones [Resolved: DL-XXX] inline (4DL: §9)      │
 └─────────────────────────┴─────────────────────────────────┴──────────────────────────────────────────────────────────────────────────┘

 Into further-details.md:

 ┌───────────────────────────────────┬───────────┬──────────────────────────────────────────────────┐
 │              Content              │ 4D source │             Why excluded from brief              │
 ├───────────────────────────────────┼───────────┼──────────────────────────────────────────────────┤
 │ Validation evidence               │ §7        │ Testing metadata; not needed for spec generation │
 ├───────────────────────────────────┼───────────┼──────────────────────────────────────────────────┤
 │ Conditions to revisit             │ §6 col 3  │ Rejection stays in brief; conditions belong here │
 ├───────────────────────────────────┼───────────┼──────────────────────────────────────────────────┤
 │ Deferred opportunities            │ §11       │ Out of current scope                             │
 ├───────────────────────────────────┼───────────┼──────────────────────────────────────────────────┤
 │ Review triggers + hypothesis eval │ §12       │ 4D cadence; no BMAD equivalent                   │
 └───────────────────────────────────┴───────────┴──────────────────────────────────────────────────┘

 further-details.md also gets the source header: > 4D Loops source: {path}. This file is not consumed by BMAD agents — it provides human
 context for validation and review cadence.

 4. Non-negotiable rules (agent must enforce)

 1. UNVALIDATED flag present → must appear at top of project-brief.md
 2. Every §8 feedback signal → exactly one [FEEDBACK] AC: line; if any missing, brief is incomplete and agent must flag it
 3. §5 decisions → all prefixed ⚠️ DECIDED; PM agent must not reopen
 4. §6 rejection table in brief → no "conditions to revisit" column
 5. Every section in project-brief.md → tagged (4DL: §N) at end of section

 5. Slash command spec

 File: .claude/commands/4d-to-bmad.md

 Content the agent should write:
 # 4D Loops → BMAD Adapter

 You are running the 4D → BMAD adapter.

 1. Read `.4d-loops-system/adapters/bmad/adapter-guide.md` for the full mapping rules and non-negotiable constraints.
 2. Read the design-output.md at the path in $ARGUMENTS.
 3. Apply the section mapping exactly as specified in the adapter guide.
 4. Create the `bmad/` folder inside the same directory as the source file.
 5. Write `bmad/project-brief.md` and `bmad/further-details.md`.
 6. After writing, report: which sections were mapped, which were moved to further-details, and flag any source sections that were empty or
 missing from the input.

 6. Verification criteria

 After the agent builds the adapter and runs the slash command against DO-001.1:
 - project-brief.md has UNVALIDATED callout at top
 - project-brief.md has exactly 4 [FEEDBACK] AC: lines
 - §5 decisions all prefixed ⚠️ DECIDED
 - §6 table has no "conditions to revisit" column
 - Every section tagged (4DL: §N)
 - further-details.md contains §7, §11, §12 content
 - Both files open with source header pointing to design-output.md

 ---
 Plan execution (what I'll do when approved)

 1. Create .4d-loops-system/adapters/bmad/adapter-spec.md — the self-contained agent brief above
 2. Create .4d-loops-system/adapters/bmad/adapter-guide.md — the mapping rules doc the slash command reads
 3. Create .claude/commands/4d-to-bmad.md — the slash command

 The agent picks up adapter-spec.md, builds adapter-guide.md and 4d-to-bmad.md, then the slash command can run against any sprint's
 design-output.md.