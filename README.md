# 4D Loops

> **Status:** Work in progress — v0.3  
> **Last updated:** 2026-04-02

---

## What this is

4D Loops

* **Discovery** — validates that a problem exists
* **Design** — validates which solution to pursue
* **Development** — builds the hypothesised solution
* **Diagnosis** — validates that the change had the intended outcome

A product development workflow for AI-assisted teams that connects continuous discovery, compressed design sprints, and spec-driven development (SDD) into a single operating model.

Most SDD tooling starts at the spec. This workflow starts at the problem. The premise: AI has made building fast enough that the bottleneck has shifted upstream. The waste is no longer in development — it's in building the wrong thing quickly.

Designed to be used by humans and AI agents alike. The artefact schemas are structured so that any capable agent can orient, validate, challenge, and consume them without a bespoke prompt each session.

**What it is not:** a prescription for how to build software. Loop 3 — the build cycle — is intentionally left open. Different teams work differently, and this workflow does not prescribe spec format, agent orchestration, or tooling choices. What happens in Loop 3 and how you measure Loop 4 is yours to define.

---

## How it works

Four loops, running in sequence for any given problem:

**Loop 1 — Continuous Discovery**
Surface and validate real problems worth solving. Human-led interviews and signal collection, AI-assisted synthesis. Output: a validated Discovery Output.

**Loop 2 — Design Sprint (compressed)**
Identify and validate the best solution direction. What used to take five days now takes one, sometimes two. Output: a Design Output with tested concept, documented decisions, rejected directions, and defined feedback instrumentation requirements.

**Loop 3 — BYO SDD Build Cycle**
Spec and build the validated solution. Format is team-defined — see the Adapter Guide for your chosen tooling. One requirement applies regardless: ship instrumented. All `[FEEDBACK]` acceptance criteria defined in the Design Output must be confirmed firing before ship.

**Loop 4 — Diagnosis**
Use the instrumentation specified in Loops 2 and 3 to monitor outcome metrics and assess whether the change had the intended outcome. Four exits: problem solved (metrics moved), return to Loop 1 (metrics flat — reframe the problem), return to Loop 2 (solution direction right, execution needs work), or return to Discovery Output validation (UNVALIDATED checkpoint triggered). See `workflow-spec.md §The feedback loop` for routing logic.

Three radiators sit above the whole system and are always current:

* **North Star + Outcome Metrics** — what success looks like and how we measure it
* **Opportunity Map** — a living map of the problem space
* **Decision Log** — every significant fork, recorded with reasoning

Entry points, validation gates, risk log paths, and the feedback loop are all documented in the workflow spec and system diagram.

---

## Repo structure

```
/
├── README.md                               ← you are here
├── workflow-spec.md                        ← full written model
├── INSTALL.md                              ← how to get the workflow into a project
├── agent-onboarding.md                     ← navigation protocol for AI agents
│
├── diagrams/
│   ├── sdd-ux-overview.mermaid             ← high-level overview (one node per loop)
│   └── sdd-ux-system-map.mermaid           ← full detail diagram
│
├── conventions/
│   └── folder-structure.md                ← .loops/ folder conventions and ID system
│
├── playbooks/                             ← process guides and how-to references
│   └── intake-questionnaire.md            ← where do I start? (self-serve intake)
│
└── templates/
    ├── radiator-north-star.md             ← North Star + Outcome Metrics
    ├── radiator-opportunity-map.md        ← Opportunity Map
    ├── radiator-decision-log.md           ← Decision Log (append-only)
    ├── template-design-output.md          ← Design Output (Loop 2 output)
    └── template-problem-hypothesis.md     ← Problem Hypothesis (Loop 1 input)
```

Projects using 4D Loops maintain a `.loops/` folder in their own repo. See `conventions/folder-structure.md` for the structure and ID conventions.

---

## What's still to come

**Templates**
* [ ] Discovery Output — Loop 1 output; wraps the problem hypothesis with supporting evidence, sizing, metadata, and everything Loop 2 needs to begin
* [ ] Decision Frame — used inside Loop 2, standalone reusable template
* [ ] Adapter Guide — maps Design Output fields to your chosen spec tool; first example using Spec Kit

**Playbooks**
* [ ] From hunch to signal
* [ ] From signal to finding
* [ ] From finding to insight
* [ ] From insight to problem framing
* [ ] From problem to design solution
* [ ] From design solution to build
* [ ] From build to diagnosis

**System**
* [ ] Loop 4 / Diagnosis — full loop with its own gates, templates, and structured outcome tracking (lightweight routing exists in `workflow-spec.md`; a complete loop is Slice 2+)
* [ ] Distribution mechanism — git submodule and installable CLI evaluated against copy-files approach (see `INSTALL.md` for current decision)

**Diagrams**
* [ ] Update both diagrams to reflect the 4D framing and Loop 4 as a named loop

---

## Contributing and feedback

This is an early-stage working model, not a finished framework. Gaps are expected and intentional — the goal right now is to get the structure right, not to be complete.

If you're using this with a team and something doesn't fit how you work, that's useful signal. The best way to contribute is to bring a specific scenario where the workflow breaks down and work through it against the model.