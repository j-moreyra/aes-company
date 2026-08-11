# Routine prompt: Morning AES brief

Mirror of the prompt for Routine `trig_01L9DC3tQmzsy9e6jhoNYqfZ`, created 2026-08-11 through the
routine form. See `references/routines/README.md` for live state across all Routines.

**Config as deployed:**

| Field | Value |
|---|---|
| Cron | `30 9 * * *` (05:30 Eastern, **daily**) |
| Intended | 06:00 Eastern, weekdays, which is `0 10 * * 1-5` |
| Repositories | `j-moreyra/aes-company` |
| Connectors | Composio, HubSpot, Microsoft-365 |
| Notifications | push off, email off (the Routine emails the brief itself) |

**Why the repo is attached.** The prompt reads `context/watchlist.md`, and the `morning` skill
lives at `.claude/skills/morning/` in this repo. A Routine can only use skills committed to the
repository it clones, so without the attachment neither would load.

**Why Composio is on the list.** The Microsoft 365 connector cannot send mail on this tenant:
`Mail.Send` and `Mail.ReadWrite` are both unconsented and return HTTP 403. Composio holds a
separate OAuth grant with write scope. Verified 2026-08-10.

**One known gap in the deployed text.** STEP 1b lacks the owner clause added on 2026-08-10. See
the README for the replacement wording and why it is currently harmless.

---
<!-- BEGIN PROMPT -->
Run my morning brief for today, then email me a link to it.

Use the `morning` skill. Write it in English. This is an unattended scheduled
run: nobody is at the keyboard, so skip the connector suggestion cards and
just render the page.

I am William Moreyra at Advanced Engineering Systems (AES). Pull from:
- Outlook mail and Outlook Calendar, via the Microsoft 365 connector
- Microsoft Teams, via the same connector
- HubSpot, for open deals

If a connector is missing in this session, say so plainly at the top of the
brief and render what you can. Do not silently drop a source.

STEP 1. Read `context/watchlist.md` from the cloned repository BEFORE reading
the mailbox. It holds pre-deal leads and context email does not contain.

Use it two ways:
  a) When an email matches an entry's Thread markers, attach that entry's
     context to the item rather than describing the mail on its own.
  b) Raise any entry that WILLIAM OWNS whose "Nudge after" date has passed
     with nothing back, even if no email arrived. Never nudge an entry whose
     Owner is anyone other than William, whatever its date says. Their
     context still attaches on a Thread-marker match.

Fields labelled "(proposed)" are my suggestions, not commitments. Treat them
as defaults I may have changed.

STEP 2. Check who each email is actually for, before putting anything on
Needs attention.

  - If I am only in CC, it is informational. Do not make it my task unless
    the body names me directly.
  - If I am in To alongside several others, read who the question names. A
    question addressed to someone else by name is theirs, not mine, even
    though I am on the To line.
  - If anyone on the list could answer and nobody was named, it is not my
    bottleneck. Leave it out.
  - Only call it mine when I am the named recipient of the ask, or I am the
    only person in To, or the body addresses me by name.

  When you do surface one, say why it is mine in the item's sentence, for
  example "addressed to you directly" or "you are the only recipient". If you
  cannot say why, do not include it.

STEP 3. Alongside the skill's normal Needs attention / Resolved lists,
include these three sections in this order:

  1. Waiting on a reply, aging. Threads where I sent the last message and
     nothing came back. Split Kukla from clients, and give the age in days.
     Kukla contacts are all @kukla.co.at (lenzeder, zopf, humer, gruber,
     fuertbauer, habring). Do NOT text-search for the word "Kukla": the AES
     email signature reads "Exclusive representatives of Kukla Waagenfabrik
     GmbH for the Americas", so every message any AES person sends matches
     it. A test search returned 23 false positives out of 25 hits. Filter on
     the sender domain instead.

  2. Flagged mail. My Outlook flags are my de-facto task list. There is no
     separate task database.

  3. Open HubSpot deals with no recent activity. Include the Georgia-Pacific
     fiberglass feeder at Cumberland City, TN. Rank by staleness, not by
     value: most deals have no `amount` or `closedate` populated, so do not
     quote or infer pipeline figures. Say the field is empty if it is empty.

Timing matters. Kukla is in Austria, six hours ahead of me. Their workday
ends around 11:00 my time, so anything needing a Kukla reply is
time-critical this morning and should be called out as such.

STEP 4, always do this. Email me the brief.

Send to william@advengsys.com with subject "Morning brief - <today's date>".

Send it through COMPOSIO, not the Microsoft 365 connector. The Microsoft 365
connector cannot send: Mail.Send and Mail.ReadWrite are not admin-consented
on this tenant and both return HTTP 403. Composio holds a separate grant
with write scope and works.

Use the Composio tool OUTLOOK_SEND_EMAIL. Two Outlook accounts are connected
and account selection is required, so always pass the account explicitly:
use `outlook_carper-jat` (alias advengsys-william, William@advengsys.com).
Do NOT use `outlook_clunk-quirl`, that is a different mailbox. Set is_html
true. A 202 response means accepted; treat it as sent.

Body: if you published the brief and have a URL for it, the body is just
that link and one short line of context, nothing else. If no artifact URL is
available in this run, put the brief itself into the email body as HTML
instead, and say at the top that the link version was unavailable. Never
send an empty email or an email with a broken link.

Confirm in the session what you sent and to which address.
<!-- END PROMPT -->
