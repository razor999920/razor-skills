# Razor's Skills

A catalog of the Claude skills I keep installed, what each one does, and when it fires.

Skills are specialized instruction packs that Claude loads on demand. Each has a short **description** that tells Claude *when* to trigger it, and a body with the actual procedure to follow. This repo documents that catalog so it's easy to see — at a glance — what capabilities are available and what each one is for. It's a reference and a starting point if you want to curate your own set.

> This repo is **documentation only** — it doesn't install or run anything. The skill files here are write-ups, not live configuration.

---

## How to read this

Each skill below links to a per-skill doc in [`skills/`](./skills) with a fuller write-up. Skills are grouped by purpose. The **Trigger** column is the short version of "when does Claude reach for this."

---

## 1. Personal & workflow

Skills that encode personal conventions and routines.

| Skill | What it does | Trigger |
|---|---|---|
| [dev-folder-organizer](./skills/dev-folder-organizer.md) | Files projects in a development folder into domain folders (apps/games/tools/web/learning) by reading each project's own docs | "organize / sort / tidy my dev folder", "where does this project go" |
| [notion-ticktick-project-sync](./skills/notion-ticktick-project-sync.md) | Keeps a side-project list mirrored between a Notion project database and TickTick | "add / start / park / finish a project", board changes |

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

## 6. Agent skills — Claude Code only

A separate set of **21 engineering skills** lives at `~/.agents/skills/` and is used by **Claude Code in the terminal**, not Cowork. Full catalog: [`AGENT-SKILLS.md`](./AGENT-SKILLS.md). To enable them in Claude Code, run [`link-agents-skills.sh`](./link-agents-skills.sh) (it symlinks them into `~/.claude/skills/`).

---

## Proposed addition: `ask-razor`

A meta-skill that recommends the best skill(s) for a situation, or explains a specific skill on request. Design notes and a draft `SKILL.md` live in [`ASK-RAZOR-PLAN.md`](./ASK-RAZOR-PLAN.md).

---

## Notes

- Some personal and work-specific skills are intentionally **kept out of this public repo** — they're documented locally only.
- Skill files in this environment are a **read-only cache**. Editing them here does not change the saved skills — that's done in **Settings → Capabilities**.
- This repo is documentation only; it doesn't install or run anything.
