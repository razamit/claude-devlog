---
name: progress-log
description: 'Record what was done at the end of each work session: newest-first dated entry in docs/PROGRESS.md with status (✅ DONE / 🟡 PARTIAL / ⛔ NOT STARTED), scope note, real proof (test output, before/after), files touched, cross-refs to decisions and tickets, version stamp. Read the head to know current state. Use at session-end and to answer "where are we?"'
disable-model-invocation: false
---

# Progress log — one entry per unit of work, newest first

`docs/PROGRESS.md` (or the path the project's CLAUDE.md names) is the
chronological record of what was actually done, in prepend order: the newest
entry is always at the top, so reading the head of the file gives current state.

## When to write

At the end of every session that completed (or partially completed) a unit of
work. One entry per unit — if a session shipped two independent things, write
two entries.

## Entry format

```markdown
**YYYY-MM-DD — <headline: what shipped, stated as the outcome> (<scope note>). <STATUS> [unreleased]**
<One dense paragraph: what changed and why (the trigger or root cause), the
proof, files touched, and cross-references.>
```

Status markers, used exactly:

- `✅ DONE` — complete and verified.
- `🟡 PARTIAL` — state explicitly what is done and what remains, and where the
  remainder is tracked (a ticket, a named follow-up step).
- `⛔ NOT STARTED` — used when re-stamping a planned item's status.

## The scope note

A parenthetical after the headline stating the blast radius, so a reader can
tell at a glance what kind of change this was: `offline, code + tests + docs`,
`docs only`, `one paid API call $0.07 to record, replays offline`, `schema
migration — requires deploy step`. If the project tracks external spend, the
note always says whether money was spent and how much.

## The proof

Every entry states how the work was verified: test counts (`101 passed`),
before/after values, the command run. "Should work" is not proof. If the suite
is red or a known failure remains, the entry says so explicitly and names where
it is tracked — an honest entry that admits red tests is worth more than a
clean-looking one that hides them.

## Cross-references

Name, by file or row, everything this entry touches in the rest of the system:

- Tickets closed by this work (and tickets opened for what it surfaced).
- The decision-log rows recording choices made here.
- The spec/plan section this implements, if the project has one.

## The version stamp

An entry for work that reaches users ends its headline with `[unreleased]`.
When the release is cut, the `releases` skill flips it to the version it
shipped in, `[1.3.0]`, so `grep '\[1.3.0\]' docs/PROGRESS.md CHANGELOG.md`
returns the release section and every entry in it. Docs-only and
correspondence entries carry no stamp. In the same wrap step that writes
the entry, one user-facing bullet goes under `## [Unreleased]` in the
changelog, ending with the entry date; the entry keeps the why, the proof
and the files, so nothing is written twice (see the `releases` skill).

## Correspondence entries

Filing an email or processing a call is a unit of work and gets its own
entry (see the `emails` and `calls` skills):

- Scope note: `docs only, no code, no spend` unless code changed.
- Proof: for a call summary, that the WHOLE transcript was read, with its
  length and last line (`written against the full 877-line transcript, read
  to line 877`); for a reply, what the answers were checked against (the workbook,
  the database, the report) and what the check found.
- Name every email file and whether it is a draft or was sent (and when);
  name the transcript, the summary, the decision row, the workplan, the
  tickets.
- What waits on the client is stated as a separate status: `✅ DONE (filing
  + analysis). ⛔ NOT STARTED: the production run, waiting for their answer
  on question 5`, with a pointer to where the wait is tracked. A call whose
  summary email has not gone out yet says so: `decision row pending the send`.

## Public posts

Publishing a post, or folding its replies, is a unit of work with its own
entry (see the `posts` skill): scope note `docs only, public`, one entry per
publishing session naming each post file, with the proof that the privacy
gate passed and that the file holds the text as posted. Folding replies
gets a separate entry naming the tickets, decision rows and FAQ entries it
produced.

## Rules

- Prepend; never rewrite or delete old entries. Corrections get a bracketed
  `[Update, YYYY-MM-DD: …]` inside the old entry or a new entry that names the
  old one. The one exception is the version stamp: `[unreleased]` is flipped
  to `[X.Y.Z]` at the cut, by the `releases` skill.
- Entries are written by the session that did the work, while the evidence is
  fresh — not reconstructed later. (If one must be reconstructed, mark it
  `[backfilled]`.)

## When invoked directly (`/devlog:progress-log`)

Write the entry for this session's work now: derive the file list from
`git status --short` / `git diff --stat` (not memory), state the real proof
(actual test output), and prepend the entry. For a full pre-commit close-out
including the evidence-summary verification, use `/devlog:session-wrap`
instead.
