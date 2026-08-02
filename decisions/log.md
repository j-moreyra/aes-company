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
