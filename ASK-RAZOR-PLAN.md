# Plan: `ask-razor` — a skill-router / skill-explainer

> **Public version.** Some routing rows reference 🔒 Private (MaxAssist work) skills — those are listed by name only, with their trigger signals redacted. The full, unredacted plan lives in `private/ASK-RAZOR-PLAN-full.md` (git-ignored).

A meta-skill that does two jobs:
1. **Recommend** — given a situation, suggest the best skill(s) to reach for and why.
2. **Explain** — given a skill name, explain what it does, when it fires, and how to use it.

Think of it as the front desk for your whole skill library.

---

## 1. The core problem it solves

You have ~20 skills. The friction isn't running them — Claude auto-triggers most. The friction is:
- "I have a thing to do; which of my skills fits?" (discovery)
- "What does *this* skill actually do / when does it kick in?" (understanding)
- Overlap confusion: the two Jira skills, `create-cowork-plugin` vs `cowork-plugin-customizer`, the two Notion skills.

`ask-razor` is a deliberate, on-demand router so you can ask "what should I use for X?" and get a confident pick instead of guessing.

---

## 2. What it should do (behavior spec)

### Mode A — Recommend (situation → skill)
**Input:** a task or situation in plain language.

**Output:**
- The **top pick** (one skill) with a one-line why.
- **Runner-up(s)** if there's genuine overlap, with the distinguishing factor.
- A **better-alternative flag**: if a non-skill path is smarter (e.g., "this is really a `schedule` job" or "no skill needed, just do it"), say so.
- If the request is ambiguous between two skills, ask **one** clarifying question, then commit.

### Mode B — Explain (skill name → description)
**Output:** what it does, its triggers, key rules/gotchas, and what it pairs or conflicts with — sourced from this repo's per-skill docs (or the `private/` docs for 🔒 skills when run locally).

### Mode C — Catalog (browse)
**Output:** the relevant group from the catalog, one line each.

---

## 3. Routing logic (how it picks)

A small decision table keyed on intent signals (work-skill signals redacted here):

| If the situation involves… | Pick | Over… |
|---|---|---|
| A work epic (🔒 private skill) | jira-epic-writer | jira-story-writer |
| A work story / acceptance criteria (🔒 private skill) | jira-story-writer | jira-epic-writer |
| Work demo-data SQL (🔒 private skill) | maxassist-demo-patient-parser | — |
| Any Notion page look/structure (🔒 private skill) | notion-page-style | — |
| Project status changing across apps | notion-ticktick-project-sync | notion-page-style |
| Sorting the local Projects folder | dev-folder-organizer | the sync skill |
| Word / Excel / PPT / PDF deliverable | docx/xlsx/pptx/pdf | — |
| "Every day / later / remind me" | schedule | doing it once |
| Multi-source fact-checked report | deep-research | a plain web search |
| Build/edit a skill | skill-creator | — |
| Build vs. tailor a plugin | create-cowork-plugin vs cowork-plugin-customizer | each other |

The full (unredacted) signal table lives in `private/`.

---

## 4. The hard design question: triggering

A router skill has an inherent tension: **it should NOT hijack normal auto-triggering.** If you ask Claude to do a task directly, you want the relevant skill itself — not `ask-razor` explaining it.

**Resolution:** scope `ask-razor`'s description tightly to *meta* questions only — phrases where you're asking **about** skills, not asking to **do** the task:
- "which skill", "what should I use", "is there a skill for", "recommend a skill"
- "explain the X skill", "what does X skill do", "how do I use X"
- "list my skills for…", "what skills do I have"

It explicitly should **not** fire on direct task requests. This keeps it a router, not a gatekeeper.

---

## 5. Maintenance — DECISION: repo-backed (locked in)

A hardcoded skill list inside `ask-razor` goes stale every time you add/remove a skill. **Chosen approach: repo-backed**, with a baked-in fallback table for offline reasoning.

`ask-razor` treats this `razor-skills/` repo as its **source of truth**: it reads the per-skill docs (public `skills/*.md`, plus `private/skills/*.md` when available locally) so it always reflects the current set. If the repo isn't reachable, it falls back to the embedded table in §6. The rule in the skill: *"consult `razor-skills/skills/*.md` if available; otherwise use the embedded table below."*

Trade-off accepted: you must keep this repo updated when you add/remove skills (or have `skill-creator` regenerate the catalog). One source then feeds both humans and the router.

