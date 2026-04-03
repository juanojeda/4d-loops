# Opportunity Map
**Product:** [product name]  
**Version:** [n]  
**Status:** [active]  
**Owner:** [name]  
**Last updated:** [date]  
**Update cadence:** After every discovery session, sprint, or shipped feature

---

## How to read this map

The map is organised by user journey stage. Each stage contains known problems surfaced through discovery. Each problem has a status indicating where it sits in the workflow.

**Problem statuses:**
- `unexplored` — identified but not yet sized or prioritised
- `in-discovery` — actively being researched in Loop 1
- `in-sprint` — being designed in Loop 2
- `in-build` — specced and being built in Loop 3
- `shipped` — live, monitoring outcome metrics
- `closed` — solved and confirmed by metrics, or deliberately deprioritised
- `invalid` — investigated and found not to be a real problem

---

## User journey

> [Describe the core user journey in one paragraph. This is the spine the map hangs off. Update it if your understanding of the user changes significantly.]

---

## Problem map

Organise problems by the stage of the journey where the user experiences them. Add or remove stages to match your product.

### [Stage 1 — e.g. Awareness / First encounter]

| ID | Problem hypothesis | Status | Evidence confidence | Loop / Sprint ref | Last updated |
|---|---|---|---|---|---|
| P-001 | [Who experiences this, under what conditions, what it costs them] | `unexplored` | low | — | [date] |

### [Stage 2 — e.g. Onboarding]

| ID | Problem hypothesis | Status | Evidence confidence | Loop / Sprint ref | Last updated |
|---|---|---|---|---|---|
| P-002 | [problem hypothesis] | `in-discovery` | medium | L1-003 | [date] |

### [Stage 3 — e.g. Core usage]

| ID | Problem hypothesis | Status | Evidence confidence | Loop / Sprint ref | Last updated |
|---|---|---|---|---|---|
| P-003 | [problem hypothesis] | `shipped` | high | Sprint-007 | [date] |

---

## Signals backlog

Problems that have been identified but not yet written up as Discovery Outputs. These are raw inputs — interview quotes, support ticket patterns, analytics anomalies — waiting to be synthesised.

| Signal | Source | Date captured | Assigned to |
|---|---|---|---|
| [brief description of signal] | [interview / analytics / support] | [date] | [name or unassigned] |

---

## Closed and invalid problems

Keep a record of what's been resolved or ruled out. This prevents the team relitigating settled questions.

| ID | Problem hypothesis | Outcome | Date closed | Notes |
|---|---|---|---|---|
| P-000 | [problem hypothesis] | `closed` / `invalid` | [date] | [why closed or what was learned] |

---

## AI agent notes

When reading this map to inform discovery or sprint work:
- Focus on problems with status `unexplored` or `in-discovery` for Loop 1 input
- Treat `evidence confidence: low` entries as hypotheses, not validated problems
- Check closed and invalid problems before proposing directions — do not resurface ruled-out problems without new evidence
- The signals backlog contains raw unvalidated inputs — do not treat them as problem hypotheses

