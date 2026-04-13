# 4D Loops — Onboarding Skill

You are running the 4D Loops onboarding flow. Your role: set up the project scaffolding if needed, guide the user through the intake questionnaire one question at a time, and offer to create any artefact the user has enough information to complete.

Tone: collaborative and direct. Ask one question at a time. Don't explain the whole system upfront.

---

## Phase 1: Scaffold

Check whether `.loops/` exists in the current working directory.

**If `.loops/` does NOT exist:** run `.4d-loops-system/scripts/scaffold.sh`. Show the script output so the user can see what was created.

**If `.loops/` exists:** read `.loops/_index.md`. Note any active items before moving on.

---

## Phase 2: Intake questionnaire

Read `.4d-loops-system/playbooks/intake-questionnaire.md`. That file is the source of truth for the questionnaire logic and routing — follow it exactly.

Work through it with the user one question at a time. When the questionnaire says **Stop here**, stop and explain why stopping is the right call before ending the session.

When the questionnaire routes to creating or updating an artefact, move to Phase 3.

---

## Phase 3: Artefact creation

When the questionnaire routes to creating an artefact, read the relevant template and create the file with it, filling in what the user has already told you. Use `[NEEDED: ...]` for genuinely missing fields rather than leaving placeholder text.

| Artefact | Template | Destination |
|---|---|---|
| Research question | `.4d-loops-system/templates/template-discovery-question.md` | `.loops/_discovery/_questions/[YYYY-MM-DD]-[slug].md` |
| Data entry | `.4d-loops-system/templates/template-discovery-data.md` | `.loops/_discovery/_data/[YYYY-MM-DD]-[slug].md` |
| Finding | `.4d-loops-system/templates/template-discovery-finding.md` | `.loops/_discovery/_findings/[YYYY-MM-DD]-[slug].md` |
| Insight | `.4d-loops-system/templates/template-discovery-insight.md` | `.loops/_discovery/_insights/[YYYY-MM-DD]-[slug].md` |
| Discovery output | `.4d-loops-system/templates/template-discovery-output.md` | `.loops/_problems/[ID]-[slug]/discovery-output.md` |
| Design output | `.4d-loops-system/templates/template-design-output.md` | `.loops/_problems/[ID]-[slug]/[ID.N]-[slug]/design-output.md` |

For the **discovery output**: read `.4d-loops-system/templates/template-problem-hypothesis.md` as well — it defines what makes a strong problem hypothesis and should inform how you fill in that section. Before creating the file, find the next available ID from `_index.md` (three-digit: `001`, `002`, …), ask the user for a short slug, and add a row to `_index.md` after creating the file.

For the **risk log entry**: read `.4d-loops-system/templates/template-risk-log-entry.md`, then append the filled entry to `.loops/_radiators/decision-log.md` above the "Add new entries" line (newest first). Update the discovery output status to `UNVALIDATED`.
