# Installing 4D Loops

## What you're installing

4D Loops is a set of files. There's no package, no server, no tooling dependency. You copy files into your project, create one folder, and you're running. The workflow lives in your repo alongside your code — you own it completely.

---

## Minimum file set

Copy these files into your project. A `/loops/` or `/docs/loops/` folder works well, but repo root is fine too. The only constraint is that `agent-onboarding.md` and `workflow-spec.md` are findable when you start a session.

```
workflow-spec.md
agent-onboarding.md
INSTALL.md
conventions/folder-structure.md
playbooks/intake-questionnaire.md
templates/template-problem-hypothesis.md
templates/template-design-output.md
templates/radiator-north-star.md
templates/radiator-opportunity-map.md
templates/radiator-decision-log.md
```

---

## First-time setup

1. Copy the minimum file set into your project (see above).

2. Create `.loops/` at your repo root.

3. Create `.loops/_index.md` — copy the index template from `conventions/folder-structure.md` (the table under "Index file").

4. Create `.loops/_radiators/` — copy the three radiator templates into it, renaming them to remove the `radiator-` prefix:
   - `radiator-north-star.md` → `north-star.md`
   - `radiator-opportunity-map.md` → `opportunity-map.md`
   - `radiator-decision-log.md` → `decision-log.md`

5. Fill in `north-star.md` with your team's current North Star and outcome metrics. Rough is fine — you can sharpen it as you go.

6. Run the intake questionnaire — start at Q1.

---

## Distribution mechanism

> **Decision:** Copy files manually. No package manager, no submodule, no CLI.
>
> **Why:** The simplest mechanism that works for any team immediately. No tooling dependency, full ownership of the files, works offline. Teams can modify templates to fit their context without managing a fork or upstream conflict.
>
> **Tradeoff:** Updates to the core workflow require a manual re-copy of changed files. This is acceptable at this stage — teams should expect to adapt the workflow to their context, and staying in sync with upstream is a secondary concern.
>
> **What we're watching:** Whether teams need to stay in sync with upstream changes (which would favour a submodule) or whether they diverge intentionally (which would favour a copy). Git submodule and installable CLI are options being evaluated for a later slice.

---

## After setup

Start at the intake questionnaire (`playbooks/intake-questionnaire.md`), or give your AI agent the `agent-onboarding.md` prompt and let it orient you.
