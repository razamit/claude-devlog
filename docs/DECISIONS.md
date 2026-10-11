# Decisions

Append-only. These are not preferences — they are decisions made for specific
reasons, and changing them requires going back to those reasons. New rows at
the bottom; a superseded decision gets a new row naming the old one, never an
edit.

| # | Date | Who | Decision — why, alternatives rejected, proof, files |
|---|------|-----|------------------------------------------------------|
| 1 | 2026-10-11 | Amit + Claude | **Adopted the devlog system in the plugin's own repository.** Why: the plugin's own releases (0.1.2, 0.2.0, 0.3.0) were recorded only in `CHANGELOG.md` and commit messages; the route and naming decisions behind 0.3.0 lived only in a planning transcript. Files: `docs/PROGRESS.md`, `docs/DECISIONS.md`, `docs/tickets/`, `docs/RELEASES.md`, `CLAUDE.md`. |
| 2 | 2026-10-11 | Amit + Claude | **Version policy for this repository: `.claude-plugin/plugin.json` is the canonical and only carrier; `marketplace.json` has no version field and is not a carrier; the changelog keeps its existing `## X.Y.Z — YYYY-MM-DD` heading style, with the feed under `## Unreleased` in the same style; tags are `devlog--vX.Y.Z`, made and pushed by `claude plugin tag` per TESTING.md, so `/devlog:releases tag` only reports here; pre-1.0 bump rule: a new skill or entry point proposes minor, fixes propose patch, 1.0.0 is never proposed.** Why: `claude plugin tag` reads plugin.json and chooses the tag name itself, so a hand-made `vX.Y.Z` tag would diverge from the published one; restyling the changelog would break the 0.1.2 and 0.2.0 sections' neighbours. Alternative rejected: Keep a Changelog headings for this repo, which the releases skill uses for new projects, because an existing style is never restyled (releases skill rule). Proof: `/devlog:releases status` on a clone of this repo at 0.3.0 produced this registry. Files: `docs/RELEASES.md`, `skills/releases/SKILL.md` (edge case bullet). |
| 3 | 2026-10-11 | Amit + Claude | **0.3.0 is built as plain markdown skills plus CLAUDE.md bullets, with model-driven carrier detection.** Why: the README promises no hooks, no scripts, no dependencies, and installation by copying `skills/*`. Alternatives rejected: a shell script for deterministic carrier detection, which would break the copy-the-folder install and the README promise, deferred until model-driven detection proves unreliable (open question 3); hooks, removed deliberately in commit f00dbf2, not revisited. Proof: carrier detection on a Flutter fixture with derived Gradle and plist fields produced the correct registry on the first run and read it back on the second (TESTING scenario 17). Files: `skills/releases/`, `skills/posts/`. |
| 4 | 2026-10-11 | Amit + Claude | **The two new skills are named `releases` and `posts`.** Why: plural nouns matching the record each keeps (`docs/RELEASES.md`, `docs/posts/`), like `emails`, `calls`, `tickets`. Rejected for the second: `build-in-public` (long, and the phrase is the CLAUDE.md bullet title), `public` (collides with the privacy vocabulary), `social` (excludes blog and newsletter), `publish` and `announce` (verbs, and `publish` reads as a release act). Files: `skills/releases/SKILL.md`, `skills/posts/SKILL.md`. |
| 5 | 2026-10-11 | Amit + Claude | **This repository's Devlog block lives in `.claude/CLAUDE.md`, not a root `CLAUDE.md`.** Why: `claude plugin validate --strict` warns on a `CLAUDE.md` at a plugin root ("not loaded as project context"), and the release gate in `TESTING.md` treats warnings as errors, so a root file blocks every tag. `.claude/CLAUDE.md` is also loaded as project memory by Claude Code and passes the gate. Alternative rejected: dropping `--strict` from the gate, which would also hide manifest warnings. Proof: validation output quoted in `docs/tickets/init-writes-root-claude-md-that-fails-plugin-strict-validation.md`; a headless session in this repo quoted the block from the new path. Files: `.claude/CLAUDE.md`, `docs/tickets/init-writes-root-claude-md-that-fails-plugin-strict-validation.md`. |

## Open questions

Intentionally deferred decisions. Each states the question and the trigger for
revisiting it. When resolved, it becomes a decision row and is struck from
this list with a pointer to that row.

1. Public changelog page generated from `CHANGELOG.md`. Deferred: needs tooling and a deploy; a `blog` post per release covers it for now. Revisit when a project using the plugin asks for one.
2. Store release notes and what's-new copy derived from a changelog section (ties to the welcome-and-whats-new skill). Revisit once a store-shipped project has cut two releases with the `releases` skill.
3. A shell script for deterministic carrier detection. Revisit only if model-driven detection misreads a carrier in practice; see decision row 3.
4. Metrics pull from platform APIs for posts. Out of scope; metrics stay a pasted, dated update below the post body. Revisit if the manual update is skipped on three posts in a row.
5. Backfilling tags for 0.1.2 (commit aa97166) and 0.2.0 (commit 024cb34), and whether `claude plugin tag` can produce them at past commits. Revisit when 0.3.0 is tagged.
6. Whether this plugin itself builds in public (a `docs/posts/` folder and the Building in public bullet). Deferred until the user says so; no folder and no bullet were created at init.
