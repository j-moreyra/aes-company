# HubSpot — API reference

How the AIOS reads the AES CRM, what the fields actually mean, and where the data is thin.

**Last verified:** 2026-08-09 (live probe)
**Registry row:** `connections.md` Domain 5 (and Domain 2, contacts)
**Portal:** `44554091` — record URLs are
`https://app.hubspot.com/contacts/44554091/record/0-3/{dealId}` for deals

---

## Access

Via the **claude.ai HubSpot connector**, endpoint `https://mcp.hubspot.com/anthropic`.

Do **not** add a second HubSpot MCP server. It was tried
(`claude mcp add hubspot --transport http https://mcp.hubspot.com`) and failed — the bare host
does not work, the `/anthropic` path does, and the connector already uses it. See
`decisions/log.md` 2026-08-01.

### Scope gap — SQL is blocked

`query_crm_data` (SQL) returns `insufficient_scope`:

```
Missing required scope: reporting-base-read.
Please re-authorize this connector and select the "Query portal data" option.
```

Until someone re-authorizes the connector with **"Query portal data"** checked, all aggregation
must go through `search_crm_objects` and its `total` field, one filtered call per bucket. That
works but costs a call per count — a six-stage breakdown is six calls.

Worth fixing: it turns six calls into one `GROUP BY`.

---

## Tools that work today

| Tool | Use |
|---|---|
| `discover_hubspot_schema` | List object types + access level. `GET_OBJECT_TYPES` with empty filter for all. |
| `get_properties` | **Enum values.** Essential — see the stage-name trap below. |
| `search_crm_objects` | Records + `total` count. The aggregation workaround. |
| `search_properties` | Find internal property names |
| `search_owners` | Resolve `hubspot_owner_id` |
| `manage_crm_objects` | Write. Available for CONTACT, COMPANY, DEAL. |

Readable and writable: CONTACT, COMPANY, DEAL, CALL, EMAIL, NOTE, MEETING_EVENT, LINE_ITEM,
PRODUCT.
Read-only: QUOTE, INVOICE, OBJECT_LIST.
Not available: CONTRACT, ORDER, COMMERCE_PAYMENT, PAYMENT_LINK.

---

## The stage-name trap — read this before writing any deal query

AES **renamed the default pipeline stages but kept HubSpot's internal values**. The internal
value does not mean what it says:

| Internal value | What AES calls it | What the name suggests |
|---|---|---|
| `appointmentscheduled` | **Discovery** | a booked meeting |
| `presentationscheduled` | **Quote Sent** | a booked presentation |
| `decisionmakerboughtin` | **PO Submitted** | verbal commitment |
| `contractsent` | **Development** | a contract out for signature |
| `closedwon` | **Delivered** | won |
| `closedlost` | Closed Lost | lost |

Reasoning from the internal name gets the business meaning wrong every time. `contractsent`
is equipment being built, not paperwork awaiting signature. Always call `get_properties` for
`dealstage` rather than assuming, and always report the **label**, never the raw value.

## Pipelines

| Id | Name | Deals |
|---|---|---|
| `default` | Projects Pipeline | **150** |
| `76343440` | **Lead Gen** | **0** |

The Lead Gen pipeline exists and is **completely empty**. Its stages are still HubSpot's
untouched defaults (`145758356`–`145758362`, "Appointment scheduled" … "Closed lost"), so it
has been created but never configured or used. It is the natural destination for priority #1
output, and it is a blank slate — stage names should be decided before anything writes to it.

---

## Data quality — measured 2026-08-09

150 deals. Distribution across the Projects Pipeline:

| Stage (label) | Deals | Share |
|---|---|---|
| Discovery | 117 | 78% |
| Quote Sent | 25 | 17% |
| PO Submitted | 1 | <1% |
| Development | 3 | 2% |
| Delivered | 2 | 1% |
| Closed Lost | 2 | 1% |

Field population:

