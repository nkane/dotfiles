---
name: adr
description: Create and maintain Architecture Decision Records (ADRs). Use whenever recording, superseding, or revisiting an architectural/technical decision, or when the user mentions ADR, decision record, design decision, or "why did we choose X". Scaffolds numbered files, keeps the index current, and manages status lifecycle.
---

# adr

An **Architecture Decision Record** captures one significant decision: the
context, the choice, and its consequences. One decision per file, immutable once
accepted — change of mind = a *new* ADR that supersedes the old one. Never
rewrite the substance of an accepted ADR; only its status/links may change.

## Where ADRs live

Default location, in order of preference:

1. An existing ADR dir if the repo already has one — detect with:
   ```bash
   ls docs/adr docs/adrs docs/decisions doc/adr .adr 2>/dev/null
   ```
2. Otherwise `docs/adr/`. Create it if absent.

Filename: `NNNN-kebab-case-title.md`, zero-padded 4-digit sequence starting at
`0001`. Next number = highest existing + 1.

```bash
ls docs/adr/[0-9]*.md 2>/dev/null | sed 's#.*/##' | sort | tail -1
```

## Status lifecycle

```
proposed → accepted → deprecated
              │
              └→ superseded by NNNN
rejected   (terminal — kept for the record, never deleted)
```

- **proposed** — drafted, not yet agreed.
- **accepted** — the decision in force. Body is now immutable.
- **rejected** — considered and declined. Keep the file; it is decision history.
- **deprecated** — no longer relevant, with no direct replacement.
- **superseded by NNNN** — replaced by a newer ADR. Add the back-link in both
  files (old points forward, new points back).

## Template

```markdown
# NNNN. <Short title of the decision>

- **Status:** proposed
- **Date:** YYYY-MM-DD
- **Deciders:** <names / roles>
- **Supersedes:** <ADR link, or omit>
- **Superseded by:** <ADR link, or omit>

## Context

The forces at play: the problem, constraints, requirements, and assumptions.
State facts, not the choice. Why does a decision need making *now*?

## Decision

"We will …" — the choice, stated in active voice. Be specific and concrete.

## Consequences

What becomes easier and what becomes harder as a result. Include positive,
negative, and neutral outcomes, plus follow-up work the decision creates.

## Alternatives considered

- **<Option A>** — why not chosen.
- **<Option B>** — why not chosen.
```

Get the **Date** from `date +%F` — never invent it.

## Index

Maintain `docs/adr/README.md` as a table of contents. Add a row on every new
ADR; update the status cell on any status change.

```markdown
# Architecture Decision Records

| #    | Title                       | Status   | Date       |
|------|-----------------------------|----------|------------|
| [0001](0001-use-postgres.md) | Use PostgreSQL | accepted | 2026-06-16 |
```

## Procedure — new ADR

1. Locate/confirm the ADR dir; compute the next number.
2. Write `NNNN-title.md` from the template. Default status `proposed` unless the
   user says the decision is already made (then `accepted`).
3. Fill Context / Decision / Consequences / Alternatives from the discussion.
   Ask the user only for genuinely missing forces — don't pad.
4. Add the row to `docs/adr/README.md` (create the index if absent).
5. Don't commit unless asked. When committing, use the `commit` skill —
   e.g. `docs(adr): add 0007 adopt event-sourced ledger`.

## Procedure — supersede an existing ADR

1. Write the new ADR with `Supersedes: [NNNN](NNNN-old.md)`.
2. In the old ADR, set `Status: superseded by MMMM` and add
   `Superseded by: [MMMM](MMMM-new.md)`. This is the **only** edit allowed to an
   accepted ADR's file besides status — leave its Context/Decision/Consequences
   intact.
3. Update both rows in the index.

## Rules

- One decision per ADR. Split compound decisions into separate records.
- Accepted ADRs are append-only history — supersede, don't rewrite.
- Never delete an ADR (even rejected ones). The trail is the point.
- Keep titles outcome-oriented ("Use X", "Adopt Y", "Drop Z"), not vague
  ("Database stuff").
