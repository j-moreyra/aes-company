# Decisions Log

Append-only record of meaningful decisions and why they were made. `/level-up` Phase 2 (Method interview) writes scoped automation specs here. You can also append manually whenever you decide something worth remembering.

**Format per entry:**

```
## YYYY-MM-DD — Short title

**Decision:** what was decided.

**Why:** the reasoning, constraints, and what would change your mind.

**Alternatives considered:** what else was on the table.

**Owner:** who's accountable.
```

Keep it terse. Future-you will thank present-you for capturing the *why*, not just the *what*.

---

## 2026-08-02 — Missing source documents filed; NG delivery date does not match the client's

William filed the two documents that were missing: Kukla OC `940133` into the Panel Rey folder
and the Gold Bond PO `2500040906` into NG Savannah. Both verified.

**NG Savannah reconciles exactly.** Client PO total $232,270.00 equals the OA, all eight lines
matching. Kukla OC 940624 confirms quotation 260297/05 and assigns **FN 12527**.

**The €14,500 difference between AES's PO (€154,330) and Kukla's OC (€139,830) is not an
error.** Kukla bills commissioning separately — "guiding price - separate invoice", explicitly
excluded from their lump sum — while the AES PO includes it. Their 30% down payment of €41,949
is computed on 139,830. Expect this gap on any order carrying commissioning.

**Open issue — delivery date.** Gold Bond's PO needs the equipment by **30 November 2026**.
Kukla's OC confirms **30 December 2026**, sending 11 November. A 30-day slip against the order.
The NG OA template has no delivery-date field, so nothing AES sent Gold Bond states a date and
their November requirement stands unanswered. Flagged to William.

**Open issue — the address typo reached Kukla.** Kukla's OC lists the delivery address as
"2 Branmpton Road", propagated from the AES PO. The client PO says "2 BRAMPTON RD". Kukla's
shipping paperwork is therefore wrong for a €139,830 machine. Third confirmation of the same
class of error; see the Panel Rey `102218` case.

**New extraction hazard, written into the skill.** Gold Bond's procurement system puts the line
*amount* in the QTY column with a unit price of $1.00 — line 1 reads "QTY 20,685 each @ $1.00".
The real quantity for the cable line (50 m) appears only in the description text. Read
literally, an OA would acknowledge 20,685 pre-bins. The tell is a unit price of exactly 1.00 on
every line.

**Owner:** William.

---

## 2026-08-02 — /order-docs tested against NG Savannah: bundling and price overrides