| Property | Populated | Share |
|---|---|---|
| `closedate` | 131 / 150 | 87% |
| `amount` | **11 / 150** | **7%** |

**What this means, stated plainly.** Only four deals in the entire CRM have ever reached a
terminal stage — two Delivered, two Closed Lost — across records going back to January 2024.
Meanwhile AES has demonstrably delivered more than two projects in that window (Panel Rey and
NG Savannah both shipped). **Deals are created and then not stage-advanced.** The pipeline is
functioning as a list of opportunities, not as a progression tracker.

Consequences:

- **Conversion rate is not computable.** A 2-won / 2-lost sample out of 150 is not a rate.
- **Pipeline value is not computable.** `amount` is empty on 93% of deals.
- **Stage age means nothing.** A deal sitting in Discovery may be dead, delivered, or live.

This corrects an earlier note in `connections.md` that said the recent deals had neither
`amount` nor `closedate`. `closedate` is actually well populated at 87%; `amount` is the real
hole, and stage progression is a bigger one than either.

**Before the lead-gen workflow can prove it works**, it needs a metric the CRM can actually
answer. Right now it cannot answer "did outreach produce revenue". Either `amount` gets
populated and stages get advanced, or success has to be measured on something else — replies,
meetings booked, quotes sent — with the measurement defined up front.

---

## Naming conventions

Deals use a client-prefix shorthand, not full names:

```
ROM - LIW BMA feeder          GP - FGWF Cabinet upgrades
GYP - FGWF                    PET - Stucco feeder
VOL - FGWF, WF, LIW           CAL - Cement feeders
PR - Level probe spare        GYP - Stucco spares
```

Prefix is an abbreviated client (`GP` Georgia-Pacific, `PR` Panel Rey, `VOL` Volcan, `CAL`,
`ROM` Romeral, `PET`, `GYP`). Suffix is the equipment, in AES product shorthand — `FGWF`
fiberglass weigh feeder, `LIW` loss-in-weight, `WF` weigh feeder.

**Text-searching a client's full name will miss deals.** Search the prefix, or filter on the
associated company.

---

## Useful properties

**DEAL:** `dealname`, `dealstage`, `pipeline`, `amount`, `amount_in_home_currency`,
`closedate`, `dealtype` (`newbusiness` | `existingbusiness`), `hs_priority`
(`low`/`medium`/`high`), `hs_is_closed_won`, `days_to_close`, `num_associated_contacts`,
`notes_last_contacted`, `hubspot_owner_id`.

Prefer `amount_in_home_currency` for any financial comparison — AES quotes in USD and buys
from Kukla in EUR.

**CONTACT:** `hs_buying_role` is the one that matters for lead gen. Enum:
`BLOCKER`, `BUDGET_HOLDER`, `CHAMPION`, `DECISION_MAKER`, `END_USER`, `EXECUTIVE_SPONSOR`,
`INFLUENCER`, `LEGAL_AND_COMPLIANCE`, `OTHER`. Contacts can hold several.

This maps onto the four buying roles in `references/aes-positioning.md` — worth reconciling the
two vocabularies before outreach segments get built on either.

Also: `hs_lead_status` (`NEW`, `Contacted`, `Engaged`→"Connected", `Interested`, `Converted`,
`Not Ready`, `Opted Out`, `Do Not Contact`, `Not Applicable`, `Invalid Email Address`) and
`lifecyclestage` (standard `subscriber`→`evangelist`).

`Opted Out` and `Do Not Contact` must be honored by any automated outreach. Filter on them
before a send, not after.

---

## Query notes

- Record id property is `hs_object_id`, never `id`.
- `search_crm_objects` returns `total` — use it for counts rather than paginating.
- Max 5 filter groups, 6 filters each, 18 total. Groups OR together; filters within a group AND.
- Free-text `query` matches `dealname`, `pipeline`, `dealstage`, `description`, `dealtype`
  for deals. Given the prefix naming above, property filters beat free text.
