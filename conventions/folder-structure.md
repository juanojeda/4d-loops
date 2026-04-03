# 4D Loops — Folder Structure Conventions

This document defines the folder structure and ID conventions for the `.loops/` directory. All product discovery, design, and implementation artefacts live here.

---

## Structure

```
.loops/
├── _index.md                        ← problem registry (see below)
├── _discovery/                      ← all discovery work lives here permanently
│   ├── _questions/                  ← research questions and hunches to investigate
│   ├── _data/                       ← raw signals and observations
│   ├── _findings/                   ← patterns across multiple data points
│   └── _insights/                   ← interpreted findings with meaning
│
│   Nothing leaves _discovery. Items are referenced by problems and solutions,
│   not owned by them. The same insight can inform multiple problems simultaneously.
│
├── _radiators/
│   ├── north-star.md
│   ├── opportunity-map.md
│   └── decision-log.md
└── _problems/
    ├── _archive/                    ← superseded problems, folder intact
    │   └── 001-photo-memories/
    │       ├── problem-brief.md
    │       └── SUPERSEDED.md        ← points to superseding problem
    └── 002-memory-overwhelm/
        ├── problem-brief.md
        └── 002.1-card-game/
            ├── design-brief.md
            └── 002.1.1-[tbd]/       ← implementation layer, contents TBD
                └── [tbd]
```

---

## The discovery layer

`_discovery/` is a shared reference layer, not a staging area. Nothing graduates out of it — items stay in place and are referenced by whatever problems or solutions they inform. This means the same insight can inform multiple problems simultaneously without duplication.

The four subfolders reflect the maturity of discovery work, following the data → findings → insights ladder:

| Subfolder | What goes here | Maturity |
|---|---|---|
| `_questions/` | Research questions, hunches, things we want to find out | Not yet observed |
| `_data/` | Raw signals — interview quotes, analytics observations, support tickets, complaints | Observed, not yet patterned |
| `_findings/` | Patterns identified across multiple data points | Patterned, not yet interpreted |
| `_insights/` | Interpreted findings — what the pattern means in context | Ready to ground a problem statement |

A problem brief references the insights that informed it. It does not own them.

---

## ID conventions

IDs are hierarchical and scoped to their parent. The format varies by level:

| Level | Format | Example |
|---|---|---|
| Problem | `NNN` (three digits) | `002` |
| Solution | `NNN.N` | `002.1` |
| Implementation | `NNN.N.N` *(TBD)* | `002.1.1` *(TBD)* |

Folder names use the full ID and a human-readable slug:

```
002-memory-overwhelm/
002.1-card-game/
002.1.1-[tbd]/
```

References in documents always use the full ID-and-slug format — never a bare ID or path alone. This keeps references human-readable and stable across renames.

---

## Index file

`_index.md` is the single registry of all problems, solutions, and implementations. It is updated on every create, archive, or rename operation.

```markdown
| ID | Slug | Type | Status | Notes |
|---|---|---|---|---|
| 001 | 001-photo-memories | problem | archived | superseded by 002-memory-overwhelm |
| 002 | 002-memory-overwhelm | problem | active | — |
| 002.1 | 002.1-card-game | solution | active | — |
| 002.1.1 | *(TBD)* | implementation | *(TBD)* | contents and naming TBD |
```

---

## Superseding a problem or solution

When a problem framing or design solution is superseded:

1. Move the folder into `_problems/_archive/`
2. Add a `SUPERSEDED.md` file to the archived folder pointing to the superseding entry
3. Update `_index.md` with the new status and superseding reference
4. Use the rename-and-rereference utility if the slug is also changing

Git tracks the full move history. The ID remains stable — it is never reused.

---

## Rename-and-rereference utility

Renaming a slug without updating references breaks navigability. The rename utility handles this in one operation:

```bash
# Usage
loops rename 002-memory-overwhelm 002-photo-recall

# What it does
# 1. Renames the folder
# 2. Finds all .md files under .loops/ referencing the old slug
# 3. Replaces with the new slug
# 4. Updates _index.md
# 5. Commits with message "rename: 002-memory-overwhelm → 002-photo-recall"
```

The utility is not yet implemented. Until it is, renames should be done manually following the same steps.

---

## Version history

Artefact version history is tracked by Git. There are no separate version fields in document headers — the Git log is the record. Use meaningful commit messages when updating artefacts.

---

## Open questions

- **Implementation layer (002.1.1):** what document types belong here, what triggers creating a new implementation folder vs updating in place, and whether the ID and slug format needs revision once the contents are defined. This depends on the team's chosen SDD tooling (Loop 3 is BYO).
