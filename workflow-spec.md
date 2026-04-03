# Discovery-Led SDD Workflow
**Version:** 1.0  
**Status:** Draft  
**Last updated:** 2026-03-22

---

## What this is

This document describes our product development workflow. It combines continuous discovery, compressed design sprints, and spec-driven development (SDD) into a single operating model for a small AI-assisted team.

The core premise: AI makes building fast. That shifts the bottleneck upstream. The waste is no longer in development — it's in building the wrong thing quickly. This workflow is designed to address that.

It is intended to be used by humans and AI agents alike. The artefact schemas are designed so that any capable agent can orient, validate, challenge, and consume them without a bespoke prompt.

---

## The model at a glance

Three loops run in sequence for any given problem, with gates controlling movement between them:

- **Loop 1 — Continuous Discovery:** Surface and validate real problems worth solving.
- **Loop 2 — Design Sprint (compressed):** Identify and validate the best solution direction.
- **Loop 3 — SDD Build Cycle:** Spec and build the validated solution.

Not every problem needs all three loops. The entry point and gate logic determines which loops apply.

Three radiators sit above the whole system and are always current:

- **North Star + Outcome Metrics** — what success looks like and how we measure it.
- **Opportunity Map** — a living map of the problem space, updated as we learn.
- **Decision Log** — every significant fork in the road, recorded with reasoning.

---

## Entry points

There are four ways a piece of work enters the system:

**Unknown problem** — we've identified a signal or area of interest but don't have a clear problem statement yet. Enter at Loop 1.

**Known problem, unknown solution** — we have a validated problem but don't know what to build. Enter at Discovery Output validation.

**Known problem, known solution (validated)** — we have both a problem and a solution direction backed by evidence. Enter at Discovery Output validation to confirm the output meets the bar before proceeding.

**Preformed solution based on assumption** — someone (internally or externally) has arrived with a solution before the problem has been validated. This is the most common failure mode in product work. See the section below on handling this path.

---

## Handling preformed solutions

When work arrives as a solution rather than a problem, do not take it straight into the build cycle. The solution may be right, but it needs to be grounded in a problem statement first.

The first step is to reframe: what problem does this solution assume exists? Once you have a problem hypothesis, ask whether the problem is actually understood.

**If yes** — you have enough to write a Discovery Output, but it's unvalidated. Log the assumption risk (see Risk log entries below) and proceed to Discovery Output validation with the output flagged as UNVALIDATED.

**If no** — the problem needs discovery work before anything else. Enter Loop 1 and treat the proposed solution as a possible direction to revisit later, not a starting point.

---

## Loop 1 — Continuous Discovery

**Purpose:** Produce a validated Discovery Output.

**Who leads it:** Humans. AI assists with synthesis, not with conducting research.

**How it works:**

User interviews and signal collection (analytics, support tickets, session recordings, competitor signals) happen on an ongoing basis. This is not a project — it's a background practice. Interviews are human-led. The relationship and the unexpected tangent that reveals the real problem cannot be outsourced to an agent.

AI earns its keep in synthesis. Feed transcripts and signals in as they arrive. Use AI to surface patterns, flag contradictions, and frame opportunities. Synthesis that used to take days now takes minutes. The output is a living Opportunity Map, not a slow-moving backlog.

A Discovery Output is drafted when a problem is worth articulating. It is approved when it can answer: who experiences this, under what conditions, and what does it cost them.

**Output:** Discovery Output (approved)

---

## Discovery Output validation

Before any Discovery Output proceeds to the gates — regardless of how it was produced — it must pass a three-question check:

1. Is there at least one external source cited (user, data, research) that didn't come from inside the building?
2. Is the problem framed in terms of user experience or outcome, not solution or feature?
3. Has someone who actually experiences this problem confirmed the framing?

**Pass** → proceed to Gate 1.

**Fail — fix the gaps** → return to Loop 1 with the specific gaps identified. Don't restart from scratch; target the missing evidence.


