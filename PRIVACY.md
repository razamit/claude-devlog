# Privacy

Devlog is a set of plain markdown skills for Claude Code. It has no server,
no account, no telemetry and no network calls of its own. The publisher never
receives any of your data.

## What it reads and writes

Everything devlog writes goes into files in your own project, inside the
repository you are working in:

- `docs/PROGRESS.md`, `docs/DECISIONS.md`, `docs/tickets/`,
  `docs/RELEASES.md` and `CHANGELOG.md` hold your project's work record.
- `docs/emails/` and `docs/calls/` hold client emails and call transcripts,
  but only when you ask Claude to file them. These can include personal
  data: names, email addresses, and whatever was said on a call.
- `docs/posts/` holds drafts and the text of posts you publish yourself.

To do this, the skills read your project files, your git history, and any
email, transcript or reply you hand to Claude.

## Where the data goes

The files stay on your machine and in your repository. They leave only when
you commit and push them, and they go wherever you push. Devlog never pushes
for you. It commits only when you ask, and it never pushes tags.

Claude Code itself sends your conversation, and the files Claude reads, to
the model provider under that provider's own terms. That happens with or
without devlog. Devlog adds no other destination.

## Your choices

- Keep `docs/emails/` and `docs/calls/` out of public repositories. The
  `emails` and `calls` skills commit transcripts and reply files only to a
  private repository, and only when they hold no ID numbers, credentials or
  account numbers.
- The `posts` skill runs a privacy gate before and after a post goes out,
  and never uses email or call material.
- To remove the data, delete the files and remove them from your git
  history. Devlog keeps no other copy.

## Contact

Questions about this policy: open an issue at
https://github.com/razamit/claude-devlog/issues.
