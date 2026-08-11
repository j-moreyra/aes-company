# Cloud Routines — inventory and live state

Every scheduled Routine on William's claude.ai account, as of **2026-08-11**.

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
| Morning AES brief | `trig_01L9DC3tQmzsy9e6jhoNYqfZ` | `30 9 * * *` | 05:30 ET, **daily** | `aes-company` |
| Weekly HubSpot Follow-ups | `trig_01K9Bsr6PfekZRNSaJmi1QRV` | `0 10 * * 0` | 06:00 ET Sundays | `email-style-guide` |
| Daily AI Tools Registry Update | `trig_01W9L6gno6T718ELPY6w33Fs` | `0 13 * * *` | 09:00 ET daily | `ai-tools-registry` |
| Morning brief *(superseded)* | `trig_01NiWkDRJesPrR7y2a1wyrSU` | `0 10 * * 1-5` | — | none |

**All crons are UTC and do not follow daylight saving.** Every local time above shifts one hour
earlier when clocks fall back on **1 November 2026**. Each Routine needs its hour incremented that
week or it starts firing an hour early.

---

## Open configuration problems

Both were found by reading live state on 2026-08-11 and neither is visible from the prompt text.

### 1. Weekly HubSpot Follow-ups cannot post its summary

Its connectors are **Apollo-io, Composio, HubSpot, Microsoft-365**. There is **no Slack**.

Step 8 of that Routine posts the run summary as a Slack DM to `william@advengsys.com`. Without
the connector the run will draft all five follow-ups correctly and then fail at the last step,
leaving five drafts in Outlook with nothing announcing they exist.

**Fix:** add **Slack** to the Routine's connector list. **Apollo-io can be removed**, the prompt
never uses it.

### 2. Morning AES brief fires more often and earlier than intended

| | Intended | Deployed |
|---|---|---|
| Time | 06:00 Eastern | **05:30 Eastern** |
| Days | Weekdays | **Every day, weekends included** |

Weekdays at 06:00 Eastern is `0 10 * * 1-5`. Deployed is `30 9 * * *`.

Not broken, just wider than asked for. Left as-is pending William's call.

---

## Notes per Routine

### Morning AES brief

Prompt mirrored in `references/routines/morning-brief.md`. Connectors: Composio, HubSpot,
Microsoft-365. First fired 2026-08-11.

It reads `context/watchlist.md` from this repo before reading the mailbox, which is the reason the
repo is attached and the reason the `morning` skill was committed to `.claude/skills/`. A Routine
can only use skills committed to the repository it clones.

**One deployed-prompt gap.** Its STEP 1b reads *"Raise any entry whose Nudge after date has
passed"* and lacks the owner clause added on 2026-08-10. Harmless in practice, because entries
William does not own carry `Nudge after: none` rather than a date, so nothing matches. Worth
adding if the file ever gains an owned entry with a date that should not nudge:

```
  b) Raise any entry that WILLIAM OWNS whose "Nudge after" date has passed
     with nothing back, even if no email arrived. Never nudge an entry whose
     Owner is anyone other than William, whatever its date says. Their
     context still attaches on a Thread-marker match.
```

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

### Morning brief (superseded)

The original, created through the MCP API rather than the routine form. It prompted for permission
on every connector call, which a properly registered Routine never does. Replaced by **Morning AES
brief** and disabled on 2026-08-11 rather than deleted. Harmless; delete when convenient.

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
