# Connections

Registry of every system your AIOS can reach. Filled by `/onboard` from Q4-Q7 answers;
expanded over time as you wire new tools. `/audit` checks this file for domain coverage and
freshness.

| # | Domain | Tool | Mechanism | Auth | Last checked |
|---|---|---|---|---|---|
| 1 | Revenue / Financials | CFO/CEO-owned accounting system (unnamed) | out of scope | — | — |
| 2 | Customer interactions | Outlook — **read** via claude.ai Microsoft 365 connector, **write** via Composio | `mcp` | OAuth | 2026-08-10 |
| 3 | Calendar | Outlook Calendar, via claude.ai Microsoft 365 connector | `mcp` | OAuth | 2026-08-01 |
| 4 | Communication | Microsoft Teams, via claude.ai Microsoft 365 connector | `mcp` | OAuth | 2026-08-01 |
| 5 | Project / task tracking | HubSpot, via claude.ai HubSpot connector | `mcp` | OAuth | 2026-08-01 |
| 6 | Meeting intelligence | Teams recordings + transcripts. OneDrive on the Mac, or `sharepoint_search` from anywhere | `local` + `mcp` | OS-level / OAuth | 2026-08-10 |
| 7 | Knowledge / files | SharePoint library. OneDrive sync on the Mac, or `sharepoint_search` from anywhere | `local` + `mcp` | OS-level / OAuth | 2026-08-10 |

**Mechanism options:** `mcp` (MCP server), `script` (Python/Bash hitting an API, in
`scripts/`), `export` (CSV/JSON dump pipeline), `key+ref` (`.env` key +
`references/{tool}-api.md` guide), `local` (synced to disk, read directly),
`not yet connected`, `out of scope`.

## Local paths (Domains 6 + 7)

**These paths only exist on William's Mac.** A session running anywhere else, Claude Code on the
web, a cloud container, another machine, sees none of them. Verified 2026-08-10: `$HOME` was
`/root` and `~/Library/CloudStorage/` did not exist. Domains 6 and 7 dropped out with no error,
which is the dangerous part. Use the SharePoint MCP fallback below whenever the paths are absent.

On the Mac, OneDrive runs with "Always keep on this device," so these are real files on disk, not
placeholders. Quote them — the paths contain spaces.

```
# SharePoint document library
~/Library/CloudStorage/OneDrive-SharedLibraries-AdvancedEngineeringSystems/Advanced Engineering Systems - General/
  ├── 1. Kukla/              ← supplier docs, quotes, technical (see tree below)
  ├── 2. Kukla Videos/
  ├── 3. Kukla Images/
  ├── 4. Kukla Presentations/ ← decks; promoted out of 1. Kukla 2026-08-02
  ├── 5. MultiExport/        ← the other represented lines (MAC, Finna, LIMAB, Vibra Screw…)
  ├── 6. Conferences & Events/
  ├── AES Legal/
  ├── AES Website/           ← priority 3 working files
  ├── CHRISTIAN WEDDING/
  ├── Lisa's Folder/
  ├── NDAs/
  ├── Qubiqa/                ← the non-Kukla product line (dunnage, bag closing)
  └── Sales & Marketing/     ← priority 1 material
        ├── Lead Lists/            (added 2026-08-02)
        ├── Outreach Templates/    (added 2026-08-02)
        ├── CRM Imports/           (added 2026-08-02)
        ├── LinkedIn/
        ├── MINExpo/
        ├── Social Media/
        ├── Consultants/
        └── Cold Calling Guides-Giulio Segantini/

# Inside 1. Kukla — renumbered 2026-08-02 so 01-16 sort correctly
  ├── 01. Projects/          ← 01. Gypsum · 02. Cement · 03. Mining & Raw Materials
  │                             04. Third-party Vendors
  │                          (02. Presentations was moved out to the library root as
  │                           "4. Kukla Presentations" — no 02. inside 1. Kukla now)
  ├── 03. Quote Templates/   ├── 04. Product Pictures/
  ├── 05. Brochures/         ├── 06. Data Sheets/       ├── 07. Logos/
  ├── 08. Marketing Material/├── 09. MFG Diagrams/
  ├── 10. ROI & Business Case Tools/     (added 2026-08-02)
  ├── 11. Interactive Viewers & Demos/   (added 2026-08-02)
  ├── 12. Application Notes/             (added 2026-08-02)
  ├── 13. Rates & Commercial Terms/      (added 2026-08-02)
  ├── 14. Third-Party Equipment/         (added 2026-08-02)
  ├── 15. Material Testing/              (added 2026-08-02)
  ├── 16. Process Maps/                  (added 2026-08-02)
  ├── Instructions, Guides & Manuals/    ├── NDAs/        ├── Recordings/
  ├── Reference Lists/       ├── Sales/  └── Sample Drawings/ (01. Mass Flow, D-DW-1,
                                            D-DW-2, Stucco feeder, Train Loading, V-DG-1)
```

