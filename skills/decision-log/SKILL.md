---
name: decision-log
description: Record decisions that would be forgotten if not written down — in docs/DECISIONS.md as an append-only table. Every row includes WHY (the specific reasons that would need to change to reverse it), alternatives rejected and why each lost, and proof. Use when choosing between approaches, locking a behaviour, deviating from the spec, or deferring a choice. Decisions are not preferences; changing one requires revisiting its reasons.
disable-model-invocation: false
---

# Decision log — decisions are not preferences

`docs/DECISIONS.md` (or the path the project's CLAUDE.md names) records every
consequential choice. The governing principle: **these are not preferences —
they are decisions made for specific reasons, and changing them requires going
back to those reasons.** A decision whose why is not written down will be
silently reversed by a future session that cannot see it.

## When to record

- Choosing between genuine alternatives (library, architecture, provider,
  algorithm) — especially when the rejected option looked viable.
- Locking a behaviour ("on breach the run HARD-FAILS, not warns").
- Deviating from the spec, a convention, or an earlier decision.
- Retiring an approach (record what replaced it and why the old one lost).
- Rejecting a ticket as won't-fix.
- A client or stakeholder answering a question by email or on a call. Those
  are decisions too, and the most easily lost (see below).
- Version policy: which carrier is canonical, the bump rule, starting a
  project at 0.1.0, overriding a proposed bump (see the `releases` skill).
  A routine bump is not a row; the release index records it.
- Public feedback that changes a choice: the row cites the post file and
  quotes the comment. The Who column stays the user's, with "prompted by
  @handle" (see the `posts` skill).

## Entry format

Append a row to the decisions table (append-only — new rows at the bottom, so
row numbers are stable and citable as "row 12"):

```markdown
| N | YYYY-MM-DD | <who — person and/or "with Claude"> | **<The decision, stated as the outcome.>** <Why: the specific reasons that would need to be revisited to reverse this. Alternatives rejected and the concrete reason each lost (with numbers where they exist — cost, latency, a failing case). Proof: how it was verified. Files affected.> |
```

The **why** is the load-bearing part. "Chose X" without the reasons is worse
than no entry — it forbids without explaining. Write the reasons so a future
reader can check whether they still hold; if they no longer hold, reversing
the decision is legitimate and gets its own new row naming this one.

## Open Questions section

A numbered list at the bottom of the file for decisions **intentionally
deferred**. Each states the question, why it is deferred, and the trigger for
revisiting ("when the runs table exceeds ~5,000 rows, migrate to Postgres").
When one is resolved, it becomes a decision row and is struck from the list
with a pointer to that row.

## Rules

- Append-only. A superseded decision is never edited or deleted — the new row
  names the old one ("supersedes row 7").
- Record at decision time, in the same session — not reconstructed later. If a
  row must be reconstructed from commits, mark it `[backfilled]`.
- Cross-reference the progress-log entry that implemented the decision and any
  tickets it closed or spawned (see the `progress-log` and `tickets` skills).

## Decisions made by the client

When the decision came from a client reply or a call, the row is theirs:

- Who column: the client person, then the user (`<Name> (client) + <user>`), so a
  reader knows whose word it is and whom to ask before changing it.
- Cite the source by path: the reply transcription and the original beside it
  (`docs/emails/YYYY-MM-DD_from_<who>_<slug>{.pdf,.md}`), or the sent
  summary email first and the transcript second for a call (the call row is
  written only once that email has gone out and its file holds the as-sent
  text). Add the time and cc when the same day has several exchanges.
- One row per reply or per call, with numbered points that mirror the
  question numbers of the email they answer. A row that settles eight
  things is easier to cite than eight rows that share a source.
- Quote the client's phrase where the wording is load-bearing; a paraphrase
  is what gets argued about later.
- Product asks made in passing go in the same row, marked "recorded here and
  NOT built by this row", with a pointer to the ticket or the options step
  that will handle them. Recording is not committing to build.
- What the client did not answer is not a decision: it goes to the Open
  Questions section or the workplan's blocked-on-client tracker, and into the
  next email (see the `emails` and `calls` skills).

## When invoked directly (`/devlog:decision-log <the decision>`)

Record the described decision as a new row now. If the why, the rejected
alternatives, or the proof are not evident from the conversation, ask for them
— a row without its reasons is worse than no row. If no decision was named,
scan the session for consequential choices made but not yet recorded, and
propose rows for them.
