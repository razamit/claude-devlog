---
name: releases
description: 'Use when the user says release, ship, bump, tag, changelog or build number, when a version field is edited by hand, and for the one-line drift check at session-wrap. Puts versions and releases on the record: every file that carries the version listed once in docs/RELEASES.md (canonical, mirrors, derived fields never edited by hand), drift between carriers and tags flagged, progress entries stamped [unreleased] and flipped to [X.Y.Z] at the cut, a CHANGELOG.md section written from those entries, a bump proposed from Added/Changed/Fixed with the reasoning shown, carriers moved together in one commit, tags annotated only on request and never pushed.'
disable-model-invocation: false
---

# Releases: one version, every carrier, on the record

A project's version lives in several files at once and they drift apart
silently: a bumped `pubspec.yaml`, a `versionName` someone edited by hand, a
tag nobody made. `docs/RELEASES.md` (or the path the project's CLAUDE.md
names) lists every file that carries the version, once, and indexes every
release cut. The changelog is written from the progress log, never from
memory, so a release section can be checked against the entries it claims.

## When to act, where

When the user says release, ship, bump, tag, changelog or build number, or
edits a version field by hand; at every session-wrap, for one drift line and
the Unreleased feed; at init, or lazily on the first release action.
`CHANGELOG.md` sits at the root, or wherever the project keeps it. Tags are
`vX.Y.Z`, annotated, unless the project tags another way. Cite "release
1.3.0" in prose; the stamp on an entry is `[1.3.0]`.

## Carriers: detect once, record, never re-detect

Look for: `package.json` `version`; `pubspec.yaml` `version: X.Y.Z+B`;
`build.gradle(.kts)` `versionName` and `versionCode`; `Info.plist`
`CFBundleShortVersionString` and `CFBundleVersion`, or `project.pbxproj`
`MARKETING_VERSION` and `CURRENT_PROJECT_VERSION`; `Cargo.toml`;
`pyproject.toml`, `setup.py` or `__version__`; `.claude-plugin/plugin.json`;
a `VERSION` file; `git describe --tags --abbrev=0`; the top heading of
`CHANGELOG.md`.

- A field holding a variable (`$(FLUTTER_BUILD_NAME)`, `flutterVersionName`)
  is **derived: do not edit**. The build fills it from the canonical carrier.
- The canonical carrier is the one the build reads first (pubspec for
  Flutter, package.json for npm). When CI computes the version from tags,
  the tag is canonical. When unclear, ask; the answer is a decision row.
- No carrier anywhere: offer 0.1.0 in the ecosystem's native field, or a
  `VERSION` file when there is none. That is a decision row.
- Detection runs once and writes the registry; later sessions read it.

Registry block, exactly as in `templates/RELEASES.md`:

```markdown
## Carriers
- Canonical: `pubspec.yaml` `version`
- Mirrors: `.claude-plugin/plugin.json` `version`
- Derived, do not edit: `android/app/build.gradle` `versionName` (flutterVersionName), `ios/Runner/Info.plist` `CFBundleShortVersionString` ($(FLUTTER_BUILD_NAME))
- Build number: `pubspec.yaml` after `+`, last used 31
- Tag: `vX.Y.Z`, annotated, latest `v1.2.4`
- Changelog style: `## [X.Y.Z] - YYYY-MM-DD`
- Bump policy: decision row N
```

## Drift

`status` checks five things and quotes the values for each:

1. Carriers disagree with each other or with the canonical value.
2. The canonical version is ahead of the latest tag with no changelog
   section, or a tag exists with no section.
3. `## [Unreleased]` is non-empty while the version was already bumped.
4. A `[X.Y.Z]` stamped entry has no bullet in that section, or a bullet has
   no stamped entry.
5. The build number is not above the last one used.

Session-wrap writes one line, in one of two forms. Unfixed drift becomes a
ticket, the two disagreeing values quoted as the symptom.

```
Release: 1.2.4+31 on all carriers, tag v1.2.4, 3 entries unreleased, no drift.
Release drift: versionCode 31 = last used; versionName 1.2.4 vs pubspec 1.3.0. Run /devlog:releases status.
```

## The version stamp and the Unreleased feed

A progress entry for work that reaches users ends its headline with
`[unreleased]`. At the cut it is flipped to the version it shipped in:

```markdown
**2026-10-07 — Offline queue retries failed uploads (code + tests). ✅ DONE [unreleased]**
**2026-10-07 — Offline queue retries failed uploads (code + tests). ✅ DONE [1.3.0]**
```

`grep '\[1.3.0\]' docs/PROGRESS.md CHANGELOG.md` then returns the section
and every entry in it. Docs-only and correspondence entries carry no stamp.
The flip is the one permitted edit to an old entry (precedent: ⛔ NOT STARTED).

