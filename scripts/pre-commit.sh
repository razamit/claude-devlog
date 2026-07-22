#!/bin/sh
# PreToolUse(Bash) hook — remind Claude of the close-out when it reaches for
# `git commit`. Non-blocking: it injects context, it never denies the call.
#
# Reads the tool call on stdin and matches the command text. Silent for every
# other Bash command, and in projects without devlog files.

payload=$(cat)

case "$payload" in
  *'git '*'commit'*) ;;
  *) exit 0 ;;
esac

. "$(dirname "$0")/devlog-detect.sh"

cat <<'JSON'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "additionalContext": "devlog close-out check before this commit: (1) an evidence summary naming EVERY path in `git status --short` / `git diff --stat`, including incidental edits and deletions, verified against the actual diff — a touched-but-unlisted file is how unrelated changes ride in unnoticed; (2) the progress-log entry for this work, with its real proof; (3) a decision-log row for each consequential choice made; (4) tickets closed or newly filed for what this session surfaced. The log updates belong in THIS commit, not a later one. If all four are already done, proceed."
  }
}
JSON