**Numbering convention.** Numbered folders are zero-padded (`01.`, `02.` … `16.`) so they sort
correctly once a group passes nine. Applied 2026-08-02 to `1. Kukla`, to the category folders
in `01. Projects`, to `Sample Drawings`, and to the ten project folders under
`01. Gypsum/08. Panel Rey/1. Monterrey MX`. A sweep of the whole library on that date found no
remaining group that mis-sorts. Pad any new folder you create, and pad a group's existing
members the moment it reaches ten.

```
# (tree continues)

# Personal work OneDrive
~/Library/CloudStorage/OneDrive-AdvancedEngineeringSystems/
  ├── Recordings/            ← Teams meeting recordings (.mp4)
  ├── Meetings/
  ├── Microsoft Teams Chat Files/
  └── Attachments/
```

Caveat: recordings are `.mp4`. Video isn't readable as text — a transcript file has to exist
alongside it, or the audio needs transcribing, before the AIOS can answer questions about what
was said in a call.

## Reaching domains 6 and 7 off the Mac

The same library is reachable from any session through the claude.ai Microsoft 365 connector, with
no local sync at all. Verified working 2026-08-10 from a Linux container that had no OneDrive.

**The chain is two steps.** `sharepoint_search` returns metadata plus a `uri`. Feed that `uri` to
`read_resource` for the full text.

- `sharepoint_search` — full text across content, filename and metadata. Filters: `folderName`,
  `fileType`, `author`, `afterDateTime`, `beforeDateTime`. Max 50 per page. Paginate by passing
  the `nextOffset` from the last result back in as `offset`.
- `sharepoint_folder_search` — finds folders by name, returns a `uri` you can list.
- `read_resource` — takes `file:///{driveId}/{itemId}`, returns the document text.

**Path mapping.** The local folder and the SharePoint URL are the same place:

```
~/…/Advanced Engineering Systems - General/1. Kukla/01. Projects/
https://advengsys.sharepoint.com/sites/AdvancedEngineeringSystems/Shared Documents/General/1. Kukla/01. Projects/
```

**Two drives, not one.** The shared library and William's personal OneDrive are separate
`driveId`s. The `.mp4` recordings live on the personal one, at `advengsys-my.sharepoint.com`.

- Shared library: `b!R54LztMBcEyiZM0ttse0oj-yj2nRhS9Dsp1rgpdJ69tyZsbVfpYRRZGA_DUEmzEO`
- Personal OneDrive: `b!CdR1frezz02KNg1pBRdzTnWb3WmoNd5Ak5JAuYyCsDWdllM8qASbSLPEEevvtkAW`

**Gotchas, all verified 2026-08-10.**

- **A transcript is too big for one read.** One 43-minute call came back at 81,379 characters and
  blew the token limit. `read_resource` writes the overflow to a file and returns the path. Read
  it in chunks, or hand it to a subagent, rather than pulling it into the main thread.
- **Result totals are hits, not files.** Searching `Transcript` reported
  `totalResultCount: 106`, not the 67 transcripts on record. Teams transcripts contain the phrase
  "started transcription", so content matches inflate the number. Never quote the total as a file
  count.
- **`sharepoint_folder_search` matches ancestor paths too.** Searching `Kukla` returned `Finna`,
  `OMNIR` and `Smart III RF`, which only match because they sit under `3. Kukla Images/`. It
  claimed 4,336 results. Filter on `webUrl` yourself.
- The `Transcript_*` filename inconsistency described below still applies. Match on content.

When you wire a new tool, also save `references/{tool}-api.md` capturing endpoints, auth flow,
and common queries — researched-once-saved-forever.

## Notes on this stack

**Domain 1 is deliberately out of scope.** The accounting system is CFO/CEO-owned and William
has no access. `/audit` should score it as not-applicable, not as a gap to close.