---

## 6. Draft SKILL.md (starting point)

> Draft for review, not an installed skill. Skills are saved via **Settings → Capabilities**; you can't install one from inside a session. When ready, use the `skill-creator` skill to formalize, eval, and tune the description.

```markdown
---
name: ask-razor
description: >
  Razor's personal skill router and explainer. Use ONLY when Razor is asking
  ABOUT his skills rather than asking to do a task: recommending which skill to
  use for a situation, explaining what a specific skill does or when it triggers,
  or listing/browsing his skill catalog. Trigger on phrases like "which skill
  should I use", "what should I use for", "is there a skill for", "recommend a
  skill", "explain the X skill", "what does the X skill do", "how do I use X",
  "what skills do I have for", "list my skills". Do NOT trigger on direct task
  requests (e.g. "write this work epic", "make a deck") — let those skills
  auto-fire normally.
---

# ask-razor

You are Razor's skill concierge. Pick one of three modes from his message.

## Source of truth (repo-backed)
If the repo `~/Documents/Development/Projects/razor-skills/` is accessible, read
`README.md` and the relevant `skills/*.md` (and `private/skills/*.md` locally)
for current, accurate detail. Otherwise fall back to the embedded table below.

## Mode A — Recommend (situation → skill)
1. Identify the intent signals in his request.
2. Give the TOP pick (one skill) + a one-line why.
3. If two skills overlap, name the runner-up and the single distinguishing factor.
4. Flag a better non-skill path if one exists.
5. If genuinely ambiguous, ask ONE clarifying question, then commit.
Keep it to a few sentences. Lead with the pick.

## Mode B — Explain (skill name → description)
Give: what it does, triggers, key rules/gotchas, and what it pairs/conflicts with.

## Mode C — Catalog (browse)
Return the relevant group from the catalog, one line per skill.

## Routing table (fallback; work-skill signals kept in private docs)
| Situation signal | Pick | Over |
|---|---|---|
| Work epic (private) | jira-epic-writer | jira-story-writer |
| Work story / AC (private) | jira-story-writer | jira-epic-writer |
| Work demo-data SQL (private) | maxassist-demo-patient-parser | — |
| Notion page look/structure (private) | notion-page-style | — |
| Project status change across apps | notion-ticktick-project-sync | notion-page-style |
| Sort the local Projects folder | dev-folder-organizer | the sync skill |
| Word doc | docx | — |
| Spreadsheet | xlsx | — |
| Slides/deck | pptx | — |
| PDF processing | pdf | — |
| "every day / later / remind me" | schedule | doing it once now |
| Multi-source fact-checked report | deep-research | plain web search |
| Create/edit/eval a skill | skill-creator | — |
| Build a new plugin | create-cowork-plugin | cowork-plugin-customizer |
| Tailor an existing plugin | cowork-plugin-customizer | create-cowork-plugin |
| CLAUDE.md for a repo | init | — |
| Review a PR | review | — |
| Security check a branch | security-review | — |

## Style
Match Razor's preferences: lead with the direct answer in 1–3 sentences, prose
over bullets, flag a better alternative when relevant.
```

---

## 7. Build steps (when you're ready)

1. ~~Decide source-of-truth model~~ — **done: repo-backed** (§5).
2. **Open `skill-creator`** and create the skill from the draft above.
3. **Tighten the description** — the make-or-break field; `skill-creator` can eval trigger accuracy so `ask-razor` fires on meta-questions but never steals direct task requests.
4. **Run eval cases**, e.g.:
   - "which skill for writing a work epic?" → recommends `jira-epic-writer` (Mode A) ✅
   - "write this work epic" → does NOT fire; `jira-epic-writer` runs ✅
   - "explain dev-folder-organizer" → Mode B ✅
   - "what skills do I have for documents?" → Mode C ✅
5. **Save it** via Settings → Capabilities.
6. **Keep the repo updated** when you add/remove skills (or have `skill-creator` regenerate this catalog).

---

## 8. Open questions for you
- Should `ask-razor` ever **invoke** the recommended skill for you, or only name it? *(Recommend: only name it — keeps it a safe, read-only advisor.)*
- Want it to cover MCP connectors/tools too (Jira, Notion, TickTick), or skills only? *(Skills-only is cleaner to start.)*
