# Workplan — <call or trigger>, <YYYY-MM-DD>

Status <YYYY-MM-DD>: <what was chosen, built, deployed; what still waits and on whom. Update this paragraph as things move; the decision row and the progress entry hold the outcome.>

Client-facing record: `docs/emails/<YYYY-MM-DD_to_<who>_call_summary.md>` (transcript: `docs/calls/<transcript>.txt`). Binding decisions: row N in `docs/DECISIONS.md`. Routes below are proposals with a recommendation each; the chosen route gets its own decision row when the feature is built.

Sizes: S = under half a session, M = one to two sessions, L = several. "Blocked" = cannot finish without client input (building under an explicit, named assumption is allowed where noted).

Suggested order: <F1 + F3 (S, one deploy) -> F2 (M) -> ...>, because <reason>.

---

## F1 — <feature> (decision row N, point k) — <S|M|L>, <not blocked | blocked on X>

What the client asked for, in their words where it matters. What the current code does (file:line). Routes (two to four; each states how it works, what it can never do, and the effort):

- Route A: <how it works, what it can never do, effort>.
- Route B: <...>.

Recommendation: <A, because ...>.

## F2 — ...

---

## Blocked-on-client tracker

| Who | Owes | Unblocks |
|---|---|---|
| <client person> | <what> | <F-number or decision> |
| <client person> | ~~<delivered item>~~ (arrived YYYY-MM-DD, row N) — still owes: <remainder> | <...> |
