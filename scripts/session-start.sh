#!/bin/sh
# SessionStart hook — tell Claude this project keeps a devlog, and where.
#
# For SessionStart, plain stdout on exit 0 is added to Claude's context, so no
# JSON is needed. Silent in projects without devlog files.

. "$(dirname "$0")/devlog-detect.sh"

printf 'This project keeps a devlog. Follow it without being asked:\n'

if [ -n "$DEVLOG_PROGRESS" ]; then
  printf -- '- `%s` — progress log, newest entry first. Read the head to learn current state before planning work. Prepend an entry (status marker, scope note, real proof, files, cross-refs) for each completed unit of work.\n' "$DEVLOG_PROGRESS"
fi

if [ -n "$DEVLOG_DECISIONS" ]; then
  printf -- '- `%s` — append-only decision log. Existing rows are binding: do not silently reverse one, and check it before proposing a change it may already have settled. Record every consequential choice made this session as a new row, with its why and the alternatives rejected.\n' "$DEVLOG_DECISIONS"
fi

if [ -n "$DEVLOG_TICKETS" ]; then
  open_tickets=$(grep -rl '^Status: OPEN' "$DEVLOG_TICKETS" 2>/dev/null | wc -l | tr -d ' ')
  printf -- '- `%s/` — one file per known issue (%s open). When you notice a defect or gap you will not fix now, file a ticket there rather than leaving a TODO comment or only mentioning it in chat.\n' "$DEVLOG_TICKETS" "$open_tickets"
fi

printf -- '- Before any commit, run the session-wrap discipline: an evidence summary naming every file in the diff, then the log updates above, then the commit.\n'
printf 'The `devlog` plugin skills (progress-log, decision-log, tickets, session-wrap) hold the full conventions — read the relevant one before writing to these files.\n'
