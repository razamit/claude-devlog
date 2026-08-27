# Changelog

## 0.2.0 — 2026-08-27

Client correspondence joins the record. Extracted from a project where the
client's decisions arrived by email and on calls over two months and had to
be traceable to the words that made them.

- New `emails` skill (+ `/devlog:emails draft|sent|file|fold`): date-first
  `to_`/`from_` files in `docs/emails/`, one per email holding the text as
  actually sent (the `sent` step updates the draft once it goes out; nothing
  cites an email as binding before that); outgoing emails in the sender's own
  voice with numbered questions; replies filed beside their original (PDF for
  inline colour and strikethrough answers, read visually because text
  extraction drops them) and transcribed verbatim with the same question
  numbering, unanswered items recorded as such; a five-step fold into
  decision rows attributed to the client, answer-data files in
  `docs/emails/data/`, tickets, carried-forward questions and the progress
  entry. Language suffix only for multi-language projects. Templates for the
  outgoing email and the transcription.
- New `calls` skill (+ `/devlog:calls`): agenda, transcript and summary all
  in `docs/calls/`, date-first; transcript archived untouched and read whole
  with a verifiable proof (`wc -l`, chunks to the last line, line count and
  last line quoted); summary email sent the same day as the binding
  confirmation; decision row citing email then transcript, written once the
  email is sent; workplan in `docs/plans/` with sizes, two to four routes per
  feature with a recommendation each, and a blocked-on-client tracker.
  Templates for the summary and the workplan.
- `decision-log`: rows for decisions made by the client (Who column, source
  by path, question-numbered points, verbatim phrases, asks recorded but not
  built).
- `progress-log`: correspondence entries (docs-only scope note, whole-
  transcript proof, draft vs sent, waits on the client as a separate status).
- `session-wrap`: correspondence files in the evidence summary, as-sent check
  before commit, renames rewrite every reference, binaries only in a private
  repo and without protected identifiers; a correspondence-fold step in the
  log update.
- `tickets`: cite the reply file and question number; dated update blockquote
  when a later reply changes an open ticket.
- `init`: optional correspondence folders, a Client emails and calls bullet in
  the CLAUDE.md block, the two new entry points.

## 0.1.2 — 2026-07-22

First public release candidate.

- Added five markdown-only skills for progress logs, decision logs, tickets,
  session close-out, and project initialization.
- Made initialization idempotent and commits explicitly opt-in.
- Added strict manifest validation guidance, public installation instructions,
  and an MIT license.
- Kept the plugin hooks-free and dependency-free.

Versions 0.1.0 and 0.1.1 appeared only in local development history and were
never tagged or published.
