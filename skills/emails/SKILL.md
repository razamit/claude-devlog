---
name: emails
description: 'Use when drafting or sending an email to a client or stakeholder, when a reply arrives, when the user reports an email sent, or when a decision was made "by email". Puts client email on the record: outgoing emails drafted in the sender''s own voice into docs/emails/ (date-first, to_/from_ direction marker, one file per email, updated to the text as actually sent), every reply filed beside its original (PDF for inline colour/strikethrough answers, read visually, transcribed verbatim with question numbering), then what the client decided folded into decision rows attributed to the client, answer-data files, tickets and the next email''s carried-forward questions.'
disable-model-invocation: false
---

# Emails — client correspondence on the record

Every email to or from the client carries decisions, and the devlog only
works if each decision can be traced back to the words that made it.
`docs/emails/` (or the path the project's CLAUDE.md names) holds every
outgoing email as it was actually sent and every reply as it was received.
Decision rows, tickets and progress entries point at those files; nothing the
client decided may live only in a mailbox or in chat.

## Where and naming

- Outgoing: `docs/emails/YYYY-MM-DD_to_<who>_<slug>.md`. Replies:
  `docs/emails/YYYY-MM-DD_from_<who>_<slug>.md`. The date comes first so the
  folder reads in order; it is the send date, or the draft date for an email
  that has not gone out. The direction marker comes next so a listing reads
  as a thread (`2026-08-26_to_dana_enrichment_open_items.md`, then
  `2026-08-27_from_dana_enrichment_open_items.md`). The slug says what the
  email is about; words in the client's script are fine in the name.
- When the project corresponds in more than one language, a language-code
  suffix before the extension names the body's language (`_en`, `_fr`);
  single-language projects omit it.
- Outgoing: one `.md` per email; the body is pasted from it into the mail
  client.
- Replies: the `from_` file holds the transcription; the original as
  received sits beside it with the same stem (`.pdf` printed from the mail
  client, or `.eml`) whenever the reply carries anything text extraction
  loses: colours, strikethroughs, answers typed inside the quoted email.
- `docs/emails/data/`: answer-data files extracted from replies (see
  "Folding a reply", step 2).

## The outgoing email file

Header above a `---` rule, then the body. Template:
`templates/outgoing-email.md` in this skill's directory.

The header states, in two or three lines: draft or sent (with date and time,
and cc), what it replies to (a filename in this folder), what it is based on
(transcript path, decision rows, workplan, report) and, if useful, one line on
how the email is organised. The body is exactly the text that gets pasted
into the mail client.

Writing the body:

- It goes out as the user's own words. Plain paragraphs; a numbered list only
  when there is a real list; short. No markdown decoration in the body (no
  bold markers, no headings, no tables, no code fences) and no em dashes:
  they mark the text as machine-written, and the client will notice. This
  holds even though the file is `.md`.
- Number every question and say in the opening line that the client can
  answer briefly beside each number. Numbered questions are what makes the
  reply transcribable and the decision rows citable ("question 5").
- A shape that works: what I understood and what happens now; what is still
  unclear to me (numbered, each question self-contained with the figures and
  a proposed default); what stays on your side; what is parked for later, in
  one sentence so it is on the record without reopening it.
- State explicitly any assumption made without the client's word ("one thing
  I assumed without you writing it: ...") and ask for a correction. Silent
  assumptions become disputes.
- Carry forward anything the client did not answer last time ("the offer
  from the previous email still stands"). An unanswered question that is not
  repeated is dropped without anyone deciding to drop it.
- Never resolve by guessing a question that writes production history or
  money figures; it goes in the email, and the work waits or proceeds under a
  stated assumption that the email names.

## When it is sent (the `sent` step)

The user usually edits the draft before sending. After it goes out, update
the file to the text as actually sent: replace the body, change the title
from draft to sent, add the send date and time and the cc. Ask for the sent
text if it was not pasted back. The as-sent text is the binding record (the
decision row cites it as "confirmed in the email of ..."), so a file that
still holds the draft misattributes words to the client. Nothing cites an
email as binding before this step has run; for a call summary email it is
what unblocks the decision row (see the `calls` skill).

## Filing a reply

1. Save the original as received. If the client answered inline with colours
   or strikethroughs, print the thread to PDF from the mail client and read
   the PDF visually, page by page: the Read tool renders PDF pages as images
   (up to 20 pages per request), so go through every page. Do not rely on
   extracted text: it drops colours and strikethroughs, and a struck line
   means the opposite of a kept one. This has produced wrong readings before;
   the visual pass is the rule.
2. Write the transcription (`templates/reply-transcription.md`). Header: from,
   to, cc, date and time, which email it answers, how they answered ("inline
   in my email, in blue, with strikethroughs"), where the original is, and the
   transcription conventions in one line. Body: sections numbered to match
   the question numbers of the outgoing email; the client's words verbatim
   inside quotes; `~~struck~~` for strikethroughs; everything outside the
   quotes is a transcription note. Every question gets an entry, including
   "no answer" and "not answered directly", so silence is recorded rather
   than lost.
3. Check the answers against the data before acting on them (the workbook,
   the database, the report they refer to). A reply often reveals that two
   people were talking about different rows.

## Folding a reply into the record

Same session, before anything is built on the reply:

1. Decision rows (see the `decision-log` skill): one row per reply, attributed
   to the client in the Who column ("<Name> (client) + <user>"), citing the
   transcription and the original by path with the time and cc, with numbered
   points mirroring the question numbers. Quote the client's phrase where the
   wording is load-bearing. Product asks made in passing go in the same row,
   marked as recorded here and NOT built by this row.
2. Answers that are data (mappings, chosen values, corrections) go into
   committed data files that the code reads, in `docs/emails/data/` (or the
   data directory the project's CLAUDE.md names), one pair per reply
   (`YYYY-MM-DD_from_<who>_<kind>.csv` plus a `README.md` naming the source
   email and question number), never hard-coded into a script and never
   applied by hand without a trace.
3. Tickets (see the `tickets` skill): a reply that surfaces a gap gets a
   ticket citing the file and the question number; a later reply that changes
   an open ticket gets a dated update blockquote at the top of that ticket.
4. Open items carried forward: whatever the client did not answer goes into
   the next email, the workplan's blocked-on-client tracker if there is one,
   and the progress entry's "open with the client" line.
5. Progress entry (see the `progress-log` skill): scope note "docs only";
   names each email file and whether it is a draft or was sent; proof is
   what the answers were checked against.

## Privacy

Replies and call transcripts carry real names and whatever people wrote or
said. Confirm the repository is private before committing them; in a public
or shared repository they stay out (a gitignored input directory, the
scratchpad) and the files that cite them say where they live instead. Files
carrying protected identifiers (ID numbers, credentials, account numbers) or
screenshots of real personal records stay out of the repo regardless, and
the progress entry says what was kept out and why. `session-wrap` checks
this before every commit.

## When invoked directly (`/devlog:emails <draft|sent|file|fold> [details]`)

- `draft <what>`: write the outgoing email per the rules above into a new
  dated file, and show the body for the user to edit.
- `sent [path]`: take the text as actually sent (ask for it if it was not
  pasted), replace the body of the named draft (or the most recent one),
  flip the title from draft to sent, add the date, time and cc. Then, if the
  email is a call summary, write the call's decision row (`calls` skill).
- `file <path or description>`: take the reply the user points at, save the
  original, produce the transcription.
- `fold`: run the five folding steps for the most recently filed reply.

With no argument, find the email at hand in the conversation and propose
which of the four applies.
