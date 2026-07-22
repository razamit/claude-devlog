#!/bin/sh
# Shared detection: does the current project use the devlog system?
#
# Sourced by the hook scripts. Sets DEVLOG_PROGRESS / DEVLOG_DECISIONS /
# DEVLOG_TICKETS to the paths found (relative to the project root), each empty
# when absent. Exits the CALLING script silently (0) when none are found, so
# the hooks stay completely quiet in projects that have not adopted devlog —
# important because the plugin is typically installed at user scope and its
# hooks therefore run in every project.

devlog_root="${CLAUDE_PROJECT_DIR:-$PWD}"
cd "$devlog_root" 2>/dev/null || exit 0

DEVLOG_PROGRESS=""
DEVLOG_DECISIONS=""
DEVLOG_TICKETS=""

for candidate in docs/PROGRESS.md PROGRESS.md docs/Implementation_progress.md; do
  if [ -f "$candidate" ]; then DEVLOG_PROGRESS="$candidate"; break; fi
done

for candidate in docs/DECISIONS.md DECISIONS.md; do
  if [ -f "$candidate" ]; then DEVLOG_DECISIONS="$candidate"; break; fi
done

for candidate in docs/tickets docs/issues; do
  if [ -d "$candidate" ]; then DEVLOG_TICKETS="$candidate"; break; fi
done

if [ -z "$DEVLOG_PROGRESS" ] && [ -z "$DEVLOG_DECISIONS" ] && [ -z "$DEVLOG_TICKETS" ]; then
  exit 0
fi
