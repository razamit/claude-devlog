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

## When invoked directly (`/devlog:decision-log <the decision>`)

Record the described decision as a new row now. If the why, the rejected
alternatives, or the proof are not evident from the conversation, ask for them
— a row without its reasons is worse than no row. If no decision was named,
scan the session for consequential choices made but not yet recorded, and
propose rows for them.
