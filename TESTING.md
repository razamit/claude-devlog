# Testing

Devlog is a markdown-only plugin, so its highest-value tests combine strict
manifest validation with behavioral checks in a disposable Git repository.

## Release gate

Run these checks before tagging a release:

```sh
claude plugin validate .claude-plugin/plugin.json --strict
claude plugin validate .claude-plugin/marketplace.json --strict
git diff --check
claude plugin tag --dry-run .
```

Validate `plugin.json` directly: validating the repository root selects the
marketplace manifest and may not report invalid skill frontmatter.

## Behavioral test matrix

1. **Fresh initialization** — run `/devlog:init` in an empty Git repository;
   verify it creates the two logs, ticket directory and template, and one
   marked `## Devlog` block with today's date.
2. **Idempotent initialization** — run `/devlog:init` again; verify no file is
   duplicated, no historical content changes, and only one Devlog block exists.
3. **Existing conventions** — start with non-default progress, decision, and
   issue paths; verify init reuses them and writes their real paths everywhere.
4. **Partial existing setup** — provide only one or two artifacts; verify init
   preserves them and creates only what is missing.
5. **Progress entry** — complete a small change and invoke `progress-log`;
   verify the entry is prepended and includes status, scope, actual proof,
   every touched path, and relevant cross-references.
6. **Decision entry** — record a choice with alternatives; verify a new stable
   row is appended with reasons, rejected alternatives, proof, and affected
   files rather than rewriting earlier rows.
7. **Ticket lifecycle** — discover, file, and close a defect; verify concrete
   evidence is captured and closure updates status without deleting the file.
8. **Clean session wrap** — request a commit after a verified change; confirm
   every changed path appears in the evidence summary and all log updates land
   in the same commit.
9. **Unrelated working-tree changes** — leave a pre-existing modification;
   verify session-wrap identifies it and excludes it through selective staging.
10. **No commit authorization** — invoke session-wrap without asking for a
    commit; verify it updates or presents the close-out but leaves the working
    tree uncommitted.
11. **Red or skipped tests** — wrap a partial change; verify the progress entry
    states the failure or skipped verification honestly and tracks follow-up.
12. **Automatic discovery** — in a normal Claude Code session, create moments
    matching each skill description and assess whether the relevant skill is
    selected without explicit invocation.

Automatic discovery is probabilistic. Run those scenarios several times and
track the success rate rather than treating one run as proof.
