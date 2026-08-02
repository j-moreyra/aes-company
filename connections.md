# Connections

Registry of every system your AIOS can reach. Filled by `/onboard` from Q4-Q7 answers;
expanded over time as you wire new tools. `/audit` checks this file for domain coverage and
freshness.

| # | Domain | Tool | Mechanism | Auth | Last checked |
|---|---|---|---|---|---|
| 1 | Revenue / Financials | CFO/CEO-owned accounting system (unnamed) | out of scope | — | — |
| 2 | Customer interactions | Outlook, via claude.ai Microsoft 365 connector | `mcp` | OAuth | 2026-08-01 |
| 3 | Calendar | Outlook Calendar, via claude.ai Microsoft 365 connector | `mcp` | OAuth | 2026-08-01 |
| 4 | Communication | Microsoft Teams, via claude.ai Microsoft 365 connector | `mcp` | OAuth | 2026-08-01 |
| 5 | Project / task tracking | HubSpot, via claude.ai HubSpot connector | `mcp` | OAuth | 2026-08-01 |
| 6 | Meeting intelligence | Teams recordings + transcripts, via OneDrive | `local` | OS-level | 2026-08-01 |
| 7 | Knowledge / files | SharePoint library, via OneDrive sync | `local` | OS-level | 2026-08-01 |

**Mechanism options:** `mcp` (MCP server), `script` (Python/Bash hitting an API, in
`scripts/`), `export` (CSV/JSON dump pipeline), `key+ref` (`.env` key +
`references/{tool}-api.md` guide), `local` (synced to disk, read directly),
`not yet connected`, `out of scope`.

## Local paths (Domains 6 + 7)

OneDrive runs with "Always keep on this device," so these are real files on disk, not
placeholders. Quote them — the paths contain spaces.

```
# SharePoint document library
~/Library/CloudStorage/OneDrive-SharedLibraries-AdvancedEngineeringSystems/Advanced Engineering Systems - General/
  ├── 1. Kukla/              ← supplier docs, quotes, technical
  ├── 1. Kukla Videos/
  ├── 3. MultiExport/
  ├── 4. Conferences & Events/
  ├── AES Legal/
  ├── AES Website/           ← priority 3 working files
  ├── NDAs/
  ├── Qubiqa/
  └── Sales & Marketing/     ← priority 1 material

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

**Also connected, worth knowing about.** The claude.ai account carries other connectors,
including **Apollo.io** — a B2B prospecting database directly relevant to the automated lead
generation priority. Also Slack, Google Drive, Gmail, Google Calendar, Figma, Netlify,
Supabase, Asana, monday.com. Most are irrelevant to AES; Apollo.io is not.

**Domain 5 has no real task tool.** Outlook flags are the de-facto task list. Any "what needs
my attention today" capability must read flagged mail plus open HubSpot deals.

**Domains 6 and 7 are live now.** OneDrive with always-keep-local means the AIOS reads these
files directly — no connector needed. The only remaining gap is stray folders that haven't been
moved into OneDrive yet; anything outside it is invisible.

**Timezone constraint.** Kukla is CET. Live calls only work in the early-morning US window.
Any scheduling logic must respect it.
