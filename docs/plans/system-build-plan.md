# System Build Plan

This document outlines the plan to build 4D Loops into a fully fledged Spec Driven Product Development System — guiding a team from the first hunch of an idea through to monitoring, maintenance, or sunsetting.

Work is organised as vertical slices of increasing fidelity. Each slice covers all four loops — a user can traverse the full lifecycle at the end of every slice. Later slices make the journey deeper, more guided, and more distributable.

Coherence (navigability) and distribution (adoptability) are part of the definition of done for each slice — not a separate phase.

---

## Slice 1 — Traversable

> **Detailed plan:** [slice-1-traversable.md](slice-1-traversable.md)

A team can walk through all four loops without getting stuck. Everything exists at minimum viable fidelity — enough to orient, not enough to be exhaustive.

**Loop 1 — Discovery**
- Problem hypothesis template (exists)
- Opportunity map radiator (exists)
- Intake questionnaire for routing (exists)

**Loop 2 — Design**
- Design output template (exists)
- North Star and Decision Log radiators (exist)

**Loop 3 — Development**
- Handoff contract defined in workflow-spec (exists)
- `[FEEDBACK]` AC pattern defined (exists)

**Loop 4 — Diagnosis**
- Feedback routing described in workflow-spec (exists)
- Four exit routes documented (exists)

**Coherence**
- `agent-onboarding.md` stub — one section per loop, just enough to orient an AI agent at session start
- README updated to accurately reflect all four loops and what exists vs. what's coming

**Distribution**
- `INSTALL.md` stub — "copy these files into your project" with a minimal folder setup guide
- Distribution mechanism decision made here (copy / submodule / CLI), even if tooling ships later

**Exit condition:** A team can pick up the system cold and navigate from intake through to a post-ship routing decision, using only what exists.

---

## Slice 2 — Operable

*Each loop has the playbooks and templates needed to actually execute the work well. To be planned.*

---

## Slice 3 — Scalable

*The system is stable enough to distribute, contribute to, and build tooling on top of. To be planned.*

---

## Open Questions

Before starting, align on:

1. **Loop 4 scope** — Full loop with its own gates and templates, or lighter (playbook + one radiator)?
2. **Adapter Guide depth** — Generic template teams fill in, or an example mapping to a specific tool (e.g. Linear, Notion, GitHub Issues)?
3. **Agent onboarding audience** — Human-operated AI assistant, or autonomous agents running playbooks end-to-end?
4. **Distribution mechanism** — Copy, git submodule, or CLI? Depends on target audience (solo builders, small teams, enterprises).
