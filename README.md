# devlog — project memory for Claude Code

A Claude Code plugin that gives any project a durable, on-the-record memory:

- **Progress log** (`docs/PROGRESS.md`) — newest-first, one dated entry per
  completed unit of work with a status marker (✅ DONE / 🟡 PARTIAL /
  ⛔ NOT STARTED), a scope note, real proof (test output, before/after), and
  cross-references. Reading the head of the file gives current state.
- **Decision log** (`docs/DECISIONS.md`) — append-only rows recording every
  consequential choice *with its why*, the alternatives rejected, and the
  proof — plus an Open Questions section for intentionally deferred decisions.
  Governing principle: decisions are not preferences; changing one requires
  going back to its recorded reasons.
- **Tickets** (`docs/tickets/`) — one markdown file per issue, filed at the
  moment of discovery instead of a TODO comment: Symptom → Evidence → Why it
  matters → Scope to decide. Closed by a status flip, never deleted.
- **Session-wrap** — the discipline that ties them together: before any
  commit, an evidence summary enumerating *every* touched file is verified
  against the actual diff, the three logs are updated, and only then does the
  commit happen — with the log updates in the same commit as the work.

The system was extracted from a production project where it kept dozens of
Claude Code sessions coherent across months: each session reads the head of
the progress log to know where things stand, files tickets for what it notices
but doesn't fix, and leaves a verifiable record of what it did.

## Install

From GitHub (once pushed):

```
/plugin marketplace add razamit/claude-devlog
/plugin install devlog@devlog-marketplace
```

From a local clone:

```
/plugin marketplace add /path/to/claude-devlog
/plugin install devlog@devlog-marketplace
```

For live development of the plugin itself: `claude --plugin-dir /path/to/claude-devlog`.

## Use

In any project, start with:

```
/devlog:init
```

This scaffolds the three artifacts (adapting to files you already have without
replacing them) and maintains an idempotent, clearly marked block in the
project's `CLAUDE.md`, so the discipline is available as standing instructions
in future sessions.

Best-effort proactivity comes from two places, no hooks required:

1. **The CLAUDE.md block** `/devlog:init` maintains — always in context and
   phrased as standing instructions ("noticing a defect you will not fix now →
   file a ticket").
2. **The skill descriptions** — they help Claude recognize when a skill is
   relevant and load its full conventions before writing.

This is model-directed behavior, not hard enforcement. Review generated log
updates with the same care as any other project documentation.

Explicit entry points, when you want to drive it yourself:

| Command | Does |
|---|---|
| `/devlog:session-wrap` | Full pre-commit close-out: evidence summary verified against the diff, progress entry, decision rows, ticket sweep. |
| `/devlog:tickets <issue>` | Investigate and file a ticket for the described issue. |
| `/devlog:progress-log` | Write the progress entry for this session's work. |
| `/devlog:decision-log <decision>` | Record a decision with its why, alternatives, and proof. |

## Why it works

- **Prepend-order progress** means "where are we?" is answered by reading the
  top of one file, not by archaeology.
- **Decisions carry their reasons**, so future sessions either respect them or
  consciously supersede them — never silently reverse them.
- **Tickets over TODOs** keep observations out of code comments and chat
  scrollback, with evidence attached while it's fresh.
- **The evidence summary** closes the gap that lets unrelated working-tree
  changes ride into commits unnoticed: if the diff shows a path, the summary
  must mention it.

## Layout

```
.claude-plugin/
  plugin.json         # plugin manifest
  marketplace.json    # lets this repo be added directly as a marketplace
skills/
  progress-log/       # the progress-log discipline (+ /devlog:progress-log)
  decision-log/       # the decision-log discipline (+ /devlog:decision-log)
  tickets/            # the ticket discipline        (+ /devlog:tickets)
  session-wrap/       # the pre-commit close-out     (+ /devlog:session-wrap)
  init/               # /devlog:init scaffolder + templates/
```

No hooks, no scripts, no dependencies — plain markdown skills, so it also
works by simply copying `skills/*` into a project's `.claude/skills/`.

## Limits

- Devlog improves continuity; it does not guarantee that every relevant event
  will be recorded automatically.
- Its file-based tickets complement rather than replace a shared issue tracker
  when work needs assignment, notifications, or cross-team reporting.
- `/devlog:session-wrap` prepares and verifies a close-out, but commits only
  when the user explicitly asks.

## Validation

Release checks and the recommended behavioral test matrix are documented in
[`TESTING.md`](TESTING.md).
