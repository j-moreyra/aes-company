# Watchlist — leads and projects that are not deals yet

Context that email cannot tell you. Who the real decision maker is, what stage something is
actually at, what you are waiting on, and why it matters. The things you carry in your head.

**This file is hand-maintained and must never be auto-refreshed.** That is the whole point of it
existing separately from `context/active-projects.md`, which says of itself *"this goes stale
fast, treat it as orientation, not truth, re-derive from Outlook before acting."* Anything written
here by hand would be destroyed by that re-derive. Nothing in this file is derivable from the
mailbox, so nothing here should ever be overwritten from it.

**Why not HubSpot.** These are pre-deal. Creating deal records for them would make the CRM's
existing data-quality gap worse, since most deals already carry no `amount` and no `closedate`,
and nothing downstream could then tell a real deal from a placeholder.

**How the morning brief uses it.** The Routine clones this repo on every run, so it reads this
file before it reads the mailbox. When an email matches an entry's **Thread markers**, the brief
attaches that entry's context instead of treating the message as a bare inbox item. When an entry
is past its **Nudge after** date with nothing back, the brief raises it even if no email arrived,
which is the case email alone can never surface.

## Format

One `###` heading per entry. Keep every field, write `—` if it does not apply yet.

```
### Name — Company / plant

- **Who:** name, email, role. Mark the decision maker.
- **Stage:** where it actually is, in your words. Not a CRM stage.
- **Why it matters:** the context that is not in any email.
- **Waiting on:** what, from whom, since when.
- **Next step:** what you do next.
- **Nudge after:** a date. The brief raises it after this even with no new mail.
- **Thread markers:** subject keywords, job numbers, domains. How the brief links mail to this.
```

Move an entry into `active-projects.md` once it becomes real work, and delete it from here.
Two homes for the same item is how the style-guide drift happened.

---

## Entries

The three below were seeded from `active-projects.md` on 2026-08-10 because they are pre-deal and
were sitting in a file that gets re-derived. **Fields marked `TODO` need William.** Everything
else is carried over verbatim and is only as current as the 2026-08-02 sweep it came from.

### John Mahnke — Gold Bond Building Products

- **Who:** John Mahnke, Gold Bond Building Products. Decision maker: TODO, confirm whether Mahnke
  holds the capital budget or is gathering for someone who does.
- **Stage:** inbound and self-qualified. Asked 2026-07-20 for high budgetary numbers for **2027
  capital planning**. Design starts Q1 to Q2 2027.
- **Why it matters:** a stated budget cycle with a named year is the exact shape 90-day priority
  #1 is meant to produce. It is also the only inbound lead on file that arrived pre-qualified.
- **Waiting on:** TODO. Whether budgetary numbers were ever sent back to him.
- **Next step:** TODO.
- **Nudge after:** TODO. A 2027 capital cycle means the real window is roughly Q4 2026, so a
  check-in well before then is worth scheduling.
- **Thread markers:** `Mahnke`, `Gold Bond`, `budgetary`, `2027`, `capital`

### Alejandro Funes — Holcim

- **Who:** Alejandro Funes, Coordinador de Proyectos de Inversión, Holcim. Referred by Martin Diaz.
- **Stage:** referral, warm. Came out of the LatAm outreach campaign.
- **Why it matters:** an investment-projects coordinator is closer to budget than a plant
  engineer. Holcim already spans five countries in the transcript corpus, so there is a lot of
  recorded conversation to draw on.
- **Waiting on:** TODO. Whether Funes has been contacted since the referral.
- **Next step:** TODO.
- **Nudge after:** TODO.
- **Thread markers:** `Funes`, `Holcim`, `Diaz`, `@holcim.com`, `proyectos de inversión`

### Rafael Daal — Polpaico Chile

- **Who:** Rafael Daal, Polpaico. Took over from Francisco Aguilera, who has left the company.
- **Stage:** relationship handover, unconfirmed. The prior contact is gone.
- **Why it matters:** a contact change silently resets a warm thread to cold. Anything Aguilera
  agreed to is not something Daal knows about, and nothing in the mailbox will say so.
- **Waiting on:** TODO. Whether Daal has been introduced to at all.
- **Next step:** TODO. A reintroduction that re-states the history rather than assuming it
  carried over.
- **Nudge after:** TODO.
- **Thread markers:** `Daal`, `Polpaico`, `Aguilera`

---

## Add your own below

Copy the format block above. The fields that make the brief useful are **Thread markers**, which
is how mail gets linked to context, and **Nudge after**, which is what lets something surface with
no email at all.
