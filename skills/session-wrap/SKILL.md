---
name: session-wrap
description: 'Pre-commit close-out: enumerate EVERY file touched (verified against git diff to catch stray changes), update the progress log, decision log, and tickets, then prepare the requested commit. Closes the gap that lets unrelated working-tree changes ride into commits unnoticed. Use before every commit that changed code; never commit unless the user explicitly asked.'
disable-model-invocation: false
---

# Session wrap — the evidence summary and close-out

Before a requested commit for a session that changed files, run this close-out
in order. The logs are written while the evidence is fresh, and a commit
happens only after the record matches the diff.

## 1. Evidence summary — every file, no exceptions

Enumerate **every file touched**, from `git status --short` (pre-commit working
tree) or `git diff --stat` — not from memory. The summary must include:

- files modified incidentally (a stale test deleted during a refactor, an
  import-only edit to a sibling module, a fixture rename);
- files modified for reasons unrelated to the headline change;
- all deletions.

Then **verify: compare the summary against the actual diff**. If the diff
shows a path the summary does not mention, the summary is incomplete — fix it
before committing. A file that was touched but not listed is exactly the gap
that lets pre-existing-but-unrelated changes ride into commits unnoticed. The
rule applies whether the touch is a one-line tweak or a full rewrite: if the
diff shows the path, the summary mentions it.

For each file, one line: the path and why it changed — including the honest
"unrelated: was already modified in the working tree, excluded from this
commit" case (then actually exclude it via selective staging).

## 2. Update the logs

With the summary in hand:

- **Progress entry** — per the `progress-log` skill: dated headline, scope
  note, status marker, proof, the file list, cross-refs.
- **Decision rows** — per the `decision-log` skill, one row per consequential
  choice made this session. If you locked a behaviour or rejected an
  alternative, that is a row.
- **Ticket sweep** — per the `tickets` skill: close (never delete) tickets
  this work fixed, naming them in the progress entry; file new tickets for
  everything observed but not fixed. Nothing surfaced this session may live
  only in the conversation.

## 3. Commit, only when requested

If the user explicitly requested a commit, commit only now. The commit includes
the log updates in the same commit as the work they describe, so the record
cannot drift from the code. The commit message's body should agree with the
progress entry's headline. Otherwise, stop after presenting the close-out and
leave the changes uncommitted.

## Honesty requirements

- If tests are red, both the summary and the progress entry say so, with the
  failure named and tracked (a ticket or an explicit follow-up).
- If a step was skipped (no tests run, docs not updated), state it — do not
  imply completeness.
- Partial work is committed as `🟡 PARTIAL` with the remainder tracked, never
  silently presented as done.

## When invoked directly (`/devlog:session-wrap`)

Perform the full close-out now, in the order above: evidence summary from the
actual git state, verification against the diff, log updates, then present the
result and — only if the user has asked for a commit — commit. If the project
has no devlog files yet, offer `/devlog:init` first.
