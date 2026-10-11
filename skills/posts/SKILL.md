---
name: posts
description: 'Use when the user posts or wants to post about the project in public (X, LinkedIn, Reddit, Indie Hackers or a forum, a blog or newsletter, Facebook), when replies to a post arrive, or at session-wrap to ask whether a unit of work is worth a post. Puts building in public on the record: a post-ideas backlog mined from the progress log, decisions, tickets and changelog (never from client correspondence), one file per post per platform in docs/posts/ (date-first, platform marker, the text as posted), drafts in the user''s own voice from VOICE.md with every number cited to the record, a privacy gate before and after posting, and public replies folded into tickets, decision rows and an FAQ.'
disable-model-invocation: false
---

# Posts: building in public on the record

A post is a public claim about the project. The devlog is where the claim
can be checked. Every post cites its source in the record (an entry, a row,
a ticket, a changelog section), so the numbers in public are the record's
numbers, and `docs/posts/` (or the path the project's CLAUDE.md names) holds
what was said, where, and what came back.

## When to use

- Session-wrap, on projects that build in public (the Devlog block in
  CLAUDE.md has a "Building in public" bullet): the post-worthy check.
- The user wants to post, or asks what is worth posting.
- The user reports a post is live.
- Replies to a post arrive.
- A release is cut: its changelog section is the launch-post source (see
  the `releases` skill).

## Where and naming

- `docs/posts/YYYY-MM-DD_<platform>_<slug>.md`, one file per post per
  platform. Markers from `templates/platforms.md`: `x`, `li`, `reddit`,
  `ih`, `hn`, `forum`, `blog`, `news`, `fb`. The date is the post date, or
  the draft date until then.
- A thread is one file with parts numbered `1/`, `2/` in the body.
- Cross-posts share the slug so they sort together, and name each other on
  a `Variants:` line.
- `docs/posts/IDEAS.md`: the backlog. `docs/posts/VOICE.md`: how the user
  writes. `docs/posts/FAQ.md`: created only when a question recurs across
  two posts.
- `docs/posts/assets/YYYY-MM-DD_<slug>_<n>.png`, referenced from the body
  as `[image: assets/...]`.

## The post file

Template: `templates/post.md`. Title `# <Idea|Draft|Posted>: <platform>,
<about> (<date>)`. Header lines: platform and, once posted, date, time and
URL; Source (the entry, row, ticket, section or post file it is drawn
from); Variants and Assets; Privacy gate (passed or failed, with the date).
Then `---`, the body, `---`, and the after-the-fact sections: dated metric
updates, `## Replies folded YYYY-MM-DD`, `## FAQ`.

## The backlog: IDEAS.md

One row per idea: `| K | Added | Idea | Angle | Source | Platforms |
Status |`. Statuses: `open`, `drafted: <file>`, `posted: <files>`,
`dropped: <reason>`. Rows are never deleted.

Post-worthy, each test checked against the record, not against memory:

1. A user can see it (a feature, a fix they hit, a visible change).
2. A decision with a non-obvious why, and the alternative it beat.
3. A number changed (test count, latency, size, cost) with before and after.
4. A mistake with a lesson, written up in an entry or a ticket.

Not post-worthy: invisible refactors, docs-only work, dependency bumps,
🟡 PARTIAL work, and anything sourced from `docs/emails/`, `docs/calls/` or
a client-attributed decision row, unless VOICE.md lists that client as
public.

Source scan, in order: the head of the progress log since the last row's
Added date; decision rows since the last one cited; tickets closed since;
the top changelog section; `git log` for a first external contributor.
Milestones the record lacks (users, revenue) become rows only after the
user states the figure and it goes into a progress entry first.

## Drafting

Platform profile from `templates/platforms.md`: length, shape, where the
link goes, hashtags, tone. Those are defaults; read the community's current
rules before posting to Reddit, a forum or Hacker News. VOICE.md overrides
the table wherever they disagree.

The body:

- The user's own words, per VOICE.md. No em dashes. No hype words
  (revolutionary, game-changing, excited to announce, thrilled, journey,
  unlock, supercharge, seamless). Plain sentences of varied length.
- No emoji and no hashtags unless VOICE.md says so.
- Specific over general: the real number, the component name, the before
  and after. Say what it does not do and what went wrong.
- The first line stands alone; it is the post, not a tease for it.
- Never claim beyond the record. Every number traces to the Source line.
- The link goes where the profile says, and the body says what it is.
- Threads: one point per part, the image on the part it illustrates, the
  link in the last part.

Variants: one draft per platform in the row's Platforms cell, shown
together, each in its own file with the shared slug. Repurposing a Posted
file for another platform is the same step with that file as the Source.
A release draft takes the changelog section's bullets that pass a test as
its parts; bullets that fail are left out, not padded.

## Voice: VOICE.md

Seeded at the first draft, from three to five posts the user pastes or from
the five-question interview in `templates/VOICE.md`. It also records what
may be public: which clients, whether revenue, whether user counts. The
privacy gate reads that list. The user edits it; it is never silently
rewritten.

## Privacy gate

Runs at draft and again at posted. Six checks:

1. No client named or identifiable unless VOICE.md lists them as public.
2. Nothing drawn from `docs/emails/`, `docs/calls/` or a client-attributed
   decision row.
3. No credentials, tokens, IDs, addresses, hostnames or paths with
   usernames, in the text or in the assets. Every screenshot is opened and
   looked at, not assumed.
4. Nothing unannounced: an untagged release is a draft until it is tagged.
5. No personal data of users or testers.
6. Every number is the record's, with the source cited.

A failure leaves the title at Draft and names the item that failed on the
Privacy gate line.

## When it is posted (the `posted` step)

Replace the body with the text as posted (ask for it if it was not
pasted), flip the title to Posted, add date, time and URL, run the gate,
set the IDEAS row to `posted: <file>`. One short progress entry per
publishing session, scope `docs only, public`, naming the files and that
the gate passed. Metrics come later, below the second rule, dated, with
where they were read (`[Update 2026-10-14: 2,100 views, 40 likes, from the
X analytics page]`).

## Folding replies

Public comments only. DMs are private correspondence and go through the
`emails` skill. Six steps:

1. `## Replies folded YYYY-MM-DD` in the post file: each reply quoted
   verbatim with its handle.
2. Feature requests and bugs: a ticket each, citing the post file and
   quoting the comment (see the `tickets` skill).
3. Questions: an FAQ entry in the post file; on the second occurrence across
   posts, promoted to `docs/posts/FAQ.md`.
4. Feedback that changes a choice: a decision row citing the post file. The
   Who column stays the user's, with "prompted by @handle".
5. Praise and noise: one line, "no action", with a word of reason.
6. A progress entry naming what the fold produced.

## Rules

- The body is never edited after Posted. Corrections are a new post or a
  dated update below the rule.
- Ideas come from the record, never from memory or correspondence.
- One file per post per platform; variants share a slug.
- The gate runs twice, at draft and at posted.
- VOICE.md and the writing rules win over what a platform tolerates.
- Metrics are appended, dated and sourced, never written into the body.

## When invoked directly (`/devlog:posts <ideas|draft|posted|fold|voice> [details]`)

- `ideas [since <date>]`: scan the sources in order, add rows for what
  passes a test, say what was skipped and why.
- `draft <row K | PROGRESS <date> | row N | <ticket> | CHANGELOG <x.y.z> |
  <post file>> [for <platforms>]`: seed VOICE.md if absent, write one file
  per platform, run the gate, show the drafts together.
- `posted [path] <URL>`: the posted step for the named draft or the most
  recent one.
- `fold [path]`: the six folding steps for the named post or the most
  recently posted one.
- `voice`: create or revise VOICE.md with the user.

With no argument: if the conversation holds as-posted text or replies,
propose `posted` or `fold`; otherwise list open rows oldest first and
propose `draft` or `ideas`.
