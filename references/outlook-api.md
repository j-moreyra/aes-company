# Outlook — API reference

How the AIOS reads and writes William's AES mailbox. Researched once so future skills don't
re-derive it.

**Last verified:** 2026-08-09 (Composio connection + tool schemas)
**Registry row:** `connections.md` Domain 2

---

## The split: read one way, write another

| Operation | Route | Why |
|---|---|---|
| Read mail, search, threads | claude.ai **Microsoft 365** connector | Works, no setup |
| Calendar, Teams | claude.ai **Microsoft 365** connector | Works |
| **Any draft, reply, or send** | **Composio** | M365 connector is read-only, see below |

**The M365 connector cannot write to mail.** `outlook_create_draft` and
`outlook_create_reply_draft` both return HTTP 403 `ErrorAccessDenied`. Cause: `Mail.ReadWrite`
is not admin-consented on the app registration for tenant
`bdf7a321-8a7d-4f62-b598-243fbd126b30`. Fixing it needs a tenant admin. Discovered 2026-08-04.

`Mail.Send` is unconsented too: a test send through `outlook_send_mail` returned the same 403
on 2026-08-10. So the M365 connector can neither draft nor send.

Until that consent is granted, **never route a draft through the M365 connector** — it will
fail at the last step after all the drafting work is done. Go to Composio directly.

---

## Composio — accounts

`account_selection` is **required**. Two mailboxes hang off this connection:

| Account id | Alias | Mailbox | Use |
|---|---|---|---|
| `outlook_carper-jat` | `advengsys-william` | William@advengsys.com | **This one.** Default. |
| `outlook_clunk-quirl` | `digitaldawnconsulting` | Joaquin@digitaldawnconsulting.com | Not AES. Never. |

Always pass `outlook_carper-jat` explicitly. Relying on the default being the default is how a
client eventually receives mail from the wrong company.

Verify state any time with `COMPOSIO_MANAGE_CONNECTIONS`, action `list`, toolkit `outlook` —
read-only, no side effects, does not create an auth link. (Action `add` **does** create a new
auth link every time. Don't call it to "check" a connection.)

---

## Tools

Discover with `COMPOSIO_SEARCH_TOOLS`; full schemas via `COMPOSIO_GET_TOOL_SCHEMAS`.

| Tool | Purpose |
|---|---|
| `OUTLOOK_CREATE_DRAFT` | New standalone draft |
| `OUTLOOK_CREATE_DRAFT_REPLY` | Draft reply into an existing thread |
| `OUTLOOK_UPDATE_EMAIL` | Patch an existing draft |
| `OUTLOOK_ADD_MAIL_ATTACHMENT` | Attach a file under 3 MB |
| `OUTLOOK_CREATE_ATTACHMENT_UPLOAD_SESSION` | Chunked upload above 3 MB |
| `OUTLOOK_GET_MESSAGE` | Read back a draft to confirm |
| `OUTLOOK_SEND_DRAFT` | Deliver. Irreversible. |

### `OUTLOOK_CREATE_DRAFT`

Required: `subject` (1–255 chars), `body`.

| Field | Notes |
|---|---|
| `is_html` | Defaults `false`. Set `true` when body contains markup, or tags render literally. |
| `to_recipients` | Array of **plain strings**, not objects. `["a@b.com"]` |
| `cc_recipients` / `bcc_recipients` | Same shape |
| `attachment` | Single file or list |

Recipients may be omitted at creation; `OUTLOOK_SEND_DRAFT` needs at least one across to/cc/bcc.

**The returned body may be a truncated preview.** Treat the returned `message_id` as the source
of truth, not the echoed content.

### `OUTLOOK_CREATE_DRAFT_REPLY` — two-step, and the order matters

Required: `message_id` of the original.

Do **not** try to write the reply body in one call.

1. `OUTLOOK_CREATE_DRAFT_REPLY` first. This builds the quoted thread and the reply headers
   correctly.
2. `OUTLOOK_UPDATE_EMAIL` second, splicing the reply text in **after the opening `<body>` tag**.

Writing the body wholesale destroys the quoted original. On a Kukla ↔ client relay thread the
quoted history is the context both sides rely on — losing it is a visible error.

Note `OUTLOOK_UPDATE_EMAIL` takes a different recipient shape than `CREATE_DRAFT`: objects
(`{address, name}`), not plain strings. And `body` must be `{contentType, content}` with both
keys — omitting `contentType` silently defaults to plain text and HTML renders as literal tags.

### Attachments

- Under ~3 MB (3,145,728 bytes): `OUTLOOK_ADD_MAIL_ATTACHMENT`, accepts a local file path.
- Above: `OUTLOOK_CREATE_ATTACHMENT_UPLOAD_SESSION` with chunked PUTs.
- Invalid base64 gives a 400 `UnableToDeserializePostBody`.

**Attach while building the draft, not afterward.** Draft ids rotate once the draft is opened
and edited in the Outlook UI — an attachment call returned `ErrorItemNotFound` on an id that
had successfully fetched the message a minute earlier. If William has touched a draft,
re-resolve its id before operating on it.

### Sending

`OUTLOOK_SEND_DRAFT` by `message_id`. Success may return `{}` with no payload — **do not
auto-retry**, that is how you double-send. Confirm with a search instead.

Per `CLAUDE.md`, outbound client and Kukla mail gets shown to William as a draft first. Default
to creating the draft and stopping there.

---

## Searching the mailbox

**Never text-search for "Kukla".** The AES signature reads "Exclusive representatives of Kukla
Waagenfabrik GmbH for the Americas", so every message any AES person has ever sent matches. A
test search returned 23 false positives out of 25 hits.

Filter on sender domain `@kukla.co.at` instead.

Known Kukla contacts, all `@kukla.co.at`:

| Address | Name |
|---|---|
| `lenzeder@` | Patrik |
| `zopf@` | Jakob |
| `gruber@` | Karin |
| `fuertbauer@` | Petra |
| `habring@` | Norbert |
| `humer@` | — |

**Relevance search has misled twice.** Free-text search failed to find a Kukla order
confirmation — fifteen irrelevant hits on the quote reference — while searching by sender
across a date range found it immediately. When looking for a specific document, filter by
sender and date range rather than by keyword.

---

## Operational notes

- **Kukla is CET.** Live calls only work in the early-morning US window. Mail sent late US
  afternoon lands next business day for them.
- **Outlook flags are the task list.** There is no task database. "What needs my attention"
  means flagged mail plus open HubSpot deals.
- **Job numbers travel with the thread** (`FN: 11857`). Carry them into replies.
- Voice, greeting, and sign-off rules are in `references/voice.md`. The one that must never be
  wrong: **William** to Kukla, **Bill** to clients.

---

## If it stops working

1. `COMPOSIO_MANAGE_CONNECTIONS` action `list`, toolkit `outlook` — confirm status `active`.
2. A session-start warning that Composio "requires authentication" has been **stale before** —
   it appeared on 2026-08-09 while the connection was in fact fully active. Check with the tool
   before believing the banner.
3. Account-level connection does not guarantee session-level tools. If Composio tools are
   absent from the registry entirely, they have not loaded for the session — say so rather than
   improvising a workaround.