**Fail — proceed anyway (conscious risk)** → this is a legitimate path for teams moving fast on a strong hunch or testing a market quickly. It requires a Risk log entry before proceeding. See below.

---

## Risk log entries

A Risk log entry is required whenever work proceeds with an unvalidated problem. It is not optional and it is not a formality — it is the mechanism that keeps deliberate risk-taking honest.

A Risk log entry must contain:

- **The assumption:** what are we treating as true that we haven't verified?
- **The validation signal:** what specific evidence would confirm or refute this assumption, and by when?
- **The review checkpoint:** a specific trigger (date, metric, or event) at which we will either validate the assumption or make another conscious decision about it.

Once logged, the Discovery Output is flagged as UNVALIDATED. This flag travels with the work through all downstream artefacts. Every agent and human working on it can see the debt that's been taken on.

When the review checkpoint is reached, the feedback loop routes back to Discovery Output validation. You either validate the problem at that point or make another explicit decision.

---

## Gate 1 — Sizing

**Question:** How much does this problem warrant?

Size the problem across three dimensions:

- **Reach:** how many users encounter this, and how often? Order of magnitude is enough.
- **Impact:** if we solved this well, what would move in our outcome metrics?
- **Effort:** roughly how much of the build cycle does this consume?

**Large** — too big to sprint on as-is. Decompose into smaller slices, size each slice, and return to Gate 1 with the smallest slice that would generate real signal.

**Small or Medium** — proceed to Gate 2.

Size determines how much process is warranted. It does not determine which loops are needed — that is Gate 2's job.

---

## Gate 2 — Solution confidence

**Question:** Do I have evidence for the specific risk of this decision?

This gate is independent of sizing. A small problem can still have an unknown solution. A large problem may have a well-validated solution direction. Assess them separately.

The honest check: can you point to validated evidence for your confidence, or does it just feel obvious? Obvious is not the same as validated.

Evidence is valid when it reduces the risk of the specific decision you're making. Three tiers:

- **Tier 1 — Generalisable research:** established interaction patterns, platform conventions, published usability research. Valid for fundamental interaction decisions (login patterns, form conventions, navigation). Does not tell you anything product-specific.
- **Tier 2 — Domain or product-specific research:** your own user interviews, analytics, usability tests. Valid for decisions about your specific users in your specific context.
- **Tier 3 — Recency and relevance:** evidence expires. Check that what you're citing is recent enough and close enough to your current context to apply.

**Low confidence** → enter Loop 2.

**High confidence + validated evidence** → enter Loop 3 directly.

**High confidence but no evidence** → run a short stress-test sprint (approximately one hour): write the Decision Frame, run an AI challenge pass against your assumed solution, and document the alternatives you considered and rejected. This produces a Decision Log entry and then feeds Loop 3.

---

## Loop 2 — Design Sprint (compressed)

**Purpose:** Produce a validated Design Output with a tested solution direction.

**Timescale:** A day, sometimes two for complex problems. Not five days.

**How it works:**

**Write the Decision Frame** before generating any concepts. The frame defines what a good solution needs to do — not features, but outcomes and constraints. Everything gets evaluated against this. If you can't explain why a concept wins or loses on these terms, the frame isn't tight enough.

```
Decision Frame
─────────────────────────────────────
Problem we're solving:
User and context:
Success looks like: (outcome, not feature)
Hard constraints: (must respect)
Soft constraints: (prefer but could trade)
What we're not trying to solve right now:
```

**Generate concepts** independently before sharing. Each person produces options. Use AI to generate additional directions as provocations — not answers. Aim for 2–3 meaningfully different directions, not variations on the same idea.

**Evaluate each concept** against the Decision Frame. For each concept, capture: strengths against the frame, weaknesses against the frame, key risks, and what you'd need to validate first.

