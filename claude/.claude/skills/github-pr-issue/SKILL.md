---
name: github-pr-issue
description: Create GitHub pull requests and issues in a consistent format via the gh CLI. Use whenever opening or editing a PR or issue. Defines required body structure; no AI attribution.
---

# github-pr-issue

Consistent structure for every GitHub PR and issue created via `gh`. Pairs with
the `gh-body-format` skill (heredoc escaping rules) — follow both.

## Hard rules

- **No AI attribution** anywhere in PR/issue titles or bodies (no
  "Generated with Claude Code", no co-author note).
- **PR/issue titles follow Conventional Commits** subject style — same types as
  the `commit` skill: `feat(scope): ...`, `fix: ...`, etc. The squash-merge
  commit derives from the PR title, so keep it conventional.
- **Always use a single-quoted heredoc** for `--body` (see `gh-body-format`).
  Write markdown plainly — no backslash escapes.

## Pull request format

Title: `<type>(<scope>): <imperative subject>`

Body template:

```bash
gh pr create --title "feat(scope): subject" --body "$(cat <<'EOF'
## Summary

One or two sentences: what this PR does and why.

## Changes

- Bullet per meaningful change, grouped if large.
- Reference packages/files by name.

## Testing

- How it was verified (commands run, manual steps, new tests).
- Paste relevant output or state "build + vet + test green".

## Notes

- Anything reviewers should know: trade-offs, follow-ups, deliberately-deferred
  work, migration/rollout steps. Omit the section if empty.

Closes #<issue-number>
EOF
)"
```

Rules:
- `## Summary` and `## Changes` are required. `## Testing` required when code
  changed. `## Notes` optional.
- Link the issue the PR closes with `Closes #N` (or `Refs #N` if it only
  relates).
- Keep it factual. State what was verified; don't claim tests passed unless they
  did.

## Issue format

Pick the matching shape.

### Bug
Title: `fix(scope): <short symptom>` or `bug: <short symptom>`

```bash
gh issue create --title "fix(queue): jobs stuck in running after worker crash" --body "$(cat <<'EOF'
## Description

What's wrong, in one or two sentences.

## Steps to reproduce

1. ...
2. ...

## Expected

What should happen.

## Actual

What happens instead. Include logs/output.

## Environment

Version / commit / OS as relevant.
EOF
)"
```

### Feature / task
Title: `feat(scope): <capability>` or `chore(scope): <task>`

```bash
gh issue create --title "feat(agent): add IaC analysis for Terraform" --body "$(cat <<'EOF'
## Goal

What we want and why it matters.

## Proposed approach

How we'd build it (high level). Optional if unknown.

## Acceptance criteria

- [ ] Concrete, checkable outcomes.
- [ ] ...

## Notes

Links, constraints, dependencies. Optional.
EOF
)"
```

## After creating

For any non-trivial body, verify GitHub rendered it correctly (catches escape
bugs):

```bash
gh pr view <num> --json body --jq .body      # or: gh issue view <num> ...
```

If backslashes appear before backticks/brackets/dollar signs, re-edit with
`gh pr edit` / `gh issue edit` using a single-quoted heredoc.

## Labels & metadata

- Add labels when the repo uses them: `--label bug`, `--label enhancement`.
- Assign with `--assignee @me` when taking the work.
- Set `--base <branch>` explicitly on PRs when the target isn't the default.

## Architecture Decision Records (ADRs)

If the repo keeps ADRs (an `docs/adr/`, `adr/`, or `doc/adr/` directory — check
once per repo), treat them as part of the PR, not a follow-up.

- **Add or update an ADR in the same PR whenever the change embeds an
  architectural decision** — a choice with trade-offs, a new abstraction /
  extension seam / pattern, a dependency or protocol change, or a reversal of a
  prior decision. Mechanical fixes, refactors, and docs don't need one. When in
  doubt, a one-paragraph ADR entry is cheap; skip it for the obviously-trivial.
- Capture **Context** (the forces), **Decision** (what was chosen + rejected
  alternatives), **Consequences** (what it buys / costs). Link the superseded
  ADR when reversing one.
- Follow the repo's existing ADR convention (file naming, numbering, index). If
  the repo has none and the decision is significant, propose starting the
  directory rather than inventing a scheme silently.

### On a new version release

**Always create the release's ADR** as part of cutting the tag — a record of
the decisions that release made (or that it's the first to ship). Add it to the
ADR index. This runs alongside the usual release prep (changelog, version-note
bumps); the tag shouldn't go out without it.
