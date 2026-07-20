---
name: init
description: Scaffold the devlog system (docs/PROGRESS.md, docs/DECISIONS.md, docs/tickets/) into the current project and wire pointers into CLAUDE.md.
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

2. **Scaffold what is missing** from the templates in this skill's
   `templates/` directory:
   - `docs/PROGRESS.md` ← `templates/PROGRESS.md`
   - `docs/DECISIONS.md` ← `templates/DECISIONS.md`
   - `docs/tickets/` with `templates/ticket-example.md` copied in as
     `_template.md`

   Fill today's date into the seed rows. If the project keeps docs elsewhere
   (no `docs/`, or a different convention), follow the project's convention
   and use those paths throughout.

3. **Wire CLAUDE.md.** Append a short block to the project's `CLAUDE.md`
   (create it if absent) naming the three paths and the discipline:

   ```markdown
   ## Devlog

   - `docs/PROGRESS.md` — newest-first progress log; read the head for current
     state, prepend an entry per completed unit of work (see devlog:progress-log).
   - `docs/DECISIONS.md` — append-only decision log + open questions
     (see devlog:decision-log).
   - `docs/tickets/` — one file per open issue; file instead of TODO comments,
     close by status flip, never delete (see devlog:tickets).
   - Before any commit: run the session-wrap discipline (see devlog:session-wrap)
     — evidence summary of every touched file, verified against the diff, then
     log updates, then commit.
   ```

   Use the actual paths from steps 1–2, not the defaults, if they differ.

4. **Report** what was created, what was detected and left alone, and remind
   the user of the entry points: `/devlog:session-wrap`, `/devlog:tickets`,
   `/devlog:progress-log`, `/devlog:decision-log`.
