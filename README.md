# Razor's Skills

A catalog of every Claude skill currently installed in this environment, what each one does, and when it fires. Skills are specialized instruction packs Claude loads on demand — each has a description that tells Claude when to trigger it and a body with the actual procedure.

Generated: 2026-06-28

---

## How to read this

Each skill below links to a per-skill doc in [`skills/`](./skills) with a fuller write-up. Skills are grouped by purpose. The **Trigger** line is the short version of "when does Claude reach for this."

---

## 1. Personal & workflow skills (your own)

These encode *your* conventions. Some are tied to MaxAssist work and are kept **🔒 Private** — listed by name only, with details withheld from this public repo (full docs live in the git-ignored `private/` folder).

| Skill | What it does | Trigger |
|---|---|---|
| [dev-folder-organizer](./skills/dev-folder-organizer.md) | Files projects in `~/Documents/Development/Projects` into domain folders (apps/games/tools/web/learning) by reading each project's own docs | "organize / sort / tidy my dev folder", "where does this project go" |
| [jira-epic-writer](./skills/jira-epic-writer.md) 🔒 | *Private (work) — listed only, details withheld* | — |
| [jira-story-writer](./skills/jira-story-writer.md) 🔒 | *Private (work) — listed only, details withheld* | — |
| [maxassist-demo-patient-parser](./skills/maxassist-demo-patient-parser.md) 🔒 | *Private (work) — listed only, details withheld* | — |
| [notion-page-style](./skills/notion-page-style.md) 🔒 | *Private (work-related) — listed only, details withheld* | — |
| [notion-ticktick-project-sync](./skills/notion-ticktick-project-sync.md) | Keeps your side-project list mirrored between Notion 🏗️ Project DB and TickTick 🔧Projects | "add / start / park / finish a project", board changes |

## 2. Document & output builders

Format helpers — they describe *how* to build a deliverable. Research first, then these.

| Skill | What it does | Trigger |
|---|---|---|
| [docx](./skills/docx.md) | Create/read/edit Word documents — TOCs, headings, letterheads, tracked changes, find-and-replace | "Word doc", ".docx", "report / memo / letter" |
| [pptx](./skills/pptx.md) | Create/read/edit PowerPoint decks — slides, layouts, speaker notes, templates | "deck", "slides", "presentation", ".pptx" |
| [xlsx](./skills/xlsx.md) | Create/edit/analyze spreadsheets — formulas, formatting, charts, cleaning messy data | "Excel", "spreadsheet", ".xlsx/.csv", "budget" |
| [pdf](./skills/pdf.md) | Read/extract/merge/split/fill/OCR PDFs | "PDF", ".pdf", "extract / merge / split / form" |

## 3. Productivity & research

| Skill | What it does | Trigger |
|---|---|---|
| [schedule](./skills/schedule.md) | Create/update tasks that run automatically on a cadence or once later | "every morning", "remind me in an hour", "run at noon" |
| [deep-research](./skills/deep-research.md) | Fan-out multi-source web research with adversarial fact-checking and a cited report | "deep research on X", multi-source fact-checked report |
| [consolidate-memory](./skills/consolidate-memory.md) | Reflective pass over Claude's memory files — merge duplicates, fix stale facts, prune the index | memory cleanup / consolidation |

## 4. Skill & plugin authoring

| Skill | What it does | Trigger |
|---|---|---|
| [skill-creator](./skills/skill-creator.md) | Create, edit, optimize, and eval skills; tune descriptions for better triggering | "create / improve / test a skill" |
| [create-cowork-plugin](./skills/create-cowork-plugin.md) | Guide building a new plugin from scratch, delivered as a `.plugin` file | "create / build / scaffold a plugin" |
| [cowork-plugin-customizer](./skills/cowork-plugin-customizer.md) | Tailor an existing plugin to a specific org's tools and workflows | "customize / configure / set up plugin" |
| [setup-cowork](./skills/setup-cowork.md) | Guided Cowork onboarding — install role-matched plugins, connect tools, try a skill | first-run setup |

## 5. Code & repo

| Skill | What it does | Trigger |
|---|---|---|
| [init](./skills/init.md) | Initialize a `CLAUDE.md` documenting a codebase | "init", new repo onboarding |
| [review](./skills/review.md) | Review a GitHub pull request | "review this PR" |
| [security-review](./skills/security-review.md) | Security review of pending changes on the current branch | "security review" |

---

## 6. Agent skills — Claude Code only (`~/.agents/skills/`)

A separate set of **21 engineering skills** (the Matt Pocock toolkit) lives at `~/.agents/skills/` and is used by **Claude Code in the terminal**, not Cowork. Full catalog: [`AGENT-SKILLS.md`](./AGENT-SKILLS.md). To enable them in Claude Code, run [`link-agents-skills.sh`](./link-agents-skills.sh) (symlinks them into `~/.claude/skills/`).

---

## Proposed addition: `ask-razor`

A meta-skill that recommends the best skill(s) for a situation, or explains a specific skill on request. Design and a draft `SKILL.md` live in [`ASK-RAZOR-PLAN.md`](./ASK-RAZOR-PLAN.md).

---

## Privacy

This is a **public** repo. MaxAssist-related skills (and anything that would reveal that work approach) are marked **🔒 Private**: they're listed by name only. Their full documentation lives in `private/`, which is **git-ignored** and never published. To read or edit those, open the files under `private/skills/` locally.

## Notes

- Skill files in this environment are a **read-only cache**. Editing them here does not change your saved skills — that's done in **Settings → Capabilities**.
- This repo is documentation only; it doesn't install or run anything.
