# Cloud Routines — inventory and live state

Every scheduled Routine on William's claude.ai account. **Live state re-derived 2026-08-11 after William applied the UI changes.**

**Why this file exists.** A cloud Routine leaves no trace in the repository. Nothing in the file
tree tells you one exists, what it does, when it fires, or that its config has drifted from what
its prompt assumes. Without this page, the only way to know is to open
[claude.ai/code/routines](https://claude.ai/code/routines) and read them one at a time.

**Verify before trusting.** Anything below can be changed in the UI without touching this repo.
Re-derive with `mcp__Claude_Code_Remote__list_triggers` before acting on a detail that matters.
That call returns the live prompt, cron, `enabled` state, `mcp_connections`, `sources` and
`last_fired_at` for every Routine.

---

## Live Routines

| Routine | ID | Cron (UTC) | Local | Repo attached |
|---|---|---|---|---|
| Morning AES brief | `trig_01L9DC3tQmzsy9e6jhoNYqfZ` | set in UI | weekday morning | `aes-company` |
| Weekly HubSpot Follow-ups | `trig_01K9Bsr6PfekZRNSaJmi1QRV` | `0 10 * * 0` | 06:00 ET Sundays | `email-style-guide` |
| Daily AI Tools Registry Update | `trig_01W9L6gno6T718ELPY6w33Fs` | `0 13 * * *` | 09:00 ET daily | `ai-tools-registry` |

**Schedules are not tracked in this file.** William manages them directly in the UI and asked on
2026-08-11 that they stop being flagged here. Read the live cron with `list_triggers` if you
genuinely need it; do not raise it as a finding.

---

## Open configuration problems

**One, and it needs a human.** The morning brief prompt has a third revision sitting in
`morning-brief.md` that has not been pasted into the live Routine. See the notes on that Routine
below. Nothing else from the 2026-08-11 review is open.

**Also unresolved, outside the Routines.** The remote branch
`claude/review-open-branches-67paph` could not be deleted from this environment: the git proxy
returns HTTP 403 on a delete-ref push, and no MCP tool exposes GitHub's delete-branch endpoint.
Pushes and merges work fine, so this is specific to deleting refs. It has to be done from the
GitHub UI. Second time it has happened; assume it will happen again.

### Resolved 2026-08-11

- **Slack added to Weekly HubSpot Follow-ups.** Its Step 8 posts the run summary as a Slack DM and
  the connector was missing, which would have made Sunday's run draft five follow-ups and then
  fail silently at the last step.
- **The superseded `Morning brief` Routine was deleted.**
- **The morning brief prompt was updated** with all six fixes from the first real run: Resolved
  last, no HubSpot deals section, the Kukla name roster, the short item style, the Kukla chains,
  and reading `active-projects.md` so that work owed **to** William is visible.
- **Both Routine schedules were set by William in the UI.**

Two harmless leftovers, noted rather than flagged: **Apollo-io** is attached to the HubSpot
Routine and **HubSpot** to the morning brief, neither used by its prompt. Standing capability with
no purpose, worth dropping whenever either Routine is next open.

---

## Notes per Routine

### Morning AES brief

Prompt mirrored in `references/routines/morning-brief.md`. Connectors: Composio, HubSpot,
Microsoft-365. First fired 2026-08-11.

It reads `context/watchlist.md` from this repo before reading the mailbox, which is the reason the
repo is attached and the reason the `morning` skill was committed to `.claude/skills/`. A Routine
can only use skills committed to the repository it clones.

**The mirror is ahead of the deployed prompt again.** A third revision was written on 2026-08-11
and is waiting to be pasted into the Routine by hand. It carries five changes from a second round
of feedback: the headline is dropped, the three time-block acts are replaced by the real calendar
entries for today and the next two days, multiple items on one project merge into a single entry,
no item may appear in two sections, and Resolved keeps only the last five days. Until it is
pasted, the live Routine keeps producing the headline and the acts, and will keep duplicating
items across sections.

**Editing it takes a human.** Created via `http_api`, so `update_trigger` refuses agent edits, the
same as the HubSpot Routine. Every change goes through the UI.

### Weekly HubSpot Follow-ups

Prompt mirrored in `references/routines/weekly-hubspot-followups.md`, and the live Routine was
updated to match on 2026-08-11. Confirmed present in the deployed prompt: the audience-based
signing rule, "every draft signs Bill", and the no-em-dashes override.

**It clones `j-moreyra/email-style-guide`, not this repo**, and `create_trigger` has no parameter
to change a Routine's source. That is why the voice corrections live inline in its prompt as
explicit overrides rather than as a pointer to `references/voice.md`. If that file is edited, the
overrides in the Routine prompt must be edited too. They will not follow.

Created via `http_api` in April 2026, so `update_trigger` refuses agent edits to it. Every change
goes through the UI.

### Daily AI Tools Registry Update

Belongs to `j-moreyra/ai-tools-registry`, unrelated to AES. Listed here only so a future audit
does not mistake it for an AES Routine and count it toward this project's cadence.

---

## Two things that are true of every Routine here

**Routines never prompt for permission.** Per the routines documentation: *"there is no
permission-mode picker and no approval prompts during a run"*, and *"Claude can use every tool
from an included connector, including writes, without asking for permission during a run."*
If a Routine is prompting, it was not registered through the routine form. That is the fix.

**Included connectors are standing capability, not intent.** A connector on the list can be used
for writes with no approval, whatever the prompt says. Keep each Routine's list to what it
actually needs. The morning brief is read-only but carries Composio, which holds Outlook send
scope, because that is what sends the brief. That is deliberate; anything beyond that is not.
