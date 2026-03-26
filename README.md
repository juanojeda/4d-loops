# Discovery-Led SDD

> **Status:** Work in progress — v0.1  
> **Last updated:** 2026-03-22

---

## What this is

A product development workflow for small, AI-assisted teams that connects continuous discovery, compressed design sprints, and spec-driven development (SDD) into a single operating model.

Most SDD tooling starts at the spec. This workflow starts at the problem. The premise is simple: AI has made building fast enough that the bottleneck has shifted upstream. The waste is no longer in development — it's in building the wrong thing quickly.

This workflow is designed to be used by humans and AI agents alike. The artefact schemas are structured so that any capable agent can orient, validate, challenge, and consume them without a bespoke prompt each session.

**What it is not:** a prescription for how to build software. Loop 3 — the build cycle — is intentionally left open. Different teams work differently, and this workflow does not prescribe spec format, agent orchestration, or tooling choices. It ends at the Design Brief. What happens next is yours.

---

## How it works

Three loops, running in sequence for any given problem:

**Loop 1 — Continuous Discovery**  
Surface and validate real problems worth solving. Human-led interviews and signal collection, AI-assisted synthesis. Output: a validated Problem Brief.

**Loop 2 — Design Sprint (compressed)**  
Identify and validate the best solution direction. What used to take five days now takes one, sometimes two. Output: a Design Brief with tested concept, documented decisions, and rejected directions.

**Loop 3 — BYO SDD Build Cycle**  
Spec and build the validated solution. Format is team-defined — see the Adapter Guide for your chosen tooling.

Three radiators sit above the whole system and are always current:

- **North Star + Outcome Metrics** — what success looks like and how we measure it
- **Opportunity Map** — a living map of the problem space
- **Decision Log** — every significant fork, recorded with reasoning

Entry points, validation gates, risk log paths, and the feedback loop are all documented in the workflow spec and system diagram.

---

## Repo structure

```
/
├── README.md                          ← you are here
├── workflow-spec.md                   ← full written model
│
├── diagrams/
│   ├── sdd-ux-overview.mermaid        ← high-level overview (one node per loop)
│   └── sdd-ux-system-map.mermaid      ← full detail diagram
│
└── templates/
    ├── radiator-north-star.md         ← North Star + Outcome Metrics
    ├── radiator-opportunity-map.md    ← Opportunity Map
    ├── radiator-decision-log.md       ← Decision Log (append-only)
    ├── template-design-brief.md       ← Design Brief (Loop 2 output)
    └── template-problem-statement.md  ← Problem Statement (Loop 1 input)
```

---

## What's still to come

**Templates**
- [ ] Problem Brief — Loop 1 output, input to validation gate (problem statement template included)
- [ ] Decision Frame — used inside Loop 2, standalone reusable template
- [ ] Adapter Guide — maps Design Brief fields to your chosen spec tool; first example using Spec Kit

**System**
- [ ] Agent onboarding prompt — single document an AI agent reads at session start to understand the workflow, its role, and which artefacts to look for
- [ ] Version and status conventions — operational definitions for `draft`, `approved`, `superseded` across all artefacts

**Other**
- [ ] Name — working title is "Discovery-Led SDD"; needs a decision before public sharing

---

## Contributing and feedback

This is an early-stage working model, not a finished framework. Gaps are expected and intentional — the goal right now is to get the structure right, not to be complete.

If you're using this with a team and something doesn't fit how you work, that's useful signal. The best way to contribute is to bring a specific scenario where the workflow breaks down and work through it against the model.

