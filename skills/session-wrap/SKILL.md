---
name: session-wrap
description: 'Pre-commit close-out: enumerate EVERY file touched (verified against git diff to catch stray changes), update the progress log, decision log, and tickets, then prepare the requested commit. Closes the gap that lets unrelated working-tree changes ride into commits unnoticed. Use before every commit that changed code; never commit unless the user explicitly asked. Also feeds the changelog, checks version drift, and, when the project builds in public, keeps the post-ideas backlog.'
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

Correspondence files are files like any other and appear in the summary:
`docs/emails/`, `docs/calls/`, `docs/plans/`. Three checks specific to them:

- An email drafted this session and sent by the user must already hold the
  text as sent, with its title flipped from draft to sent, before the commit
  (the `sent` step of the `emails` skill; ask for the as-sent text if the
  user has not pasted it). A committed draft that pretends to be the sent
  text misattributes words to the client.
- Renames (for example to the date-first form) go through `git mv`, and
  every reference is rewritten in the same commit: grep the old name across
  the repo and show zero hits in the summary.
- Binaries and transcripts (a reply PDF, a call transcript) are committed
  only when the repository is private and they are free of protected
  identifiers (ID numbers, credentials, account numbers); see the Privacy
  section of the `emails` skill. What was kept out is named, with where it
  lives instead.

Post files (`docs/posts/`) appear in the summary too. A file whose title
says Posted must hold the text as posted, the URL and a passed privacy-gate
line (the `posted` step of the `posts` skill). Every image under
`docs/posts/assets/` touched this session is opened and looked at for
credentials, paths with usernames and personal data before it is committed.

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
- **Correspondence fold** — per the `emails` and `calls` skills: every reply
  filed or call processed this session has its decision row attributed to
  the client, its answer-data files, its tickets, and its unanswered items
  carried into the next email or the blocked-on-client tracker.
- **Changelog feed**: per the `releases` skill, one user-facing bullet under
  `## [Unreleased]` in the changelog for every entry stamped `[unreleased]`
  this session, ending with the entry date.
- **Release line**: one line stating the canonical version, whether the
  carriers and the tag agree, and how many entries are unreleased. On drift,
  the line says so and points at `/devlog:releases status`; drift not fixed
  this session becomes a ticket.
- **Post-worthy check**: only when the Devlog block in CLAUDE.md has a
  "Building in public" bullet. Run the four tests of the `posts` skill
  (visible to a user, decision with a non-obvious why, a number changed, a
  mistake with a lesson) over this session's entries and rows. One IDEAS.md
  row and one line in the close-out per hit; nothing drawn from
  `docs/emails/`, `docs/calls/` or a client-attributed row. If the oldest
  open row is over 14 days old, say so in one line and add no row for it.

## 3. Commit, only when requested

If the user explicitly requested a commit, commit only now. The commit includes
the log updates in the same commit as the work they describe, so the record
cannot drift from the code. The commit message's body should agree with the
progress entry's headline. Otherwise, stop after presenting the close-out and
leave the changes uncommitted. Release commits are cut by the `releases`
skill, carriers and changelog section together; tags are made only by
`/devlog:releases tag`, never here.

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
