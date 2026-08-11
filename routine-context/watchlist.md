<!--
GENERATED COPY - DO NOT EDIT
Source:  context/watchlist.md
Commit:  cc9fc38
Taken:   2026-08-11
Refresh: ./routine-context/sync.sh
Edit the source file. Anything typed here is lost on the next sync.
-->

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
file before it reads the mailbox. Two behaviours, and they are gated differently:

- **Context attach, for every entry regardless of owner.** When an email matches an entry's
  **Thread markers**, the brief attaches that entry's context instead of treating the message as a
  bare inbox item.
- **Nudge, only for entries William owns.** When a William-owned entry is past its **Nudge after**
  date with nothing back, the brief raises it even though no email arrived. This is the case email
  alone can never surface.

**The `Owner` field is what separates them.** Joaquin runs the LatAm outreach campaign, so several
entries here are his threads. William still wants their context when a reply lands in his mailbox,
and does not want a reminder to chase something that is not his to chase. An entry owned by anyone
other than William is never nudged, whatever its date says.

## Format

One `###` heading per entry. Keep every field, write `—` if it does not apply yet.

```
### Name — Company / plant

- **Owner:** William, or whoever actually runs the thread. Only William's entries get nudged.
- **Who:** name, email, role. Mark the decision maker.
- **Stage:** where it actually is, in your words. Not a CRM stage.
- **Why it matters:** the context that is not in any email.
- **Waiting on:** what, from whom, since when.
- **Next step:** what you do next.
- **Nudge after:** a date, or `none`. Write `none` on anything William does not own.
- **Thread markers:** subject keywords, job numbers, domains. How the brief links mail to this.
```

Move an entry into `active-projects.md` once it becomes real work, and delete it from here.
Two homes for the same item is how the style-guide drift happened.

---

## Entries

Seeded from `active-projects.md` on 2026-08-10, then filled from the Outlook mailbox the same day.
**Every fact below is from a real message, cited by date.** The `Next step` and `Nudge after`
lines are proposals, not observations. Change them freely; they are the only judgment calls here.

### John Mahnke — Gold Bond Building Products

- **Owner:** William.
- **Who:** John Mahnke, `jwmahnke@goldbondbuilding.com`, **Plant Engineer**, 224.572.4068.
  **Not the budget holder.** He is the requester. Whoever signs the 2027 capital plan has not
  appeared in any thread yet, and finding out who that is matters more than another nudge to John.
- **Stage:** budgetary number already delivered, awaiting response. Not a deal, but further along
  than the other two entries.
- **Why it matters:** inbound and self-qualified, with a named budget year. The exact shape 90-day
  priority #1 is meant to produce. It is also **not new**: the thread "Fiberglass feeder + AES"
  runs back to 2024, including a "you're probably still swamped with the outage" nudge, and it has
  stalled and restarted more than once. Treat a silence here as normal for this relationship
  rather than as a lost lead.
- **Waiting on:** John, since **2026-07-21**. Sequence: William opened it 2026-07-18 off an Eric
  Li referral, John replied 2026-07-20 asking for high budgetary numbers for 2027 capital
  planning with design in Q1 or Q2, and William sent **$200,000.00** on 2026-07-21. Nothing back
  since. Twenty days as of 2026-08-10.
- **Next step:** *(proposed)* short nudge on the number, and use it to ask who owns the 2027
  capital plan. The second question is the one that unblocks this.
- **Nudge after:** **2026-08-22.** *(proposed)* About a month after the number went out. Design
  starting Q1 to Q2 2027 means the decision lands in Q4 2026, so a second, harder re-engage
  belongs in October regardless of what happens in August.
- **Thread markers:** `Mahnke`, `jwmahnke@goldbondbuilding.com`, `Gold Bond`, `budgetary`, `2027`,
  `capital`, `Fiberglass feeder + AES`, `Savannah fiberglass feeder project`

