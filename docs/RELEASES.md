# Releases

Every file that carries the version, listed once, and every release cut.
Detected at `/devlog:init` on 2026-10-11; re-detected only by
`/devlog:releases status` or when a listed path no longer exists. This
repository is the devlog plugin itself: its changelog predates the progress
log, so the 0.1.2 to 0.3.0 sections were written by hand and carry no version
stamps to reconcile. From 0.4.0 on, shipping entries carry `[unreleased]`.

## Carriers
- Canonical: `.claude-plugin/plugin.json` `version`
- Mirrors: none (`.claude-plugin/marketplace.json` has no version field and is not a carrier)
- Derived, do not edit: none
- Build number: none
- Tag: `devlog--vX.Y.Z`, made by `claude plugin tag` per TESTING.md and pushed by hand, latest `devlog--v0.3.0`
- Changelog style: `## X.Y.Z — YYYY-MM-DD`; the feed goes under `## Unreleased` in the same style, created at the first wrap that needs it
- Bump policy: decision row 2

## Index, newest first

| Version | Date | Build | Tag → commit | Shipped | Post |
|---|---|---|---|---|---|
| 0.3.0 | 2026-10-11 | | devlog--v0.3.0 → 7972e61 (release commit d24ed33) | CHANGELOG 0.3.0 section; PROGRESS 2026-10-11 | docs/posts/2026-10-12_x_release-0-3-0.md |
| 0.2.0 | 2026-08-27 | | untagged (024cb34), open question 5 | CHANGELOG 0.2.0 section | |
| 0.1.2 | 2026-07-22 | | untagged (aa97166), open question 5 | CHANGELOG 0.1.2 section | |
