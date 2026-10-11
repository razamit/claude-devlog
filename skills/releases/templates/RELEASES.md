# Releases

Every file that carries the version, listed once, and every release cut.
Detected at init or on the first release action; re-detected only by
`/devlog:releases status` or when a listed path no longer exists. The
changelog section for each release is written from the progress entries
stamped with that version.

## Carriers
- Canonical: `<path>` `<field>`
- Mirrors: `<path>` `<field>`
- Derived, do not edit: `<path>` `<field>` (<variable the build fills>)
- Build number: `<path>` `<field>`, last used N
- Tag: `vX.Y.Z`, annotated, latest `<tag or none>`
- Changelog style: `## [X.Y.Z] - YYYY-MM-DD`
- Bump policy: decision row N

## Index, newest first

| Version | Date | Build | Tag → commit | Shipped | Post |
|---|---|---|---|---|---|
| 0.1.0 | YYYY-MM-DD | 1 | v0.1.0 → pending | YYYY-MM-DD | |
