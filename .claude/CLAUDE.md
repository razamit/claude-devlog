# claude-devlog

The devlog plugin for Claude Code: plain markdown skills under `skills/`,
manifests under `.claude-plugin/`. Release checks live in `TESTING.md`.

<!-- devlog:start -->
## Devlog

This project keeps a written record. Maintain it without being asked.

- **Starting work** — read the head of `docs/PROGRESS.md` (newest entry
  first) to learn current state, and check `docs/DECISIONS.md` before
  proposing anything it may have already settled. Existing decision rows are
  binding: supersede one deliberately with a new row, never silently.
- **Noticing a defect or gap you will not fix now** — file a ticket in
  `docs/tickets/` (Symptom → Evidence → Why it matters → Scope to decide).
  Never leave it as a TODO comment, a silent skip, or a remark in chat.
- **Making a consequential choice** — record it in `docs/DECISIONS.md` with
  its why and the alternatives rejected. A decision whose reasons are not
  written down will be reversed by a future session that cannot see them.
- **Finishing a unit of work** — prepend an entry to `docs/PROGRESS.md`:
  status marker, scope note, real proof (actual test output, before/after),
  files touched, cross-refs. State red tests honestly; never imply
  completeness you have not verified.
- **Before any requested commit** — evidence summary naming every path in
  `git status --short` / `git diff --stat`, including incidental edits and
  deletions, verified against the actual diff; then the log updates above,
  in the same commit as the work; then commit. Never commit unless the user
  explicitly asked.
- **Client emails and calls** — every email to or from the client is
  filed in `docs/emails/` (date-first, `to_`/`from_`, the text as sent;
  replies transcribed beside the original), every call agenda, transcript
  and summary in `docs/calls/`, and what the client decided there goes into
  `docs/DECISIONS.md` attributed to the client, citing the file. Nothing
  the client decided lives only in a mailbox.
- **Versions and releases**: the files carrying the version are listed
  once in `docs/RELEASES.md` and never re-detected. A progress entry for
  work that reaches users ends `[unreleased]` and gets one bullet under
  `## Unreleased` in `CHANGELOG.md` (this repo's heading style, no
  brackets; renamed to `## X.Y.Z — YYYY-MM-DD` at the cut). Bump, cut and tag
  only through `/devlog:releases`: carriers move together, tags on request,
  nothing pushed by the skill; the real tag is `claude plugin tag`.

The `devlog` plugin skills (`progress-log`, `decision-log`, `tickets`,
`session-wrap`, `emails`, `calls`, `releases`, `posts`) hold the full
conventions. Read the relevant one before writing to these files.
<!-- devlog:end -->
