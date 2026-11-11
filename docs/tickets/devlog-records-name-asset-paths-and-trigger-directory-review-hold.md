# Devlog records that name an image or font file's path get a plugin held for review by the plugin directory

Status: OPEN · Priority: MEDIUM · Type: skill gap · Cost: none

> Affects any plugin repository that uses devlog with its records inside the
> plugin folder, this one included. Related to
> `init-writes-root-claude-md-that-fails-plugin-strict-validation.md`
> (another case of devlog files tripping plugin checks), but a different check.

## Symptom

On 2026-11-11 the plugin directory's scan held this plugin for manual review
with finding UNREAD_ASSET_REFERENCED. The flagged files were `CHANGELOG.md`,
`docs/DECISIONS.md` and `docs/PROGRESS.md`. Each named the new listing icon's
file path, because the session-wrap wrote that path into the Unreleased
bullet, decision row 7 and the progress entry. The skills tell the model to list
every touched file by path, so this happens whenever a session adds an image or
font.

## Evidence

The scan's text, as pasted by the user:

```
File CHANGELOG.md names "<the icon path>", an image or font the validator
let through without reading as code. A shell or interpreter pointed at such
a file could run its bytes as code, so the plugin is held for review.
(same for docs/DECISIONS.md and docs/PROGRESS.md)

UNREAD_ASSET_REFERENCED
1 well-formed image or font file(s) were let through without being read as
code (their printable text was still screened)
```

The scan also said: "If your organization isn't Verified, the file, or a
command that runs it, can be refused." The placeholder paths in
`skills/posts/SKILL.md` and `skills/posts/templates/post.md` were not
flagged. No such file exists, so the scan appears to match only paths of
files that really exist in the plugin.

## Why it matters

The hold turns a clean submission into a manual review that can be refused.
The fix used here, editing records in place (decision row 8), goes against
the append-only rule the plugin teaches. A user hitting this in their own
plugin repo would face the same choice with no guidance.

## Scope to decide

- Option A: a rule in `progress-log`, `decision-log`, `session-wrap` and
  `releases`: in a plugin repository, refer to image and font files by
  role ("the listing icon in the manifest folder"), never by path.
- OR Option B: `init` detects a plugin repository and suggests keeping the
  plugin in a subfolder, with `docs/` outside the scanned plugin.
- OR Option C: both. A for existing repos, B for new ones.

No code change made by this ticket. It is an observation on the record.