### Alejandro Funes — Holcim

- **Owner:** **Joaquin.** Part of the LatAm outreach campaign he runs. Context still attaches
  if Funes replies into William's mailbox; no nudge.
- **Who:** Alejandro Funes, `alejandro.funes@holcim.com`, Coordinador de Proyectos de Inversión.
  Referred by Martin Diaz, `martin.diaz@holcim.com`, on 2026-07-29.
- **Stage:** contacted once, no reply.
- **Why it matters:** an investment-projects coordinator sits closer to budget than a plant
  engineer, which is why Diaz handing him over is worth more than a normal referral. Holcim also
  spans five countries in the transcript corpus, so there is a lot of recorded conversation to
  draw on before any call.
- **Waiting on:** Funes, since **2026-07-30**. **Joaquin** wrote to him that day, in Spanish, with
  attachments, positioning William as "nuestro ingeniero de campo" and citing the meetings with
  Martin Diaz. Nothing back. Eleven days as of 2026-08-10.
- **Next step:** *(proposed)* this is Joaquin's thread, not William's. Coordinate rather than
  writing in parallel, or the referral gets two uncoordinated approaches.
- **Nudge after:** **none.** Joaquin's thread. Was proposed as 2026-08-20, three weeks after first
  contact, if it is ever reassigned to William.
- **Thread markers:** `Funes`, `alejandro.funes@holcim.com`, `martin.diaz@holcim.com`,
  `Para dosificar clinker caliente al molino`, `Proyectos de Inversión`

### Rafael Daal — Polpaico Chile

- **Owner:** **Joaquin.** Confirmed by William 2026-08-10. William asked Godoy for Daal's phone
  number on 2026-08-09, so he does touch the thread, but chasing it is not his. Context still
  attaches if Daal or Godoy replies; no nudge.
- **Who:** Rafael Daal, Polpaico, domain `polpaicosoluciones.cl`. Took over the role from a
  departed Aguilera. Also in the thread: José Godoy Ahumada,
  `jose.godoyahumada@polpaicosoluciones.cl`, Jefe de operaciones molienda de cemento, who is the
  one who flagged the handover and is the practical route to Daal.
- **Stage:** contacted once, no reply, and a phone route is already being opened.
- **Why it matters:** a contact change silently resets a warm thread to cold. Anything the
  predecessor agreed to is not something Daal knows about, and nothing in the mailbox says so.
  Godoy is the useful relationship here, since he volunteered the handover unprompted.
- **Waiting on:** Daal, since **2026-07-30**. Sequence: Joaquin wrote to the predecessor
  2026-07-22; Godoy replied the same day that the person no longer belongs to Cemento Polpaico
  and that Daal has taken the role, CC'ing him; Joaquin then wrote to Daal directly on 2026-07-30.
  Nothing back. On **2026-08-09**, William asked Godoy for Daal's phone number, so a call is
  already the intended next move.
- **Next step:** *(proposed)* nothing until Godoy sends the number. Chasing by email again while
  a phone route is open just adds noise.
- **Nudge after:** **none.** Joaquin's thread. Was proposed as 2026-08-18, on the reasoning that
  if Godoy had not produced a number by then the thing to chase is Godoy rather than Daal.
- **Name discrepancy, unresolved.** `active-projects.md` records the departed contact as
  **Francisco** Aguilera. The mail thread addresses him as **Ronald Moya** Aguilera. Surname
  matches, first name does not. One of the two is wrong and the mailbox is the better source, but
  it is not worth correcting until someone confirms which.
- **Thread markers:** `Daal`, `Polpaico`, `polpaicosoluciones.cl`, `Godoy`, `Aguilera`,
  `Balanza para clínker`

---

## Add your own below

Copy the format block above. The fields that make the brief useful are **Thread markers**, which
is how mail gets linked to context, and **Nudge after**, which is what lets something surface with
no email at all.