**Domain 2 is the whole business.** Outlook carries every client and Kukla conversation. It has
more leverage than the other six combined.

**MCP connectors — status as of 2026-08-01.** Both were already connected at the claude.ai
account level before this repo existed. `claude mcp list` reports:

```
claude.ai HubSpot        https://mcp.hubspot.com/anthropic        ✔ Connected
claude.ai Microsoft 365  https://microsoft365.mcp.claude.com/mcp  ✔ Connected
```

Caveat: connected at the account level does **not** mean callable in every session. In the
session where this was written, neither connector's tools appeared in the tool registry.
Verify after a restart by asking for a HubSpot deal or a recent Outlook message — if the tools
aren't there, the connectors need re-enabling for this project.

Do not add a second HubSpot MCP server manually. It was tried (`claude mcp add hubspot
--transport http https://mcp.hubspot.com`) and failed to connect — the working endpoint is the
`/anthropic` path already used by the claude.ai connector. Duplicate entry was removed.

**Verified live 2026-08-01.** Both connectors returned real data — HubSpot deals and Outlook
mail. Domains 2-5 are working, not just registered.

**Outlook writes go through Composio, not the Microsoft 365 connector.** Discovered 2026-08-04.
The claude.ai Microsoft 365 connector reads the mailbox fine but cannot write to it —
`outlook_create_draft` and `outlook_create_reply_draft` both return HTTP 403 `ErrorAccessDenied`
because `Mail.ReadWrite` is not admin-consented on the app registration (tenant
`bdf7a321-8a7d-4f62-b598-243fbd126b30`). Fixing that needs a tenant admin. Until then, use
**Composio** for any draft, reply, or send.

**`Mail.Send` is unconsented too, not just `Mail.ReadWrite`.** Confirmed 2026-08-10 by a test send
through `outlook_send_mail`, which returned the same 403. So the Microsoft 365 connector cannot
draft **and** cannot send. Getting a tenant admin to consent both scopes is still worth doing, but
it is **not a blocker for anything**, because Composio already sends. Do not report Outlook mail as
un-writable on the strength of an M365 403 alone; check Composio first.

Composio's Outlook connection has write scope and is verified working. Connection state confirmed
2026-08-10: `outlook` toolkit **ACTIVE**, `OUTLOOK_SEND_EMAIL` available. Always pass account
`outlook_carper-jat` explicitly — a second, non-AES mailbox hangs off the same connection.

**Full detail is now in `references/outlook-api.md`** — accounts, the two-step reply-draft
procedure, attachment thresholds, draft-id rotation, the Kukla search trap and contact list.
Read that before writing any mail-handling skill.

**HubSpot detail is in `references/hubspot-api.md`.** The headline: AES renamed the pipeline
stages but kept HubSpot's internal values, so `contractsent` means "Development" and
`appointmentscheduled` means "Discovery" — reasoning from the internal name gets it wrong.

Known Kukla contacts, all `@kukla.co.at`. **Use these names; never infer a first name from an
address.** A morning brief run on 2026-08-11 rendered `zopf@` as "Sabrina Zopf", which is wrong,
and a wrong first name on a real contact is worse than no first name at all. If an address is not
on this list, use the surname alone or the address itself.

| Address | Name | Address | Name |
|---|---|---|---|
| `lenzeder@` | Patrik Lenzeder | `zopf@` | Jakob Zopf |
| `humer@` | Nico Humer | `gruber@` | Karin Gruber |
| `fuertbauer@` | Petra Fuertbauer | `habring@` | Norbert Habring |
| `avdibegovic@` | Armin Avdibegovic | `m.leitner@` | Michael Leitner |
| `meingast@` | surname only, first name unconfirmed | | |

**HubSpot data-quality gap — remeasured 2026-08-09.** 150 deals. 117 (78%) sit in Discovery
and only four have ever reached a terminal stage (2 Delivered, 2 Closed Lost) since January
2024, though AES has demonstrably delivered more than two projects in that window. `amount` is
populated on 11 of 150 (7%); `closedate` on 131 (87%). So deals are created and then not
stage-advanced. Neither pipeline value nor conversion rate is computable. An earlier version of
this note said `closedate` was also empty — that was wrong.

A second pipeline, **Lead Gen** (`76343440`), exists and is completely empty, with HubSpot's
default stage names untouched. It is the obvious destination for priority #1 and is still a
blank slate.

**The lead-gen workflow needs a success metric the CRM can actually answer.** Today it cannot
answer "did outreach produce revenue". Decide the metric before building.

