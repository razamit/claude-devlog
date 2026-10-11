---
name: tickets
description: File a ticket when you discover a defect, gap, or decision that won't be fixed now. One markdown file per issue in docs/tickets/ with Symptom, Evidence, Why it matters, and Scope to decide. Tickets are the record of what was observed — keep them instead of drive-by fixes or TODO comments that disappear. File a new ticket, update an existing one, or close one.
disable-model-invocation: false
---

# Tickets — one file per issue, on the record

A ticket is a written observation, not a task in a tracker. It captures a defect,
gap, or decision-needed at the moment of discovery, with enough evidence that a
future session can pick it up cold.

## When to file

- You notice a defect or gap while working on something else and fixing it now
  would widen the current change's scope.
- A fix needs a decision the user has not made yet.
- A live run / test / audit surfaced something worth recording even if no code
  changes today.
- Version drift reported at session-wrap and not fixed in the session: the
  Symptom is the two disagreeing values, quoted (see the `releases` skill).

Never leave the observation as a TODO comment, a chat remark, or an unexplained
skip — file the ticket. Filing a ticket makes **no code change**; it is an
observation on the record.

## Where and naming

`docs/tickets/<kebab-slug>.md` — the slug is a terse statement of the defect
itself, not the component (`runs-total-cost-not-rolled-up.md`, not
`cost-bug.md`).

## Structure

```markdown
# <One-sentence defect statement — the symptom, not the intended solution>

Status: OPEN · Priority: LOW|MEDIUM|HIGH · Type: <short classification> · Cost: <external cost incurred filing this, or "none">

> Optional blockquote: relationships — what this blocks or is a prerequisite
> for, and how it differs from any near-duplicate ticket (name the file).

## Symptom
What is observed, where, and since when. Concrete: file:line, run IDs, exact
values ("column reads 0.0 while the ledger sums to £0.63").

## Evidence
The commands run and their output, quoted. Enough that a reader can re-verify
without trusting the prose.

## Why it matters
Impact and what depends on it. If it is NOT as bad as it looks, say that too
("this is not a ledger-accuracy bug — the money is fully recorded; only the
rollup is absent").

## Scope to decide (or ## Fix, when the fix is known)
Options as bullets, "OR"-separated when they are genuine alternatives. If the
choice is the user's, present options without prescribing.
```

## Cross-linking

- Name related tickets by filename and state the distinction explicitly.
- Reference the progress-log entry or decision that spawned the ticket.
- When another document defers work to this ticket, it must name the file.
- When a client reply or call surfaced the ticket, the relationships
  blockquote names the file and the question number
  (`docs/emails/2026-08-26_from_dana_enrichment_questions.md`, question
  2) so the client's own words are one hop away.
- When a later reply changes an open ticket, add a dated update blockquote
  at the top (`> Update YYYY-MM-DD, <who>'s second reply (decision row N):
  ...`) naming which option below is now dead; do not rewrite the Symptom or
  the Evidence, they are the record of what was observed.
- When a public comment on a post surfaced the ticket, the relationships
  blockquote names the post file and the commenter's handle and quotes the
  request (see the `posts` skill).

## Closing

- Tickets are closed by the session that fixes them: flip the `Status:` line to
  `CLOSED (YYYY-MM-DD)` with a pointer to the closing commit or progress-log
  entry, and name the ticket file in that progress entry.
- Never delete a ticket file. Closed tickets are the record of what was wrong.
- If a ticket is rejected (won't fix), close it as `CLOSED — WON'T FIX` with the
  reasoning; that is a decision, so consider a decision-log row too (see the
  `decision-log` skill).

## When invoked directly (`/devlog:tickets <description of the issue>`)

File a ticket now for the described issue: first gather the Evidence (run the
commands, quote the output, find the file:line), then write the ticket per the
structure above and report its path. If no description was given, ask what to
file — or, if something was just observed in the conversation, propose filing
that.