**Second test case**, chosen because it is structurally harder than Panel Rey:
`01. Gypsum/05. National Gypsum/2. Savannah GA`. Both documents regenerated and match to the
cent — PO €144,600 + €9,730 = €154,330 (equal to Kukla's own quote total), OA $232,270.

**The rule this case established: AES sells bundles, Kukla sells components.** Eight client
lines map to eleven Kukla lines. The pre-bin the client buys is pre-bin + level probe + access
door; the weigh feeder is feeder + compensator; the control cabinet is cabinet + site manager.
The client never sees the split and Kukla must. Getting it wrong means either ordering a machine
without its flexible connection, or paying for something never charged to the client.

**The mapping is not inferred — it already exists** in the CS workbook's `PC-<number>`
profit-comparison tab, with William's own notes naming the bundles. The skill reads that tab.

**Sell prices are not cost × markup.** The comparison tab computes candidates at several
commission rates and William overrides some by hand — the flexible connection computed at
$1,429.88 and sold at $3,075; the site manager computed at $2,183.25 and sold at $1,450. Client
prices come from the client PO or final AES quote; Kukla prices from the Kukla quote. The two
are independent and neither derives from the other.

**Templates differ between projects.** NG's PO tab has item number in column C and quantity in
D; Panel Rey has them reversed. NG uses Kukla's line numbers (110, 115, 130…) with a heading
row; Panel Rey uses 1–5. NG's OA has no subtotal — one total, freight as a line item. A fixed
cell map would have written quantities into the item-number column. The skill now derives the
map from the actual tab each time.

**A second ship-to typo, in a second project.** The PO to Kukla reads `2 Branmpton Road`; the OA
reads `2 Brampton Road`. Kukla shipped a €154k machine against the misspelling. With Panel Rey's
`102218` that is two address errors in two projects — the ship-to block is a systematic weak
point, and the skill now says to take it from the client PO every time rather than copying a
previous document.

**Filing gap again.** The client PO (`2500040906`) is not in the project folder, though the OA
cites it. In Panel Rey it was Kukla's order confirmation that was missing. Both times the
document authorising the commitment was not stored beside it.

**Owner:** William.

---

## 2026-08-02 — Order document sequence corrected; /order-docs skill built

**Decision:** One skill, `/order-docs`, covers both the PO to Kukla and the client Order
Acknowledgement. Not two.

**Why one.** Both documents describe the same goods — priced at cost going to Kukla, at sell
going to the client. Run as separate skills, nothing prevents ordering one unit from Kukla
while acknowledging four to the client. Run together, the quantities are checked against each
other. The item-matching across four documents is the hard part and would otherwise be
duplicated and drift.

**Sequence corrected by William mid-build.** The original assumption was OA first, then the PO
to Kukla. Wrong. The real order is:

    client PO → AES PO to Kukla → Kukla order confirmation → AES OA to client

The client OA cannot be produced until Kukla confirms, because the delivery date AES commits to
in writing is Kukla's confirmed date. The skill now refuses to produce an OA without it.

**Two rules that were wrong in the first draft, both caught by building against the reference
case rather than reasoning about it:**

1. *Quantities never come from the Kukla quote.* Kukla quoted 1 × DWC-7B; the client ordered 4;
   the PO was raised for 4 and Kukla confirmed 4. The quote governs part numbers, descriptions
   and unit prices only. The first draft said "line for line" and would have under-ordered three
   units on a €21,780 line.
2. *Currency flips between the documents.* The PO to Kukla is EUR because Kukla quotes in euro;
   the client OA is USD. The renderer had hardcoded `$`.

**Verification.** Both documents were regenerated from source and match the originals to the
cent — PO to Kukla €28,899.00, OA $52,735.00 — and Kukla's OC 940133 independently confirms the
same €28,899.00 and the 09.04.2026 delivery date that became the OA's "9-Apr".

**A real error found in a document already sent.** The OA to Panel Rey gives the delivery
address as `102218 Crossroads Loop`. Three independent sources — the client PO, the Kukla quote
thread, and William's own 2025-07-25 email — say `CROSSROADS LOOP 10218`. A transposed digit in
the ship-to address for a $52k shipment. Unresolved; flagged to William.

**Filing gap.** Kukla's order confirmation was never saved to the project folder; it was found
in Outlook. Under the corrected sequence it is a required input, so it has to be filed as a
matter of course.

**Method notes.** PDF rendering goes through headless Chrome, not Excel — Excel automation
needs macOS Automation permission and hangs without it. And free-text Outlook search failed to
find the order confirmation (fifteen irrelevant hits on the quote reference); searching by
sender across a date range found it immediately. Second time this mailbox's relevance search
has misled — see the Kukla signature problem in `connections.md`.

**Owner:** William.

---

## 2026-08-02 — Correction: the library has 67 transcripts, and it was restructured

**Correction to an earlier entry.** `connections.md` originally recorded Domain 6 as weak,
on the reasoning that recordings are `.mp4` and no transcripts sat alongside them. Wrong. The
library holds **67 transcripts**, filed inside project folders rather than next to the
recordings — which is why looking in `Recordings/` found nothing. Every Teams recording has a
same-date transcript under its client folder. Both `connections.md` and `CLAUDE.md` now say so.

**Why it matters.** 67 recorded conversations with plant engineers about clinker and gypsum
weighing is the strongest evidence available of what prospects actually say — better than any
inference from email. That is priority-#1 material and it was sitting unrecognised.

**Two transcripts were genuinely missing** from `~/Downloads/Transcripts` and are now filed:
`Transcript_Clinker_Cementos Sur_04012025.txt` beside its recording in
`02. Cement/08. Cementos Sur`, and `Transcript_Gyplac_Multiex preso_20250513.docx` under
`01. Gypsum/03. ETEX/2. Colombia (Gyplac)`. The Gyplac one is a MultiExport presentation to an
ETEX client, so it could equally live under `5. MultiExport`; it was filed by client because
that is where the rest of the Gyplac material is. Move it if the product line matters more.

Of the other 35 local transcripts, all were already present. **Byte comparison was misleading:**
33 same-name pairs looked different by hash, but 31 had identical text — `.docx` files change
bytes on every re-save. Only two differ in text, by 1-2%, which reads as a re-run of the
transcription rather than a different meeting. **Compare extracted text, not hashes, for Office
files.**

**Library restructured (by William, mid-session).** `02. Presentations` was promoted out of
`1. Kukla` to the root as `4. Kukla Presentations`; `3. Kukla Images` was added; MultiExport and
Conferences shifted to `5.` and `6.`. Docs updated. Note this means the presentations filed
earlier today and `16. Process Maps` now sit in different top-level trees.

**Owner:** William.

---

## 2026-08-02 — Library content refreshed: brochures and presentations

**Decision:** Where a local copy was newer than the library copy, the library copy loses. Old
versions go to Trash tagged `[superseded <date>]` rather than being unlinked.

**Brochures.** All 36 PDFs in `~/Downloads/AES Brochures` existed in `1. Kukla/05. Brochures`
by name. 26 were byte-identical; **10 differed, and in every case the local copy was newer** —
by up to twelve months. The library was the stale side. Those 10 were promoted. Worth stating
plainly: until this ran, anyone pulling the fiberglass or gypsum brochure off OneDrive was
sending clients a version six months out of date, while GP and National Gypsum were actively
buying fiberglass.

**Presentations.** All 16 files in `~/Downloads/Process Maps_Presentations` were absent from
`02. Presentations` or newer than what was there — nothing was redundant. 13 added, 3 replaced.
Roughly 1.7 GB, eleven files over 200 MB. The English master decks
(`Bulk Weighing Systems_Cement_AES`, `..._Gypsum_AES`, `Fiberglass Feeder_AES`) had no library
equivalent at all — the library held Spanish and Portuguese cement decks but no English one.

**Process maps.** `Cement/Gypsum/Insulation Process-AES.pdf` are process diagrams, not
presentations, and now live in a new `16. Process Maps`.

**Known-stale, deliberately not touched.** `Sistemas de Pesagem_Cimento_AES.pdf` and
`Sistemas de Pesaje - Cemento - AES.pdf` (Aug 2025) are PDF exports of decks that were just
replaced with Feb 2026 versions. Different filenames, so out of scope for "delete old ones" —
but they are now stale exports of current decks. Same trap as the brochures. Re-export or
retire them.

**Also unresolved.** Probable predecessors of the new master decks remain in place:
`Cement Presentation_Kukla.pptx` (Jul 2024), `Presentations - Norbert/Gypsum_Presentation.pptx`
(Oct 2024, 173 MB), and the older fiberglass decks. Metadata cannot say whether these are
superseded or complementary — that needs someone who knows the content. Retiring them would
reclaim several hundred MB.

**Lesson worth generalising.** Twice now the shared library has been the *older* copy while the
current version sat in Downloads. The failure mode is not "files are scattered", it is "the
authoritative copy is not the one people fetch". Any future filing pass should compare dates
before assuming the library is right.

**Owner:** William.

---

## 2026-08-02 — Downloads filed into OneDrive; Kukla folders renumbered

**Decision:** Clear the Downloads scatter into the SharePoint library, and zero-pad the
numbered folders inside `1. Kukla` so they sort correctly.

**What was done.** 83 files moved into the library, 21 byte-identical duplicates deleted after
MD5 verification, 9 new folders created (ROI tools, interactive viewers, application notes,
rates, third-party equipment, material testing; plus Lead Lists, Outreach Templates and CRM
Imports under Sales & Marketing). `AES-Kukla-Master-Reference.md` moved into this repo's
`context/`. Downloads went from 155 files to 58.

**Rules applied.** Nothing under 20 days old was touched. Deletions only where a hash matched a
copy already in the library, and they went to Trash rather than being unlinked. No file was
overwritten — a name collision at the destination caused a skip.

**Renumbering.** `1.`–`9.` became `01.`–`09.` inside `1. Kukla`, so the folders added this week
(`10.`–`16.`) sort after `09.` instead of after `01.`. Same treatment for the four category
folders in `01. Projects`, for `Sample Drawings/01. Mass Flow`, and for the ten project folders
under `01. Gypsum/08. Panel Rey/1. Monterrey MX` (triggered by `10. PR - Load cells 2026`
sorting above `2. PR - Line 1 LIW`). The library-root folders (`1. Kukla`, `2. Kukla Videos`,
`3. MultiExport`, `4. Conferences & Events`) were left alone.

A sweep of the entire library on 2026-08-02 confirmed no remaining folder group mixes unpadded
single digits with double digits. **Convention going forward:** pad any new numbered folder, and
pad a group's existing members as soon as it reaches ten.

**Cost:** renames propagate to SharePoint, so any direct links or bookmarks colleagues held to
these folder paths will break. Accepted knowingly.

**Two judgement calls worth remembering.** For `Calibration Report - Kettle Feeder.pdf`,
William chose to keep the copy with a blank Customer field over the one naming Volcan Santiago
de Chile, and the library copy was deleted to make room. For `11993_Commissioning Report`, the
stated rule didn't discriminate — both copies contained the calibration table — so the more
complete library copy was kept.

**Owner:** William.

---

## 2026-08-01 — Git remotes: origin is private, upstream is never written to

**Decision:** `origin` is `j-moreyra/aes-company` (private, William's). `upstream` is
`nateherkai/AIS-OS`, the original starter kit.

**Standing instruction: never push to, or otherwise write to, the nateherkai repo.** Its push
URL is disabled (`git remote set-url --push upstream no_push`) so an accidental
`git push upstream` fails immediately rather than prompting for credentials.

**Why:** this repo now holds AES client names, deal status, contact details, and internal
positioning. It must never reach a repo William doesn't control. `upstream` is retained for
one purpose only — pulling future improvements to the kit — and even that is optional.

**Owner:** William.

---

## 2026-08-01 — Use the existing claude.ai connectors for HubSpot and Outlook

**Decision:** Don't build or install anything for HubSpot or Outlook. Both are already
connected as claude.ai account-level MCP connectors (`claude.ai HubSpot`, `claude.ai
Microsoft 365`), both OAuth-authenticated and reporting connected.

**Why:** No tokens on disk, no app registration, no secret to rotate or leak. William holds
HubSpot super admin and Microsoft 365 / Entra admin, so the self-hosted routes were open — they
just aren't needed. The friction I expected around tenant admin consent for `Mail.Read` turned
out to be moot.

**What was tried and rejected:** adding HubSpot's remote MCP server manually via
`claude mcp add hubspot --transport http https://mcp.hubspot.com`. It registered but failed to
connect — the working endpoint is `https://mcp.hubspot.com/anthropic`, which the claude.ai
connector already uses. The duplicate was removed. Don't repeat this.

**Open item:** account-level connection did not translate into callable tools in the session
where this was decided. Neither connector's tools appeared in the registry. Needs verification
after a Claude Code restart before either domain can be called live.

**Owner:** William.

---

## 2026-08-01 — OneDrive with always-keep-local is the file strategy

**Decision:** Standardize on OneDrive, with "Always keep on this device" enabled so files sync
to local disk. The AIOS reads them directly from the filesystem — no connector, no API, no
export pipeline.

Confirmed sync roots:

- SharePoint document library —
  `~/Library/CloudStorage/OneDrive-SharedLibraries-AdvancedEngineeringSystems/Advanced Engineering Systems - General/`
  (contains `1. Kukla/`, `Sales & Marketing/`, `AES Website/`, `NDAs/`, `Qubiqa/`, and more)
- Personal work OneDrive — `~/Library/CloudStorage/OneDrive-AdvancedEngineeringSystems/`
  (contains `Recordings/`, `Meetings/`, `Microsoft Teams Chat Files/`, `Attachments/`)

**Why:** It resolves the SharePoint-vs-local conflict without picking a side. Files stay
centralized and shared in the cloud, and are simultaneously present on disk where the AIOS can
read them. Domain 7 (knowledge/files) and Domain 6 (meeting intelligence) become reachable
immediately instead of waiting on a Day-2 connector build.

**What would change my mind:** disk pressure from pinning large video folders, or files that
must not exist unencrypted on a laptop. Recordings are the likely first casualty — they're
video and they add up.

**Alternatives considered:** SharePoint Graph API connector (more work, more auth, no benefit
while the files are already local). Moving Teams transcripts out to a local-only folder
(rejected — recreates the scatter that priority "centralize files" exists to fix).

**Owner:** William.

---

## 2026-08-01 — Lead generation is priority #1

**Decision:** Reorder the 90-day priorities. Automated lead generation for U.S. and Canada
moves to #1; everything else follows.

**Why:** William has already sent hundreds of manual outreach emails. The manual motion is
validated by experience, not assumption, which is the precondition the Machine framework asks
for before automating anything. Closing the GP Cumberland City deal remains live revenue but is
a single deal in flight; lead gen compounds across the quarter and feeds every deal after it.

**Alternatives considered:** Keeping the GP Cumberland City deal at #1 (original stated order).
Rejected — one deal in progress vs. a system that produces deals.

**Prior concern, resolved:** I had pushed back that automating outreach before validating it
manually risks scaling a motion that doesn't land. That objection is answered by the hundreds
of manual sends already behind him. Recorded here so the reasoning isn't relitigated later.

**Open question for `/level-up`:** what the manual sends actually taught — which subject lines
opened, which of the four buying roles replied, what killed the dead ones. That's the input
that makes the automated version better than a volume increase. Worth capturing before
building.

**Owner:** William.

---
