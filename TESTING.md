# Testing

Devlog is a markdown-only plugin, so its highest-value tests combine strict
manifest validation with behavioral checks in a disposable Git repository.

## Release gate

Run these checks before tagging a release:

```sh
claude plugin validate .claude-plugin/plugin.json --strict
claude plugin validate .claude-plugin/marketplace.json --strict
git diff --check
claude plugin tag --dry-run .
```

Before `claude plugin tag`, run `/devlog:releases status` in a session on
this repository: it must report no drift between `plugin.json`, the top
`CHANGELOG.md` heading and the latest tag.

Validate `plugin.json` directly: validating the repository root selects the
marketplace manifest and may not report invalid skill frontmatter.

## Behavioral test matrix

1. **Fresh initialization** — run `/devlog:init` in an empty Git repository;
   verify it creates the two logs, ticket directory and template, and one
   marked `## Devlog` block with today's date.
2. **Idempotent initialization** — run `/devlog:init` again; verify no file is
   duplicated, no historical content changes, and only one Devlog block exists.
3. **Existing conventions** — start with non-default progress, decision, and
   issue paths; verify init reuses them and writes their real paths everywhere.
4. **Partial existing setup** — provide only one or two artifacts; verify init
   preserves them and creates only what is missing.
5. **Progress entry** — complete a small change and invoke `progress-log`;
   verify the entry is prepended and includes status, scope, actual proof,
   every touched path, and relevant cross-references.
6. **Decision entry** — record a choice with alternatives; verify a new stable
   row is appended with reasons, rejected alternatives, proof, and affected
   files rather than rewriting earlier rows.
7. **Ticket lifecycle** — discover, file, and close a defect; verify concrete
   evidence is captured and closure updates status without deleting the file.
8. **Clean session wrap** — request a commit after a verified change; confirm
   every changed path appears in the evidence summary and all log updates land
   in the same commit.
9. **Unrelated working-tree changes** — leave a pre-existing modification;
   verify session-wrap identifies it and excludes it through selective staging.
10. **No commit authorization** — invoke session-wrap without asking for a
    commit; verify it updates or presents the close-out but leaves the working
    tree uncommitted.
11. **Red or skipped tests** — wrap a partial change; verify the progress entry
    states the failure or skipped verification honestly and tracks follow-up.
12. **Automatic discovery** — in a normal Claude Code session, create moments
    matching each skill description and assess whether the relevant skill is
    selected without explicit invocation.
13. **Outgoing email** — invoke `/devlog:emails draft` for a client question;
    verify a date-first `docs/emails/…_to_<who>_…` file with a header above a
    `---` rule, a body free of markdown decoration and em dashes, numbered
    questions, and any assumption stated explicitly. Then run
    `/devlog:emails sent` with an edited text; verify the file now holds the
    as-sent text and its title says sent, with date and cc.
14. **Reply with strikethroughs** — file a PDF reply in which one line is
    struck through; verify the transcription marks it `~~struck~~`, keeps the
    client's words in quotes, numbers sections to match the outgoing email,
    and records the unanswered question as "No answer"; verify the decision
    row is attributed to the client and cites both files.
15. **Call transcript** — hand `/devlog:calls` a transcript longer than 2000
    lines whose only decision sits in the last quarter; verify the summary
    captures it, the progress entry quotes the line count and the last line,
    the summary email drafts under the `emails` rules, and the decision row is
    marked pending until `/devlog:emails sent` is run, after which it is
    written.
16. **Date-first rename** — rename a dateless email file; verify session-wrap
    uses `git mv`, rewrites every reference, and shows the zero-hit grep in
    the evidence summary.
17. **Carrier detection**: on a Flutter fixture with `pubspec.yaml`, a Gradle
    `versionName` set to `flutterVersionName` and an `Info.plist` holding
    `$(FLUTTER_BUILD_NAME)`, run `/devlog:releases status`; verify the
    registry names pubspec canonical, lists both derived fields as do not
    edit, and that a second run reads the registry instead of re-detecting.
18. **Drift**: hand-edit `versionName` to a literal and add a tag with no
    changelog section; verify `status` quotes both values, the session-wrap
    line reports drift and points at `status`, and a ticket is filed when
    it is not fixed.
19. **Bump proposal**: in a 0.x project with one Added and one Fixed entry
    since the last release, verify `propose` says minor with one line per
    criterion and a build number one above the last used; override to patch
    and verify a decision row records the override.
20. **Cut without tag**: run `cut`; verify one commit (when asked) containing
    every carrier, the grep output shown with equal values, the section
    renamed with a date, a fresh empty Unreleased above it, every stamp
    flipped, a release entry at the head of the progress log, an index row,
    and no tag. Then run `tag`; verify an annotated tag and nothing pushed.
21. **Tag-canonical project**: with the version computed in CI from tags,
    verify `cut` edits no carrier file and `tag` is the release act.
22. **No version anywhere**: verify init or `status` offers 0.1.0 in the
    native field or a `VERSION` file and writes a decision row.
23. **Post ideas**: with a ✅ DONE entry carrying a number, a decision row
    with a rejected alternative, an invisible refactor and a client-attributed
    row, run `/devlog:posts ideas`; verify the first two become rows and the
    last two do not, with the reason stated.
24. **Draft and posted**: run `draft <row> for x, li`; verify two files
    sharing a slug, X parts each under 280 characters, the LinkedIn link in
    the first comment, no em dashes, no hype words, `Variants:` lines on
    both. Run `posted` with edited text; verify the body is replaced, the
    title flipped, the IDEAS row updated and a progress entry written.
25. **Privacy gate**: draft from a client-attributed decision row; verify the
    draft is refused until VOICE.md lists the client as public. Add a
    screenshot containing a token; verify the gate names it and the title
    stays at Draft.
26. **Fold**: paste three public replies (a feature request, a question, a
    thank-you); verify a ticket citing the post file and quoting the
    comment, an FAQ entry, and a no-action line with a reason; a second
    occurrence of the question across posts promotes it to `FAQ.md`.
27. **Wrap mention**: wrap a session with a post-worthy entry in a project
    with the Building in public bullet and in one without; verify the row
    and the close-out line appear only with the bullet.

Automatic discovery is probabilistic. Run those scenarios several times and
track the success rate rather than treating one run as proof.
