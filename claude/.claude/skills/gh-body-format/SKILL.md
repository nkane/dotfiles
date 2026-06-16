---
name: gh-body-format
description: Format gh CLI PR/issue/comment bodies correctly. Prevents the recurring bug where backslash-escaped markdown ends up rendered literally on GitHub.
---

# gh-body-format

## The bug this prevents

Writing `gh pr create --body "$(cat <<'EOF' ... EOF\n)"` with backslash-escaped backticks inside the heredoc. Bash's single-quoted heredoc does **not** interpret escapes, so `\`code\`` enters the body verbatim and GitHub renders it as `\`code\`` (literal backslash-backtick) instead of formatted code.

This has bitten the user enough times in the chippy repo to require bulk audits + per-PR re-edits.

## The rules

1. **Single-quoted heredoc = write markdown plainly.** No backslash escapes, ever. Just write what should render.
   ```bash
   gh pr create --body "$(cat <<'EOF'
   - `code` not \`code\`
   - $variable not \$variable
   - [link](url) not \[link\]\(url\)
   EOF
   )"
   ```

2. **Double-quoted heredoc = shell expands.** Use only if you need `$VAR` interpolation. Then backslash escapes do matter, but you almost never want this for PR bodies (PR text is static markdown).

3. **Default to single-quoted.** Pick `<<'EOF'` for every PR / issue / comment body unless you have a specific interpolation need.

4. **Verify after submitting if the body is non-trivial.** Run:
   ```bash
   gh pr view <num> --json body --jq .body
   ```
   If backslashes appear in front of backticks / brackets / dollar signs, fix with:
   ```bash
   gh pr edit <num> --body "$(cat <<'EOF'
   <correct body>
   EOF
   )"
   ```

## Applies to

- `gh pr create --body`
- `gh pr edit --body`
- `gh issue create --body`
- `gh issue edit --body`
- `gh pr comment --body`
- `gh issue comment --body`
- `gh release create --notes`
- Any other gh subcommand that takes a free-form markdown body.

## Quick mnemonic

Single-quoted heredoc = WYTIWYG (what you type is what you get). Don't pre-escape. The shell isn't reading it.
