---
name: obsidian-sync
description: Keep tracked Obsidian notes (Session Handoff, daily drivers, dashboards) in sync with live vault state. Use when the user says "update the handoff", "sync the handoff note", "keep the handoff up to date", finishes a study/work session, or asks to refresh any note that summarizes other notes. Reads source notes (checklists, problem logs, frontmatter), rewrites the summary note's status + date, and applies the vault's writing conventions.
---

# obsidian-sync

Keep a **summary note** (one that restates state held in *other* notes) current with
the live vault. The canonical case is a **Session Handoff** note, but the same job
applies to daily drivers and dashboards. The note is derived data — regenerate its
volatile sections from the sources of truth, don't hand-edit and drift.

## When to run

- User says: "update / sync / refresh the handoff", "keep the handoff up to date".
- A study or work **session just completed** — capture it before context is lost.
- User asks to update any note that summarizes others (dashboards, indexes, status notes).

If nothing in the sources changed, **say so and make no edit** — don't write a no-op.

## Find the vault and the note

1. Locate the vault root: the dir containing a `.obsidian/` folder (walk up from cwd, or
   the path the user names). Confirm with `ls <root>/.obsidian` before writing.
2. Find the summary note. Default name patterns: `Session Handoff.md`, `*handoff*`,
   `daily-prep.md`, dashboard/index notes. If more than one matches and the user didn't
   name one, ask which.
3. Identify the **sources of truth** that feed it. For a FANG-prep handoff these are:
   - `daily-prep.md` — current week + the day-by-day checklist (`[x]` = done, with `✅ DATE`).
   - `problem-log/*.md` frontmatter — `solved_unaided`, `redo_on`, `date` per problem.
   - `problem-log.base` / `weeks.base` views and the week notes.
   Generalize: whatever the summary note claims as "current status," read it from the note
   that actually owns that fact.

## What to update

Rewrite only the **volatile** sections; leave prose/structure intact.

- **Date stamp(s):** the `Last updated YYYY-MM-DD` line and any `## Current status (DATE)`
  heading → today's date (the date is given in session context; never guess).
- **Status:** which week/day/task is done, what's in progress, what's next. Derive from the
  checklist state and log frontmatter — don't trust the note's own stale claim.
- **Derived tables/queues:** e.g. a "Redo queue due DATE" line → recompute from each
  problem's `redo_on` vs today. A problem whose `redo_on <= today` is due.
- **Next-session pointer:** keep it accurate to the new state.

Read the sources first, compute the new state, then diff it against the note. Edit only the
lines that actually changed. Report the diff to the user in one or two lines.

## Vault writing conventions (do NOT re-break these)

These are hard rules — the user runs the Obsidian **Linter**, which punishes violations.

- **No wikilinks in YAML frontmatter.** The Linter mangles unquoted `[[...]]` in properties
  into nested-list garbage. Frontmatter category fields (e.g. `topic:`) are **quoted string
  categories** (`"Algorithms & DS"`, `"Math"`). All `[[wikilinks]]` live in the note **body**.
- **Blank line before a markdown table** when it follows a paragraph or bold line, or it
  renders as literal text. (A table directly under a `####` heading is fine.)
- **NeetCode problem URLs need the `/question` suffix:**
  `https://neetcode.io/problems/<slug>/question`. Slugs differ from LeetCode
  (Valid Palindrome = `is-palindrome`, Best Time Buy/Sell = `buy-and-sell-crypto`).
- Preserve existing `tags:`, frontmatter key order, and callout/embed syntax
  (`![[note#Section]]`). Don't reformat untouched sections.

## Honesty rules

- Report state faithfully. If a session was assisted/skipped, the note must say so —
  don't upgrade `solved_unaided` or invent progress.
- Convert relative dates ("tomorrow", "next week") to absolute `YYYY-MM-DD`.
- If the note is already current, state that and stop. No cosmetic edits.

## Quick procedure

1. Resolve vault root + summary note + sources.
2. Read sources, compute current state (done/in-progress/next, due queues, dates).
3. Diff vs the note; `Edit` only changed lines, honoring the conventions above.
4. Tell the user what changed (or that nothing did) in 1–2 lines.
