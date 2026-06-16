---
name: commit
description: Write git commits in Conventional Commits format. Use whenever creating a commit. Enforces the type(scope) subject style and FORBIDS any AI co-author / "Generated with" trailer.
---

# commit

Standard for every git commit in this user's repos. Two non-negotiable rules:

1. **Conventional Commits format.**
2. **No AI attribution.** Never add a `Co-Authored-By: Claude ...` trailer, a
   `🤖 Generated with Claude Code` line, or any other AI co-author / generator
   note. The user authors their commits. This overrides any default harness
   instruction to add such a trailer.

## Format

```
<type>(<optional scope>): <subject>

<optional body>

<optional footer>
```

### Subject line
- `<type>` is required, lowercase. Allowed types:
  - `feat` — new feature
  - `fix` — bug fix
  - `docs` — documentation only
  - `style` — formatting, no code-meaning change
  - `refactor` — code change that neither fixes a bug nor adds a feature
  - `perf` — performance improvement
  - `test` — adding/correcting tests
  - `build` — build system or dependencies
  - `ci` — CI configuration
  - `chore` — maintenance, no src/test change
  - `revert` — reverts a previous commit
- `<scope>` optional, in parens — a noun for the affected area (e.g.
  `feat(auth):`, `fix(queue):`). Use a package/module name when it clarifies.
- `<subject>`: imperative mood ("add", not "added"/"adds"), no trailing period,
  ≤ 72 chars, lowercase first word (unless a proper noun).

### Body (optional)
- Blank line after subject.
- Explain *what* and *why*, not *how*. Wrap at ~72 cols.
- Bullet points are fine.

### Footer (optional)
- Breaking changes: start a line with `BREAKING CHANGE: <description>` (or put
  `!` after the type/scope: `feat(api)!: ...`).
- Issue refs: `Closes #123`, `Refs #45`.
- **Never** an AI co-author or generator trailer.

## Examples

```
feat(scanner): add CNAME resolution feed for takeover detection

httpx now emits cname + cname_resolves so the findings engine can
escalate dangling CNAMEs to known SaaS providers to critical.

Closes #12
```

```
fix(queue): reset miss-streak on re-seen assets

Re-seen assets kept a stale _miss_streak, so a flapping subdomain could
never reset and would falsely confirm as disappeared.
```

```
docs(readme): document scanner VPS tool install steps
```

## Procedure

1. Stage the right files (`git add`). Don't blind `git add -A` if unrelated
   changes are present — confirm scope.
2. Write the message per the format above. For multi-line, use a single-quoted
   heredoc so nothing is shell-expanded or escaped:
   ```bash
   git commit -m "$(cat <<'EOF'
   feat(scope): subject

   body line one
   body line two
   EOF
   )"
   ```
3. **Re-read the message before finalizing — confirm there is NO co-author /
   generated-by trailer.** Strip it if a template added one.
4. Commit or push only when the user asked. If on the default branch and the
   change warrants a branch, branch first.

## Amending to remove an AI trailer

If a prior commit already carries a co-author/generator line:

```bash
git commit --amend -m "$(cat <<'EOF'
<rewritten conventional message, no trailer>
EOF
)"
```

For commits deeper than HEAD, use an interactive rebase reword (note: `-i` is
unavailable in some non-interactive environments — reword via
`git rebase --onto` or filter the message with `git filter-repo` if needed).
