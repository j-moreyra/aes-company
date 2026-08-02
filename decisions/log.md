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
