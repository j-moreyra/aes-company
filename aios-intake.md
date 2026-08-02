# AIS-OS Intake

This is the source-of-truth file for your AIOS. Fill it in by typing, voice-pasting (Wispr Flow / OS dictation), or running `/onboard` for a guided conversation. Whichever mode, this file is what `/onboard` reads to scaffold your Day-1 setup.

**Hard cap: 7 questions.** Each answerable in under 60 seconds. Don't overthink — you can edit and re-run `/onboard` any time.

---

## Q1 — Who are you, what do you sell, who do you sell it to?

Identity, offer, ICP. One paragraph each is fine.

```
IDENTITY — William ("Bill" to clients), Advanced Engineering Systems (AES), www.advengsys.com.
Wears five hats: sales engineer, sales operations, lead generation, project management, client
support. Effectively the whole client-facing surface of AES — the CFO and CEO handle finance.
AES is the
exclusive representative of Kukla (Austrian manufacturer, 90 years in weighing equipment) in
the Americas. We handle sales, consultation, and support. Kukla builds; AES gathers
requirements, manages quoting, coordinates design and delivery, assists with commissioning,
and provides first-level support, escalating to Kukla engineers when needed.

OFFER — High-accuracy, custom-engineered dynamic weighing equipment: weigh feeders, belt
scales, loss-in-weight systems. Every unit is engineered to order around the plant's material,
layout, and process — nothing off-the-shelf. Accuracy ±1% or better. The engagement is
end-to-end: engineering and design, in-house production at Kukla, Factory Acceptance Testing
in Austria, DAP shipping to the plant, commissioning support, recommended spare parts list,
and dedicated after-sales support with AES as the standing point of contact. We do not perform
installations — clients use their own contractor or integrator.

Three-step client on-ramp: (1) share material, feed rate, and accuracy requirements;
(2) send plant layout or equipment diagram; (3) review and approve the final custom design.

ICP — Manufacturing professionals responsible for bulk material handling in gypsum, cement,
mining, and insulation plants running 24/7. Four buying roles: Plant Managers (plant-wide
efficiency, cost), Maintenance Managers (low-maintenance, uptime), Production Managers (stable
feed rates, product quality), Project Engineers (integration and ROI justification).

What they want: consistently accurate feeding, less downtime and maintenance, less material
waste, clean integration into existing lines. What blocks them: distrust of current readings
forcing manual feed-rate adjustment, budget limits and competing priorities, installs that
must land inside scheduled maintenance windows. They delay until the old system becomes
impossible to ignore. Their fears: unplanned downtime costing thousands per hour, rising waste
and operational cost, buying the wrong system and being stuck with it.

Competitors: Coperion, Merrick, Acrison — standardized platforms with limited plant-specific
flexibility. AES differentiates on true custom engineering, ±1% accuracy, wear-resistant
materials for abrasive environments, and hands-on consultative support instead of call centers.

Gaps as of 2026-08-01: no client testimonials yet, no statistics or case studies yet — both
noted as in progress.

Source: Updated_Conversion_Copywriting_Questionnaire.docx
```

---

## Q2 — Paste 1-2 things you've written recently. Don't edit them.

An email, a LinkedIn post, a DM, a doc — anything that sounds like you when you're not trying. **Paste verbatim.** Do not type these mid-conversation with Claude — chat-shaped samples are worse than no samples (voice contamination).

Five sent emails, pasted verbatim. Three to Kukla (supplier), two to clients.

```
[Sample 1 — to Kukla, Patrik Lenzeder, cc Jakob Zopf · "New inquiry: GP – FGWF parts" · Jul 8, 2026]

Hi Patrik!

The client would like to know if Kukla offers see-through panels for the Fiberglass feeder system (like ones below). (FN: 11857)

They also asked if Kukla offers lighting systems on the inside of the feeder to help with visibility. They would like to be able to monitor the belts and fiberglass as it runs, and they think that installing lighting inside will help them do that.

If yes to either of these, kindly create a quote. Please include shipping: DAP – 151 Wahlstrom Rd., Savannah, GA.

Cheers,
William
```

```
[Sample 2 — to Kukla, Roman Wilfinger · "Re: New inquiry – National Gypsum | coating application" · Jul 18, 2026]

Hi Roman!

I have this on my list to follow up again. I am waiting for this client to finalize a PO for a FGWF.

Once it is submitted then I will follow up with him on this project!

Best,
William
```

```
[Sample 3 — to Kukla, Jakob Zopf · "Re: Savannah Kuka Feeder Question / F.N. 11857" · Jul 9, 2026]

Hi Jakob,

I mentioned this to the client, and yes, they are aware of the delivery from two years ago.

They'd still like a quote, and they're going to use that to see what they want to reorder.

Let me know!

Best,
William
```

```
[Sample 4 — to client, Patrick Peterson, Georgia-Pacific Fort Dodge · "Re: Spare parts list for feeder | GP Fort Dodge" · Jul 1, 2026]

Hi Patrick,

Please find attached the operations manual for the feeder. Included is a diagram with the spare parts indicated – see section 12, starting on page 16.

Let me know if any questions!

Best,
Bill
```