In the same wrap step, each stamped entry gets one user-facing sentence
under `## [Unreleased]`, grouped under Added, Changed, Deprecated, Removed,
Fixed or Security (only groups with bullets), ending with the entry date:
`- Failed uploads retry when the connection returns (2026-10-07)`. The bullet
says what the user sees; the entry holds why, proof and files.

## Proposing the bump

Read every stamped entry and decision row since the last release (the newest
index row's date; before any row, the latest tag or heading). Major: something
Removed, a behaviour users depend on changed, a schema migration, a format or
API change. Minor: anything Added. Patch: only Fixed or internal work.
Pre-1.0: breaking or added both propose minor, fixes propose patch, and never
propose 1.0.0. Build number: the highest ever used plus one, on every cut,
because stores reject a repeated number.

State the reasoning one line per criterion, citing entry dates and row
numbers. The user decides. Overriding the proposal is a decision row.

## Cutting a release

1. Run `status`. Refuse to cut over drift the user has not seen and accepted.
2. Reconcile `## [Unreleased]` both ways: every stamped entry has a bullet,
   every bullet has an entry. Add what is missing, each bullet with its date.
3. Rename the section to `## [X.Y.Z] - YYYY-MM-DD` and insert a fresh empty
   `## [Unreleased]` above it.
4. Edit every carrier in the registry to X.Y.Z (and the build number), never
   a derived field. Grep all of them and show the equal values.
5. Flip every `[unreleased]` stamp to `[X.Y.Z]`. Backfill the stamp on
   unstamped shipping entries since the last release date and say how many.
6. Prepend the release entry to the progress log and append the index row.
7. Run session-wrap. Commit only if asked, message
   `Release <project> X.Y.Z: <headline>`, carriers and changelog together.
8. Say the tag is pending. When the project builds in public, offer
   `/devlog:posts draft CHANGELOG X.Y.Z`.

Release entry and index row:

```markdown
**YYYY-MM-DD — Release X.Y.Z+B: <headline from the section> (release, carriers + changelog). ✅ DONE**
Carriers before/after: pubspec 1.2.4+31 → 1.3.0+32, plugin.json 1.2.4 → 1.3.0;
`grep -n version pubspec.yaml .claude-plugin/plugin.json` shows 1.3.0 on both.
Section `## [1.3.0] - YYYY-MM-DD`: N bullets from N stamped entries (dates ...).
Backfilled stamps: 0. Tag: pending. Files: CHANGELOG.md, docs/PROGRESS.md, docs/RELEASES.md, <carriers>.

| 1.3.0 | YYYY-MM-DD | 32 | v1.3.0 → pending | 2026-10-07, 2026-10-03 | docs/posts/2026-10-12_x_release-1-3-0.md |
```

## Tagging

Only on explicit request. Check that every carrier at the commit equals
X.Y.Z and the section exists; refuse otherwise. Then
`git tag -a vX.Y.Z -m "<the section's bullets>"` and fill the tag → commit
cell with the short hash. Never push: a pushed tag starts builds and store
uploads nobody can recall.

## Edge cases

- Monorepo: one registry and index per package, versions `<pkg>@X.Y.Z`. A
  release tool (changesets, release-please) that owns the version is
  canonical; this skill only records. Lockstep versioning is out of scope.
- Version computed in CI from tags: `cut` edits no file; the tag is the
  release act.
- This plugin itself: `.claude-plugin/plugin.json` is canonical,
  `marketplace.json` has no version and is not a carrier, the heading style
  `## 0.2.0 — 2026-08-27` is kept, and `status` reports the 0.1.2 and 0.2.0
  sections as untagged. Its tags are `devlog--vX.Y.Z`, made and pushed by
  `claude plugin tag` per TESTING.md, so `tag` here only reports.

## Rules

- Never edit a derived field. Carriers move together, in the changelog
  commit. Build numbers only go up.
- The section comes from stamped entries, never from memory or `git log`
  alone.
- Propose the bump; the user makes it. Tag only on request. Never push.
- Match the project's changelog and tag style; the templates are for
  projects without one. Re-detect carriers only through `status` or when a
  listed path is gone.

## When invoked directly (`/devlog:releases <status|propose|cut|tag> [details]`)

- `status`: detect or read the registry, run the five checks, quote the
  values. Writes only the registry, on first run.
- `propose`: the bump with one line per criterion. Writes nothing.
- `cut <X.Y.Z|patch|minor|major|build>`: the eight steps; `build` moves
  only the build number.
- `tag [X.Y.Z]`: verify, create the annotated tag, fill the index cell.

With no argument, run `status`, then say which of the other three applies.