**Run an AI challenge pass.** Before making the call, use AI to pressure-test the reasoning. Ask it: what assumptions does this concept rely on that we haven't validated? What's the strongest argument against backing this direction? What does this make harder to change later? A small team has blind spots. Use this step to find them.

**Make the call** and record a Decision Log entry at the moment of decision, not reconstructed afterwards:

```
Decision Log Entry
─────────────────────────────────────
Date:
Decision Frame ref:

Chosen: [concept name]
Reason: [one sentence against the frame]

Runner-up: [concept name]
Why it lost: [specific, not comparative]
When we'd revisit: [conditions that would change this call]

Rejected:
- [Concept]: [failure mode against frame]
- [Concept]: [failure mode against frame]

Confidence in this call: [high | medium | low]
If medium or low — what would increase confidence?
```

**Build stimulus.** AI-assisted prototype of the chosen concept. For a web or mobile product this is now an hour's work, not a day's. The stimulus should be good enough to generate real reactions from users — not polished enough to be mistaken for the final product.

**Test with real users.** Minimum 3–5 people. AI can assist with analysis after sessions, but the sessions themselves are human-led. Synthetic personas are useful for pre-validating logic and catching obvious failures before you recruit, but they do not replace real users.

**Output:** Design Output (approved), including all rejected directions and their reasoning. The rejected directions section is required. It is load-bearing — it tells downstream agents which approaches are off the table and why.

---

## SDD Handoff — workflow boundary

This workflow ends at the Design Output. What happens next — how the spec is written, how agents are structured, how tasks are tracked — is the responsibility of the team's chosen SDD tooling.

The boundary is intentional. Different teams work differently, and the build loop is the most variable and opinionated part of the SDLC. This workflow does not prescribe it.

**What the workflow is responsible for:**
- A validated problem (or an explicitly flagged unvalidated one)
- A tested solution direction with documented reasoning
- A Design Output complete enough that any capable spec tool can consume it without the author present to explain it

**What the workflow is not responsible for:**
- Spec format or structure
- Task decomposition and agent orchestration
- Code architecture and tooling choices
- Deployment and release process

### The interface contract

For the handoff to work, the Design Output must be complete. A spec tool receiving an incomplete output will either produce a bad spec or stall waiting for information that should have been captured upstream.

The minimum the Design Output must contain for any SDD tool to consume it:

| Field | Why it's required |
|---|---|
| Validated problem hypothesis | Grounds the spec in a real user need |
| User and context | Constrains scope and informs acceptance criteria |
| Chosen concept summary | Defines what is being built |
| Key decisions + reasoning | Tells the spec tool what's already been decided |
| Rejected directions | Defines what is explicitly out of scope |
| Hard constraints | Non-negotiable boundaries the spec must respect |
| Open questions | Flags what the spec author or agent needs to resolve |
| Validation evidence + confidence | Tells downstream agents how much to trust the brief |
| UNVALIDATED flag (if applicable) | Alerts agents that assumptions need treating as hypotheses |
| Feedback instrumentation requirements | Defines what signals must be capturable post-ship; each maps to a `[FEEDBACK]` AC in the spec |

### Adapter Guide

Each team maintains an Adapter Guide — a short document that maps Design Output fields to their chosen spec format. This is written once when the team adopts the workflow and updated when the spec format changes.

The Adapter Guide lives at `/docs/adapter-guide.md` and is not part of the core workflow. See the Adapter Guide template for the Spec Kit example.

## Loop 3 — BYO SDD Build Cycle

**Purpose:** Produce working, instrumented software from a validated spec.

**Format:** Team-defined. This workflow does not prescribe the build process.

The quality of the build loop is almost entirely determined by the quality of what enters it. A complete, well-reasoned Design Output produces a good spec. A vague or incomplete output produces technically correct code that solves the wrong problem. The handoff contract above is what makes the boundary clean.

One requirement that applies regardless of tooling: **ship instrumented.**

Done-to-ship requires all three of the following, not just functional completion:

