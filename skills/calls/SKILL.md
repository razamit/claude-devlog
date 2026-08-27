---
name: calls
description: 'Use when a call or meeting transcript arrives, when preparing for one, or when "we agreed on the call" is cited. Puts client calls and meetings on the record: agenda before, transcript archived untouched in docs/calls/ (date-first), a summary written only after reading the WHOLE transcript (line count and last line verified), a summary email sent the same day as the binding confirmation, a decision row attributed to the client once that email is sent, a workplan in docs/plans/ with routes per feature and a blocked-on-client tracker, tickets, progress entry.'
disable-model-invocation: false
---

# Calls — transcripts, summaries, and what follows

A call with the client produces decisions faster than any email and loses
them faster too: the transcript is long, the agreed items are spread through
it, and by the next session nobody remembers which half of a sentence was
the decision. The record for a call is a chain: agenda before, transcript as
received, a summary written from the whole transcript, a summary email sent
the same day, a decision row once that email is sent, a workplan if work
came out of it, tickets, and a progress entry. Each link cites the previous
one.

## Where and naming

Everything about one call lives in `docs/calls/`, date-first, so the agenda,
the transcript and the summary of the same day sit together in a listing:

- `docs/calls/YYYY-MM-DD_<slug>_agenda.md`: the agenda prepared before.
- `docs/calls/YYYY-MM-DD_<transcript name>.txt`: the transcript as exported
  by the transcription tool. Keep the tool's title in the name if it helps
  recognition (the client's language is fine); the date goes first; a
  `_speakers` suffix marks a diarised transcript.
- `docs/calls/YYYY-MM-DD_<slug>_summary.md`: the summary.
- `docs/emails/YYYY-MM-DD_to_<who>_call_summary.md`: the summary email (see
  the `emails` skill for the naming and the rules).
- `docs/plans/YYYY-MM-DD_<slug>_workplan.md`: implementation scoping.

When the project corresponds in more than one language, a language-code
suffix before the extension names the body's language (`_summary_en.md`,
`_agenda_fr.md`); single-language projects omit it. Paths follow the
project's CLAUDE.md if it names others.

## Before: the agenda

Purpose in one sentence; timed sections; what to show, naming the exact
records and numbers to open so the demo does not improvise; the open
questions the call must close; and a prep checklist (stack up, demo users,
data loaded, health checks). Written in the client's language when it will
be shared with them.

## The transcript

Archive it as received and never edit it. Read all of it before writing
anything, and make that verifiable: run `wc -l` first, read in chunks until
the last line has actually been reached, and quote in the progress entry
both the line count and the last line read. A 45-minute call is roughly 900
lines and the decisions cluster in the second half, after the tour and the
small talk; a summary written from the first half has happened and was
wrong, which is why the proof is the last line reached, not "read it".

Transcripts are noisy (mis-heard names, numbers, "UNKNOWN" spans). Where a
figure or name matters, check it against the data before it goes into the
summary, and mark what could not be verified.

Transcripts carry real names and whatever was said aloud, including other
people's details and figures read out. The Privacy section of the `emails`
skill applies to them unchanged, and `session-wrap` checks it before the
commit.

## The summary

Template: `templates/call-summary.md`. Header: date, participants with their
organisations, topic, and a source pointer to the transcript and the agenda
in the same folder; later, pointers to the decision row, the workplan and
the summary email. Sections: what was shown or discussed; decisions,
numbered, one sentence each stated as the outcome, with the reason the
client gave and the alternative rejected when one was; action items per
person (the user, then each client person); open for later; next step.

The summary is the deliverable promised on the call. Write it in the
client's language when it will be sent to them.

## The summary email, the same day

Draft it per the `emails` skill: what we agreed (numbered), what I noted for
later and not now, what I need from you (numbered), next step. Include any
question that must be answered before building, phrased so a one-word reply
closes it ("only one question so I get it right: does this also apply to
cases opened from now on?"). Once sent, the email is the binding record: the
decision row cites it first ("confirmed in the email sent the same day") and
the transcript second, as evidence.

## After the email is sent: the decision row

The row waits for the sent email, because it cites the email first. Until
then the proposed row lives in the summary's Decisions section and the
progress entry says the row is pending the send. When the user reports the
summary email sent, in this session or a later one, run `sent` per the
`emails` skill to store the as-sent text, then write the row: one row per
call (see the `decision-log` skill), attributed to the client in the Who
column, with numbered points; it cites the summary email and the transcript
by path. Items deferred on the call are listed in the same row "so they are
not lost", with who owns them. Name what each point supersedes ("(6)
supersedes the 'numbers never change' reading of row 50 for MANUAL edits
only"). The routes chosen to implement the call's items get their own row
when built, not in the call row.

## The workplan, when the call produced work

Template: `templates/workplan.md`. A status header at the top, updated as
things move (what was chosen, built, deployed, and what still waits and on
whom); a pointer to the client-facing record (the sent email, the
transcript, the decision row); one section per feature with a size (S under
half a session, M one to two sessions, L several), whether it is blocked on
client input (and whether it can be built under a stated assumption), two to
four routes each stating how it works, what it can never do and the effort,
with one recommended and the reason (if the project has its own
options-before-implementation rule, follow that), and a suggested order with
the reason. At the bottom, the blocked-on-client tracker: a table of who
owes what and what it unblocks, rows struck through with the date and
decision row when delivered. The tracker is where "waiting for the client"
lives; a progress entry that says "waiting" points here.

## Tickets and the progress entry

Data findings from the checks the call prompted (counts that disagree, rows
the system does not know) become tickets per the `tickets` skill, not
remarks in the summary. The progress entry (see the `progress-log` skill)
is "docs only, no code, no spend" unless code changed; its proof is the
transcript fully read (line count and last line reached) and the
cross-checks run; it names the transcript, the summary, the email (draft or
sent), the decision row (written or pending the send), the workplan and the
tickets.

## When invoked directly (`/devlog:calls <path to transcript>`)

Archive the transcript under the date-first name if it is not already there,
read it whole (`wc -l`, then chunks to the last line), write the summary,
draft the summary email, put the proposed decision row in the summary, write
the workplan if features came out of it, file tickets for data findings, and
write the progress entry. With no path, look for the newest file in
`docs/calls/` without a summary, or ask for the transcript. To prepare an
agenda instead: `/devlog:calls agenda <date and purpose>`. When the user
reports the summary email sent: `/devlog:emails sent`, then write the
decision row.