**Apollo.io needs re-authorization.** As of 2026-08-09 its token is expired — a live call
returned `requires re-authorization (token expired)`, not a stale session banner. Until it is
reconnected in claude.ai connector settings, Apollo is unreachable and no reference guide can
be written for it. This is priority-#1 infrastructure, so it is the first thing to fix.

**HubSpot SQL is scope-blocked.** `query_crm_data` returns `insufficient_scope` — the connector
needs re-authorizing with the **"Query portal data"** option checked. Until then all counts go
through `search_crm_objects` one filter at a time. Details in `references/hubspot-api.md`.

**Also connected, worth knowing about.** The claude.ai account carries other connectors,
including **Apollo.io** — a B2B prospecting database directly relevant to the automated lead
generation priority. Also **Composio**, which is what makes Outlook writable (see above) and
which fronts 500+ other apps. Also Slack, Google Drive, Gmail, Google Calendar, Figma, Netlify,
Supabase, Asana, monday.com. Most are irrelevant to AES; Apollo.io and Composio are not.

**Domain 5 has no real task tool.** Outlook flags are the de-facto task list. Any "what needs
my attention today" capability must read flagged mail plus open HubSpot deals.

**Domains 6 and 7 are live now.** On the Mac, OneDrive with always-keep-local means the AIOS reads
these files directly. Everywhere else, go through `sharepoint_search` (see above). "No connector
needed" was only ever true of the Mac, and reading it as a general statement is exactly what made
the AIOS go half-blind in a remote session. The only remaining gap is stray folders that haven't
been moved into OneDrive yet; anything outside it is invisible either way.

**Domain 6 is much stronger than first recorded.** An earlier version of this file warned that
recordings are `.mp4` and unusable without a transcript sitting alongside. That was wrong. The
library is full of transcripts, almost all `.docx`, filed in **project folders, not next to the
recordings**, which is why a search of `Recordings/` finds nothing. Every Teams recording in the
personal OneDrive has a same-date transcript filed under its client.

**Full map: `references/transcript-index.md`.** Every transcript by client, plant and date, plus
the commands to regenerate it. Go there before any exercise that needs the whole corpus.

Coverage is deepest on cement: Brazil, Holcim across five countries, plus Cemex, Ash Grove,
Titan, Loma Negra, Pacasmayo, GCC, Argos, UNACEM and Amrize. Readable text on disk, and the best
available evidence of what prospects actually say. Directly relevant to priority #1.

**Corrections made 2026-08-10, after this file's own numbers were checked:**

- **The "67 transcripts" figure was a filename-based count and was low.** So was the
  "57+ / 5 / 3" split by area. Do not quote either.
- **There is a `00. Brazil` country folder** at
  `1. Kukla/01. Projects/02. Cement/00. Brazil/`, holding roughly **30 transcripts**, the single
  largest block. It has its own numbered client folders, 1 to 8, and runs one level deeper than
  the rest of the library: country → client → plant → contact → project. The earlier survey
  missed it entirely, so about a third of the corpus was invisible.
- **Search totals are estimates and contradict each other.** The same content query reported 91,
  then 53, then 41 as pagination went deeper. Graph trims on deep pages. Enumerate and count what
  you get; never quote a total.

Caveats when using them: a few are duplicated across folders (CEMEX clinker scale, COBOCE), one
is prefixed `NOTTA ` from a different transcription tool, and Panel Rey has both an original and
a `Transcript-English_` version of the same call.

**Filenames are worse than "inconsistent", and a `Transcript` name search silently misses files.**
Four confirmed failure modes: the typo `Transript_` (CEMEX Knoxville, Holcim Argentina), hyphens
instead of underscores (`Transcript-Holcim-ARG-…`), the same meeting named two ways
(`Transcript_Holcim_Veracruz_10142025` vs `Transcript_Holcim Veracruz_Clinker-20251014`), and
files with no transcript-like word at all (`Equipo Kukla - Reunión de planificación.docx` under
SOBOCE, `USG_Dunnage overview_04112025.docx` under Qubiqa).

**So search by content, not by name.** Teams transcripts all contain the phrase
`started transcription`. That one query finds them regardless of what the file is called, and it
is what surfaced Brazil. Match on content, not filename.

**Timezone constraint.** Kukla is CET. Live calls only work in the early-morning US window.
Any scheduling logic must respect it.
