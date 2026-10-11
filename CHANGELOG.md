# Changelog

## 0.3.0 — 2026-10-11

Versions and releases, and building in public, join the record.

- New `releases` skill (+ `/devlog:releases status|propose|cut|tag`): every
  file that carries the version listed once in `docs/RELEASES.md`
  (canonical, mirrors, derived fields marked do not edit, build number, tag
  and changelog style), detected at init and never re-detected except by
  `status`; five drift checks and a one-line report at every wrap, unfixed
  drift filed as a ticket; progress entries stamped `[unreleased]` and
  flipped to `[X.Y.Z]` at the cut, one changelog bullet per entry ending
  with the entry date; the bump proposed from Added, Changed and Fixed with
  one line per criterion, pre-1.0 never proposing 1.0.0, build numbers only
  up; an eight-step cut (carriers moved together, grep shown, section
  renamed, fresh Unreleased, release entry, index row); annotated tags only
  on request and never pushed. Templates for `RELEASES.md` and a Keep a
  Changelog style `CHANGELOG.md`.
- New `posts` skill (+ `/devlog:posts ideas|draft|posted|fold|voice`): a
  post-ideas backlog in `docs/posts/IDEAS.md` mined from the progress log,
  decision rows, closed tickets, the changelog and git log, never from
  client correspondence, with four post-worthy tests; one file per post per
  platform, date-first with a platform marker (X, LinkedIn, Reddit, Indie
  Hackers, Show HN, forum, blog, newsletter, Facebook), variants sharing a
  slug; drafts in the user's voice from `VOICE.md`, no hype words, every
  number cited to the record; a six-check privacy gate at draft and again at
  posted; the body immutable once posted, metrics appended dated and
  sourced; public replies folded into tickets, decision rows and an FAQ.
  Templates for the post file, the platform profiles, the backlog and the
  voice file. Opt-in per project through a Building in public bullet in the
  CLAUDE.md block, so client projects are never nudged to post.
- `progress-log`: the version stamp on shipping entries, the one permitted
  edit to an old entry (the flip at the cut); public-post entries with
  scope `docs only, public`.
- `session-wrap`: post files and their assets in the evidence summary; a
  changelog feed, a release line and a post-worthy check in the log update;
  release commits and tags left to the `releases` skill.
- `init`: carriers and `CHANGELOG.md` detected in step 1; `docs/RELEASES.md`
  scaffolded from the registry, `CHANGELOG.md` only when absent; `docs/posts/`
  only when the user posts about the project; two new CLAUDE.md bullets and
  the two new entry points.
- `decision-log`: rows for version policy (canonical carrier, bump rule,
  0.1.0 start, bump override) and for public feedback that changes a choice.
- `tickets`: unfixed version drift as a ticket; tickets surfaced by a public
  comment cite the post file and quote the comment.

Versions 0.1.2 and 0.2.0 were never tagged. `/devlog:releases status` on
this repository reports both sections as untagged; the tags are a separate
decision.

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
