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
| Morning AES brief | `trig_01L9DC3tQmzsy9e6jhoNYqfZ` | `30 9 * * *` ⚠ | 05:30 ET, **daily** | `aes-company` |
| Weekly HubSpot Follow-ups | `trig_01K9Bsr6PfekZRNSaJmi1QRV` | `0 10 * * 0` | 06:00 ET Sundays | `email-style-guide` |
| Daily AI Tools Registry Update | `trig_01W9L6gno6T718ELPY6w33Fs` | `0 13 * * *` | 09:00 ET daily | `ai-tools-registry` |

**All crons are UTC and do not follow daylight saving.** Every local time above shifts one hour
earlier when clocks fall back on **1 November 2026**. Each Routine needs its hour incremented that
week or it starts firing an hour early.

---

## Open configuration problems

**One left.** Verified against live state on 2026-08-11.

### Morning AES brief still runs on the old schedule

| | Wanted | Deployed |
|---|---|---|
| Cron | `0 10 * * 1-5` | **`30 9 * * *`** |
| Local | 06:00 Eastern, weekdays | 05:30 Eastern, **every day** |

The prompt was updated successfully; the cron field was not. Change it in the UI. Everything else
about this Routine is correct.

Minor, not worth a trip on its own: **HubSpot is still attached** to this Routine and is no longer
used, now that the deals section is gone. Drop it next time the Routine is open.

### Resolved 2026-08-11

- **Slack added to Weekly HubSpot Follow-ups.** Its Step 8 posts the run summary as a Slack DM and
  the connector was missing, which would have made Sunday's run draft five follow-ups and then
  fail silently at the last step. Confirmed present. Apollo-io is still attached and still unused,
  which is harmless.
- **The superseded `Morning brief` Routine was deleted.** No longer in the trigger list.
- **The morning brief prompt was updated** with all six fixes from the first real run: Resolved
  last, no HubSpot deals section, the Kukla name roster, the short item style, the Kukla chains,
  and reading `active-projects.md` so that work owed **to** William is visible.

---

## Notes per Routine

### Morning AES brief

Prompt mirrored in `references/routines/morning-brief.md`. Connectors: Composio, HubSpot,
Microsoft-365. First fired 2026-08-11.

It reads `context/watchlist.md` from this repo before reading the mailbox, which is the reason the
repo is attached and the reason the `morning` skill was committed to `.claude/skills/`. A Routine
can only use skills committed to the repository it clones.

**The mirror is ahead of the deployed prompt.** A revision written on 2026-08-11 is sitting in
`morning-brief.md` waiting to be pasted into the Routine by hand. Until that happens the live
Routine still emails an artifact link. Two changes:

1. **The brief moves into the email body.** Tested on 2026-08-11: the emailed artifact link does
   not open from a phone, so the brief never arrives. The revision composes the brief as inline
   email HTML instead, with no artifact and no link. It overrides the `morning` skill's Build and
   Design sections, which assume a browser — embedded woff2, inline SVG, flex columns, Playwright
   screenshot — none of which a mail client renders. The terrain drawing is dropped rather than
   worked around: Outlook on Windows drops SVG, Gmail strips data-URI images, and a hosted image
   would be blocked by default.
2. **The STEP 1b owner clause is folded in.** The deployed text reads *"Raise any entry whose
   Nudge after date has passed"* and lacks the clause added on 2026-08-10. Harmless so far,
   because entries William does not own carry `Nudge after: none` rather than a date, so nothing
   matches. It would bite the first time the file gains an owned entry with a date that should
   not nudge.

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