- All functional acceptance criteria pass
- All `[FEEDBACK]` acceptance criteria pass — these are defined in the Design Output (Section 8) and carried into the spec as typed ACs
- Feedback signals are confirmed firing in staging before ship

A spec with no `[FEEDBACK]` ACs is incomplete. A build that ships without confirmed instrumentation has broken the feedback loop by design — the team will be unable to close the loop regardless of what the workflow says.

**Output:** Working software, instrumented for feedback loop.

---

## The feedback loop

Shipping is not done. Done means closing the loop.

After shipping, monitor outcome metrics against what was expected when the problem was sized. There are four exits:

**Outcome metrics moved** → the problem is solved. Mark done, update the Opportunity Map, move on.

**Metrics flat** → the solution didn't move the needle. Reframe the problem and return to Loop 1. Do not iterate on a solution to a problem that may have been wrong.

**Concept needs iteration** → the solution direction is right but the execution needs work. Return to Loop 2 with the test data.

**UNVALIDATED brief — checkpoint reached** → a risk log checkpoint has been triggered. Return to Discovery Output validation and either validate the assumption with real evidence or make another explicit decision about how to proceed.

---

## Operating rhythm for a small team

At any given time the team might have:

- One problem in discovery (Loop 1)
- One concept in sprint (Loop 2)
- One feature in build (Loop 3)
- Shipped features feeding signals back into discovery

The loops are not sequential across the whole product. They run in parallel on different problems. The Opportunity Map is the tool that keeps it coherent — it shows what's in each loop, what's been shipped, and what's still unexplored.

Review the Opportunity Map and the North Star metrics at the start of every sprint, not to change them necessarily, but to confirm that what you're building still connects to something real.

---

## AI agent guidance

AI agents entering this workflow should be able to do four things with any artefact:

1. **Orient** — read the status and lineage fields to understand where this sits in the workflow.
2. **Validate** — check that required fields are populated and that typed fields are correctly labelled.
3. **Challenge** — flag low-confidence assumptions, missing evidence, or unresolved open questions.
4. **Consume** — use the content to do the job (synthesise signals, generate spec sections, write code).

Key rules for agents:

- A brief flagged UNVALIDATED means assumptions must be treated as hypotheses, not facts. Flag them in any downstream artefact you produce.
- The rejected directions section of a Design Output is not optional reading. It defines the boundaries of the solution space.
- Never make a routing decision (which loop, which gate exit) without recording it in the Decision Log.
- If a required field is missing or a confidence level is low with no supporting evidence, surface it explicitly before proceeding. Do not paper over gaps.

---

## Artefact index

| Artefact | Produced by | Consumed by | Required fields |
|---|---|---|---|
| Discovery Output | Loop 1 / direct entry | Discovery Output validation | Problem hypothesis, evidence, sizing |
| Risk log entry | Validation gate / reframe path | Decision Log | Assumption, validation signal, checkpoint |
| Decision Frame | Loop 2 (start) | Loop 2 evaluation | Problem, user, success outcome, constraints |
| Decision Log entry | Loop 2 (call) / stress-test | Design Output, Spec | Chosen, reason, runner-up, rejected |
| Design Output | Loop 2 | Loop 3 Spec | Concept summary, decisions, rejected directions, validation evidence |
| Spec | Team's SDD tooling (via Adapter Guide) | Build agents | Format team-defined — see Adapter Guide |
| Adapter Guide | Team (one-time setup) | Spec authors, build agents | Design Output field mappings, spec format reference |

Full artefact templates are in `/docs/templates/`.

---

## What this is not

This workflow does not replace judgment. The gates are checkpoints, not bureaucracy — a small team moving fast can move through them quickly when the evidence is solid. The point is that the decisions are conscious and recorded, not that every decision takes a long time.

It also does not guarantee good outcomes. It raises the probability of building the right thing by ensuring the thinking is done before the building starts. The feedback loop exists precisely because we will sometimes be wrong, and the model needs to handle that cleanly.
