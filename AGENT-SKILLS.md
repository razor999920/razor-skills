# Agent Skills (`~/.agents/skills/`)

A second set of **21 skills** installed at `~/.agents/skills/` — the **Matt Pocock engineering-skills toolkit**. These are **for Claude Code (terminal)**, not Cowork: the Claude desktop app doesn't scan `~/.agents/skills/`, so they don't appear in the Cowork skill list.

To make Claude Code pick them up, run [`link-agents-skills.sh`](./link-agents-skills.sh), which symlinks each into `~/.claude/skills/`.

> These are third-party, externally managed (tracked by `~/.agents/.skill-lock.json`). Update them through their own installer, not by editing files here. This page is a reference only.

---

## Setup & meta

| Skill | What it does |
|---|---|
| `setup-matt-pocock-skills` | One-time repo setup for the toolkit — configures the issue tracker, triage label vocabulary, and domain-doc layout. Run once before first use of the other engineering skills. |
| `ask-matt` | A router over the user-invoked skills in the repo — ask which skill or flow fits your situation. (The toolkit's analog of your `ask-razor`.) |
| `find-skills` | Discover and install agent skills. Triggers on "how do I do X", "find a skill for X", "is there a skill that can…". |
| `writing-great-skills` | Reference for writing and editing skills well — the vocabulary and principles that make a skill predictable. |
| `handoff` | Compact the current conversation into a handoff document for another agent to pick up. |

## Planning & specs

| Skill | What it does |
|---|---|
| `decision-mapping` | Turn a loose idea into a sequenced map of investigation tickets, then drive them to resolution one at a time. |
| `grill-with-docs` | A relentless interview to sharpen a plan or design, producing ADRs and a glossary as it goes. |
| `loop-me` | Grill you about specs for the workflows you want to build, within the workspace. |
| `to-prd` | Turn the current conversation into a PRD and publish it to the project issue tracker — synthesis, no interview. |
| `to-issues` | Break a plan/spec/PRD into independently-grabbable issues using tracer-bullet vertical slices. |
| `prototype` | Build a throwaway prototype — a runnable terminal app for state/logic questions, or several toggleable UI variations from one route. |

## Design & architecture

| Skill | What it does |
|---|---|
| `codebase-design` | Shared vocabulary for designing deep modules — interfaces, seams, testability, AI-navigability. |
| `domain-modeling` | Build and sharpen a project's domain model / ubiquitous language; record architectural decisions. |
| `improve-codebase-architecture` | Scan a codebase for "deepening" opportunities, present them as a visual HTML report, then grill through whichever you pick. |

## Build & quality

| Skill | What it does |
|---|---|
| `implement` | Implement a piece of work based on a PRD or set of issues. |
| `tdd` | Test-driven development — red-green-refactor, integration tests, test-first feature/bug work. |
| `diagnosing-bugs` | Diagnosis loop for hard bugs and performance regressions. Triggers on "diagnose"/"debug this" or reports of something broken/throwing/failing/slow. |
| `review` | Review changes since a fixed point along two axes — Standards (repo coding standards) and Spec (matches the originating issue/PRD) — in parallel sub-agents, reported side by side. |
| `triage` | Move issues and external PRs through a state machine of triage roles — categorise, verify, grill, and write agent-ready briefs. |

## Safety

| Skill | What it does |
|---|---|
| `git-guardrails-claude-code` | Sets up Claude Code hooks that block dangerous git commands (`push`, `reset --hard`, `clean`, `branch -D`, etc.) before they execute. |

## Learning

| Skill | What it does |
|---|---|
| `teach` | Teach you a new skill or concept, within the workspace. |

---

## How this set differs from your Cowork skills

| | Cowork skills (this repo's `skills/`) | Agent skills (this page) |
|---|---|---|
| **Location** | Synced from Settings → Capabilities | `~/.agents/skills/` |
| **Used by** | Cowork (desktop app) | Claude Code (terminal) |
| **Authored by** | You (+ Anthropic defaults) | Matt Pocock toolkit (third-party) |
| **How to enable** | Settings → Capabilities | `link-agents-skills.sh` → `~/.claude/skills/` |
| **Focus** | Your workflows (Jira, Notion, docs) | Generic software-engineering loop |
