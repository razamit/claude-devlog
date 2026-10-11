# `/devlog:init` writes `CLAUDE.md` at the repo root, which fails `claude plugin validate --strict` when the repo is itself a plugin

Status: OPEN · Priority: LOW · Type: skill gap (init) · Cost: none

> Surfaced by running `/devlog:init` on this repository on 2026-10-11 (decision
> row 5 records the workaround used here). Affects only repositories that are
> Claude Code plugins; ordinary projects are unaffected.

## Symptom

After init created `CLAUDE.md` at the root, the first command of the release
gate in `TESTING.md` failed.

## Evidence

```
$ claude plugin validate .claude-plugin/plugin.json --strict
Validating plugin: /Users/amitraz/Projects/claude-devlog/CLAUDE.md
⚠ Found 1 warning:
  ❯ root: CLAUDE.md at the plugin root is not loaded as project context. To ship context with your plugin, use a skill (skills/<name>/SKILL.md) instead.
✘ Validation failed (--strict treats warnings as errors)

$ mv CLAUDE.md .claude/CLAUDE.md && claude plugin validate .claude-plugin/plugin.json --strict
✔ Validation passed
```

## Why it matters

The release gate blocks tagging until the warning is gone, so any plugin
repository that adopts devlog hits this on its next release. It is not a
runtime problem: the block is still loaded from `.claude/CLAUDE.md`.

## Scope to decide

- Option A — `init` step 3 detects `.claude-plugin/plugin.json` and writes the
  block to `.claude/CLAUDE.md` instead of the root, saying so in the report.
- OR Option B — `init` keeps writing the root file and `TESTING.md` documents
  the move as a manual step for this repository only.

No code change made by this ticket — it is an observation on the record.
