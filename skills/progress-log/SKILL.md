---
name: progress-log
description: Record what was done at the end of each work session: newest-first dated entry in docs/PROGRESS.md with status (✅ DONE / 🟡 PARTIAL / ⛔ NOT STARTED), scope note, real proof (test output, before/after), files touched, cross-refs to decisions and tickets. Read the head to know current state. Use at session-end and to answer "where are we?"
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
**YYYY-MM-DD — <headline: what shipped, stated as the outcome> (<scope note>). <STATUS>**
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

## Rules

- Prepend; never rewrite or delete old entries. Corrections get a bracketed
  `[Update, YYYY-MM-DD: …]` inside the old entry or a new entry that names the
  old one.
- Entries are written by the session that did the work, while the evidence is
  fresh — not reconstructed later. (If one must be reconstructed, mark it
  `[backfilled]`.)

## When invoked directly (`/devlog:progress-log`)

Write the entry for this session's work now: derive the file list from
`git status --short` / `git diff --stat` (not memory), state the real proof
(actual test output), and prepend the entry. For a full pre-commit close-out
including the evidence-summary verification, use `/devlog:session-wrap`
instead.