```
[Sample 5 — to client, Lee Hunt, Georgia-Pacific, cc GP team + Kukla · "Re: Savannah Kuka Feeder Question / F.N. 11857" · Jul 9, 2026]

Hi Lee,

Below is a full list of the spare parts delivered to Savannah about two years ago. I wanted to check with you that these have been consumed, the electrical ones in this case, before moving forward.

Cheers,
Bill

```

---

## Q3 — What are your 2-3 biggest priorities for the next 90 days?

Quarterly priorities. Not yearly aspirations. Things that, if not done by July, would make you say "I wasted Q2."

Window: 2026-08-01 → 2026-10-31. Rank order confirmed by William 2026-08-01.

```
1. Build an automated lead generation workflow for clients in the U.S. and Canada.
   TOP PRIORITY — everything else comes after. Manual motion already validated: hundreds of
   outreach emails sent by hand. Ready to automate.
2. Close the Georgia-Pacific fiberglass feeder deal for Cumberland City, TN.
3. Redesign the AES website and take ownership of it, away from the consultants who built it.
4. Centralize all files and folders into one location. Largely resolved — see Q6.
```

---

## Q4 — Where does revenue actually land, and where is it tracked?

Multiple answers OK. Stripe? Skool? GoHighLevel? QuickBooks? A spreadsheet?

```
Model: AES invoices the client directly with a markup on the Kukla equipment, then pays Kukla.
Revenue is project-based — equipment sales plus spare parts — not subscription or recurring.

Ownership: the CFO and CEO of AES handle accounts receivable, accounts payable, and all
financial transactions. William does not own the books.

System of record: out of William's reach. The accounting system is CFO/CEO-owned and not
accessible to him. Domain 1 in connections.md is intentionally out of scope — score it as
"not applicable to this operator" in /audit rather than as a gap to close.
```

---

## Q5 — Where do you talk to customers, your team, and the outside world day-to-day?

Email (which one — Gmail / Outlook)? Slack? Teams? DMs (Skool / Discord / iMessage)? Phone?

```
Primary: Outlook. All communication with both Kukla and clients runs through it. This is the
single highest-value connection to wire — the business lives in this inbox.

Secondary: Microsoft Teams for calls and meetings. WhatsApp occasionally, direct to clients
and to Kukla. Phone calls occasionally.

Timezone constraint: Kukla is in Austria (CET). Calls with them happen early morning US time.
Any scheduling logic must respect a narrow morning overlap window.

Calendar (Domain 3, inferred): Outlook Calendar. Confirmed by Outlook + Teams stack.
```

---

## Q6 — Where do meeting recordings, notes, and important docs live?

Granola? Otter? Fireflies? Google Drive? Notion? Dropbox? A folder on your desktop you keep meaning to organize?

```
RESOLVED 2026-08-01 — OneDrive with "Always keep on this device."

Everything lives in OneDrive/SharePoint in the cloud AND syncs to local disk, so the AIOS reads
files directly from the filesystem. No connector, no API, no export pipeline. This closes the
earlier conflict between "move local files into SharePoint" and "move transcripts out to
local" — both are satisfied at once.

Confirmed sync roots on this machine:

  SharePoint document library:
  ~/Library/CloudStorage/OneDrive-SharedLibraries-AdvancedEngineeringSystems/Advanced Engineering Systems - General/
    1. Kukla/ · 1. Kukla Videos/ · 3. MultiExport/ · 4. Conferences & Events/ · AES Legal/
    AES Website/ · NDAs/ · Qubiqa/ · Sales & Marketing/

  Personal work OneDrive:
  ~/Library/CloudStorage/OneDrive-AdvancedEngineeringSystems/
    Recordings/ · Meetings/ · Microsoft Teams Chat Files/ · Attachments/

Meeting intelligence (Domain 6): Teams recordings are kept and already synced locally — five
present as of 2026-08-01, including three fiberglass feeder calls. Caveat: they are .mp4.
Video is not readable as text; a transcript file must sit alongside the recording, or the audio
needs transcribing, before the AIOS can answer on call content.

Remaining work: move any stray folders still outside OneDrive into it. Anything outside is
invisible to the AIOS.
```

---

## Q7 — What's the one task that eats your week, and where do you currently track work?

The single biggest time-suck or recurring drudgery. Plus where tasks/projects live (ClickUp / Asana / Linear / Notion / a notebook).

```
TOP PAIN — Two things eat the week:
  1. Replying to emails. The Kukla ↔ client relay: translating client requirements into
     supplier inquiries, chasing Patrik / Roman / Jakob, relaying answers back.
  2. Generating quotes. Already in motion — William is building a skill to automate quote
     generation. /level-up should scope around this rather than duplicate it.

WORK TRACKING — No dedicated project management tool. Three surfaces instead:
  - HubSpot (CRM): a deal is created for every project. All contacts live here.
  - SharePoint: all projects and documentation.
  - Outlook flags: used as the reminder system for when to reply to clients and Kukla.

Note: Outlook flags are the de-facto task list. Any "what needs my attention" capability has
to read flagged mail, not a task database.
```

---

When this file is filled, run `/onboard` (or re-run it) and the wizard will scaffold your Day-1 file set: `context/`, `references/voice.md`, populated `connections.md`, and a filled `CLAUDE.md`.
