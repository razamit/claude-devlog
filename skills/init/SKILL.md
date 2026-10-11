---
name: init
description: Scaffold the devlog system (docs/PROGRESS.md, docs/DECISIONS.md, docs/tickets/, docs/RELEASES.md) into the current project and wire pointers into CLAUDE.md.
disable-model-invocation: true
---

# /devlog:init — adopt the devlog system in this project

Set up the three artifacts and the CLAUDE.md wiring. Adapt to what already
exists — never overwrite an existing file.

## Steps

1. **Detect existing practice.** Look for existing progress/decision/ticket
   files under the repo (common names: `PROGRESS.md`, `Implementation_progress.md`,
   `DECISIONS.md`, `CHANGELOG`-style decision tables inside a spec,
   `docs/tickets/`, `docs/issues/`). If found, do NOT create parallel files —
   record the existing paths in step 3 and only scaffold what is missing.
   Also look for `CHANGELOG.md` and for version carriers (`package.json`,
   `pubspec.yaml`, `build.gradle`, `Info.plist`, `project.pbxproj`,
   `Cargo.toml`, `pyproject.toml`, `.claude-plugin/plugin.json`, a `VERSION`
   file, git tags), and list what was found.

2. **Scaffold what is missing** from the templates in this skill's
   `templates/` directory:
   - `docs/PROGRESS.md` ← `templates/PROGRESS.md`
   - `docs/DECISIONS.md` ← `templates/DECISIONS.md`
   - `docs/tickets/` with `templates/ticket-example.md` copied in as
     `_template.md`
   - `docs/RELEASES.md` ← the `releases` skill's `templates/RELEASES.md`,
     with the carrier registry filled from what step 1 found (canonical,
     mirrors, derived fields marked do not edit, build number, tag style).
     Create it when the project has a version anywhere; otherwise ask
     whether to start at 0.1.0 (a decision row) or leave releases out.
   - `CHANGELOG.md` ← the `releases` skill's `templates/CHANGELOG.md`, only
     when the file is absent and the project has a version. An existing
     changelog is never restyled.

   Fill today's date into the seed rows. If the project keeps docs elsewhere
   (no `docs/`, or a different convention), follow the project's convention
   and use those paths throughout.

   Correspondence folders (`docs/emails/`, `docs/calls/`, `docs/plans/`)
   are created on first use by the `emails` and `calls`
   skills. Scaffold them at init only when the user says the project has a
   client or stakeholder they correspond with, or when such folders already
   exist under another name (record that name in step 3).

   `docs/posts/`, `docs/posts/assets/` and `docs/posts/IDEAS.md` (from the
   `posts` skill's `templates/IDEAS.md`) are scaffolded only when the user
   says they post about this project in public. `VOICE.md` is seeded by the
   `posts` skill at the first draft. Otherwise no folder and no bullet in
   step 3, so client projects are never nudged to post.

3. **Wire CLAUDE.md idempotently.** This is the step that makes the process
   self-sustaining: `CLAUDE.md` is always in context, so instructions placed
   there are available in every future session. Before writing, look for either
   the `devlog:start` / `devlog:end` markers below or an existing `## Devlog`
   section. If the marked block already uses the correct paths, leave it
   unchanged. If its paths or wording are stale, replace only that owned block.
   If an unmarked `## Devlog` section exists, update it in place and add the
   markers. Never append a second Devlog section. Create `CLAUDE.md` if absent;
   otherwise append the block only when no Devlog section exists.

   ```markdown
   <!-- devlog:start -->
   ## Devlog

   This project keeps a written record. Maintain it without being asked.

   - **Starting work** — read the head of `docs/PROGRESS.md` (newest entry
     first) to learn current state, and check `docs/DECISIONS.md` before
     proposing anything it may have already settled. Existing decision rows are
     binding: supersede one deliberately with a new row, never silently.
   - **Noticing a defect or gap you will not fix now** — file a ticket in
     `docs/tickets/` (Symptom → Evidence → Why it matters → Scope to decide).
     Never leave it as a TODO comment, a silent skip, or a remark in chat.
   - **Making a consequential choice** — record it in `docs/DECISIONS.md` with
     its why and the alternatives rejected. A decision whose reasons are not
     written down will be reversed by a future session that cannot see them.
   - **Finishing a unit of work** — prepend an entry to `docs/PROGRESS.md`:
     status marker, scope note, real proof (actual test output, before/after),
     files touched, cross-refs. State red tests honestly; never imply
     completeness you have not verified.
   - **Before any requested commit** — evidence summary naming every path in
     `git status --short` / `git diff --stat`, including incidental edits and
     deletions, verified against the actual diff; then the log updates above,
     in the same commit as the work; then commit. Never commit unless the user
     explicitly asked.
   - **Client emails and calls** — every email to or from the client is
     filed in `docs/emails/` (date-first, `to_`/`from_`, the text as sent;
     replies transcribed beside the original), every call agenda, transcript
     and summary in `docs/calls/`, and what the client decided there goes into
     `docs/DECISIONS.md` attributed to the client, citing the file. Nothing
     the client decided lives only in a mailbox.
   - **Versions and releases**: the files carrying the version are listed
     once in `docs/RELEASES.md` and never re-detected. A progress entry for
     work that reaches users ends `[unreleased]` and gets one bullet under
     `## [Unreleased]` in `CHANGELOG.md`. Bump, cut and tag only through
     `/devlog:releases`: carriers move together, tags on request, nothing
     pushed.
   - **Building in public**: posts about this project live in `docs/posts/`,
     date-first with a platform marker, holding the text as posted. At every
     wrap, work that passes a post-worthy test becomes a row in
     `docs/posts/IDEAS.md`. Drafts follow `docs/posts/VOICE.md` and pass the
     privacy gate before and after posting. Nothing from `docs/emails/` or
     `docs/calls/` is post material.

   The `devlog` plugin skills (`progress-log`, `decision-log`, `tickets`,
   `session-wrap`, `emails`, `calls`, `releases`, `posts`) hold the full
   conventions. Read the relevant one before writing to these files.
   <!-- devlog:end -->
   ```

   Use the actual paths from steps 1–2, not the defaults, if they differ.
   Include the Building in public bullet only when `docs/posts/` was
   scaffolded in step 2.

4. **Report** what was created, what was detected and left alone, and remind
   the user of the entry points: `/devlog:session-wrap`, `/devlog:tickets`,
   `/devlog:progress-log`, `/devlog:decision-log`, `/devlog:emails`,
   `/devlog:calls`, `/devlog:releases`, `/devlog:posts`.
