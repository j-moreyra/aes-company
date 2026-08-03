---
name: order-docs
description: Use when a client purchase order arrives and the PO to Kukla must be raised, or when Kukla's order confirmation has come back and the client's Order Acknowledgement is due. Reconciles line items across the Kukla quote, the client PO and Kukla's order confirmation, writes the PO TO KUKLA / OA tab in the project CS workbook, and renders the PDF. Trigger on "raise the PO to Kukla", "client sent a PO", "order acknowledgement", "OA for".
---

## The sequence, and why order matters

```
1. Kukla sends AES a quote                    (input)
2. AES sends the client a quote               ← separate quote-generation skill, not this one
3. The client submits a purchase order        (input)
4. AES sends Kukla a PO                       ← THIS SKILL, step one
5. Kukla sends AES their order confirmation   (input — carries the delivery date)
6. AES sends the client an Order Acknowledgement  ← THIS SKILL, step two
```

**The PO to Kukla comes first, and the client OA is blocked until Kukla's order confirmation
arrives.** The delivery date AES commits to on the client OA is Kukla's confirmed date, not an
estimate. Producing the OA before step 5 means inventing a date and putting it in writing to a
client — do not do it.

Kukla's order confirmation carries two dates near the end of page 1:

```
Sending date:    09.04.2026
Delivery date:   09.04.2026
```

**Use `Delivery date`** as the OA's `ESTIMATED SHIPPING DATE`. In the reference case OC 940133
gave 09.04.2026 and the OA read `9-Apr`.

**If no Kukla order confirmation is in the project folder, do not assume it doesn't exist —
search Outlook first.** They arrive by email from Patrik Lenzeder with subject
`Order confirmation <NNNNNN> Dated <DD.MM.YYYY> (Your PO <po number> Dated <DD.MM.YYYY>)` and
the PDF attached. In the reference case it was never filed. Search
`sender: lenzeder@kukla.co.at` around the PO date rather than free-texting the quote reference —
free-text relevance search does not find these. Ask William to save the attachment into the
project folder before proceeding.

Both outputs live in one skill because they are two views of one reconciliation. The same goods
appear in four documents, priced at cost in one direction and at sell in the other. Run
separately, nothing stops you ordering one unit from Kukla while acknowledging four to the
client. Run here, the quantities are checked against each other.

## Where each field comes from

| | PO to Kukla (step 4) | Client OA (step 6) |
|---|---|---|
| Line items, part numbers, descriptions | **Kukla quote** | AES quote tab, matched by part |
| **Quantities** | **client PO** | **client PO** |
| Unit prices | **Kukla quote** (AES cost) | **client PO** (AES sell) |
| Currency | **EUR** — Kukla quotes in euro | **USD** |
| Delivery / ship date | not stated | **Kukla's order confirmation** |
| Freight | usually `TBD` at order time | AES quote figure, confirmed |

## Bundling — the hardest part

**AES sells bundles; Kukla sells components.** One line on the AES quote and the client PO can
be several lines on the Kukla quote and PO. The client never sees the split; Kukla must see it.

From the NG Savannah case (`CS_260.19034_NG FGWF.xlsx`):

| Client sees (OA) | Kukla sees (PO) |
|---|---|
| `Pre-Bin (stainless Steel)` — $20,685 | `110` Pre-bin €11,210 + `115` Level probe FTM20 €770 + `120` Access Door & Safety Interlock €770 |
| `Small Weigh Feeder, Type E-K-DBW-H400` — $103,375 | `150` Weigh feeder €64,570 + `155` Compensator (flexible connection) €930 |
| `Control Cabinet — includes DWC-7C, OP-G, Fieldbus interface and site manager` — $43,890 | `170` Control cabinet €27,320 + `175` Remote maintenance package (site manager) €1,420 |

Eight client lines ↔ eleven Kukla lines. Get this wrong in either direction and you either order
a machine without its flexible connection, or you order and pay for something the client was
never charged for.

**The mapping already exists — don't invent it.** The CS workbook's profit-comparison tab
(`PC-<number>`) is the mapping layer: the upper block lists Kukla's cost lines, the lower block
(`FINAL QUOTE TO CLIENT`) lists the bundled client lines, and the notes column spells the
bundles out — *"with Access door with safety switch and extra level probe"*, *"Includes flexible
connection"*. Read that tab first and reconcile against it. If a project has no such tab, build
the mapping explicitly and show William before generating anything.

**Sell prices are not cost × markup.** The comparison tab computes candidate prices at several
commission rates, and William then overrides some by hand. In the NG case the flexible
connection computed to $1,429.88 and was sold at $3,075; the site manager computed to $2,183.25
and was sold at $1,450. **Never derive a client price from a Kukla price.** Take sell prices
from the client PO or the final AES quote, and cost prices from the Kukla quote. They are
independent.

Two further traps, both real in the reference cases:

**Quantities never come from the Kukla quote.** Kukla quoted 1 × DWC-7B; the client ordered 4;
the PO to Kukla was raised for 4. The quote governs *what* and *at what price*, the client PO
governs *how many*. Copying the quote's quantity would have under-ordered by 3 units against a
€21,780 line.

**Currency flips between the two documents.** The PO to Kukla is in EUR because Kukla's quote
is in EUR. The client OA is in USD. A `$` on the Kukla PO is wrong and vice versa.

## Step 0 — establish where the documents are coming from

**Do this before anything else.** The skill runs in two very different places.

Check whether the OneDrive library is reachable:

```
ls ~/Library/CloudStorage/OneDrive-SharedLibraries-AdvancedEngineeringSystems 2>/dev/null
```

**If it resolves** (Claude Code on William's Mac) — work directly from the project folder under
`1. Kukla/01. Projects/…`. Locate the files yourself and tell him which ones you found. Don't
ask him to upload anything.

**If it does not** (Claude Cowork, claude.ai, any machine without the library) — **stop and ask
for the documents before doing anything else.** Ask in one message, listing exactly what is
needed for the step being run, and say why each is needed. Something like:

> To raise the PO to Kukla I need three things:
>
> 1. **Kukla's quote** (`Quotation<number>.pdf`) — the part numbers, descriptions and cost
>    prices. The PO must match it line for line.
> 2. **The client's purchase order** — the quantities. These override Kukla's quoted quantities.
> 3. **The project CS workbook** (`CS_<number>.xlsx`) — optional but strongly preferred. Its
>    `PC-<number>` tab holds the bundling map and confirms the totals. Without it I have to
>    infer which client line covers which Kukla components, and I'll ask you to confirm.
>
> For the Order Acknowledgement I also need **Kukla's order confirmation**, which carries the
> delivery date, plus your next OA number.

Adapt the list to the step. Never proceed on a partial set by guessing at the missing document —
say what is missing and wait. The one exception is the CS workbook: you can proceed without it
if William confirms the bundling verbally, but flag that the totals are then unverified against
his own sheet.

If the workbook isn't available, set `"workbook": null` and `"cellmap": null` in the spec. The
script will render the PDF only, which is the right outcome in a hosted session — there is no
workbook to update.

## Procedure

1. **Read the source documents yourself.** Do not regex them — client PO layouts differ and are
   often bilingual, and Kukla quotes group lines under `FN` main-line headings with their own
   item numbers. Extract line items with quantity, unit price, line total, part/item number,
   plus addresses, incoterms, payment terms and dates.

   **Watch for quantity-as-dollars.** Some procurement systems (Gold Bond / National Gypsum's
   does) put the **line amount in the QTY column** with a unit price of $1.00:

   ```
   1  Pre-Bin (Stainless…)      QTY 20,685 each   UNIT PRICE $1.00   AMOUNT $20,685.00
   5  Screened Special Cables   QTY 440 each      UNIT PRICE $1.00   AMOUNT $440.00
   ```

   Line 5 is really **50 metres at $8.80**; the true quantity appears only in the description
   (`per Quote (Qty 50 m)`). Taken literally you would acknowledge "20,685 pre-bins at $1.00".
   The tell is a unit price of exactly 1.00 across every line. When you see it, take the money
   from AMOUNT and the real quantity from the AES quote or the description, and say in the
   reconciliation table that you did.
2. **Show William a reconciliation table before generating anything.** Each source line beside
   the line you intend to output, with every quantity or price difference called out. This is
   the step that catches errors; do not skip it to save a turn.
3. **Build the spec JSON** and run:
   `python3 scripts/build_order_doc.py spec.json`
4. **Export the PDF** — see the two paths below. Prefer the workbook export.
5. **Read the finished PDF before showing it.** Actually open it and look. Check for `#NAME?`,
   clipped descriptions, rows swallowed by stale merges, empty bordered rows below the total,
   prices rendering as `400` instead of `$ 400.00`, and a total that disagrees with the source.
   This step is not optional — a wrong document that looks right is worse than a failure.
6. **Show it to William and wait.** These go to a client or to Kukla. Nothing is sent here.

## Two ways to produce the PDF

**Preferred — export the workbook tab (matches the existing documents exactly).** The real
`OA *.pdf` and `PO * KUKLA.pdf` in the project folders *are* Excel exports, so exporting the tab
reproduces them natively rather than approximating them:

```
python3 scripts/export_tab_pdf.py --workbook "CS_260.19034_NG FGWF.xlsx" \
    --sheet "PO TO KUKLA" --out "PO 330_07282026 KUKLA.pdf" --print-area B1:H45
```

It copies the workbook, deletes every other sheet, sets the print area and fit, then converts
with LibreOffice — the same approach as the spares-quote skill. Two rules follow from deleting
the other sheets:

- **Write literal values into the tab, never cross-sheet formulas.** A reference to
  `PC-<number>` renders as `#NAME?` once that sheet is gone.
- **For long documents pass `--fit-height 0`** so it fits width only and paginates naturally,
  instead of crushing everything onto one page.

Needs LibreOffice. Present in the Cowork sandbox; **not installed on William's Mac** —
`brew install --cask libreoffice` if the native export is wanted there.

**Fallback — the built-in renderer.** `build_order_doc.py` draws the document from the spec and
renders via headless Chrome, weasyprint or LibreOffice, whichever exists. Use it when there is
no workbook (a hosted session where only PDFs were uploaded) or no LibreOffice. Output is
faithful in content and close in layout, but it is a reimplementation — the font falls back to a
generic sans, so it will not be pixel-identical to previous documents.

## Numbering and naming

| | PO to Kukla | Order Acknowledgement |
|---|---|---|
| Number | `330.MMDDYYYY` e.g. `330.02182026` | `NNN/YY` sequential e.g. `430/26` |
| PDF | `PO <NNN>_<MMDDYYYY> KUKLA.pdf` | `OA <NNN>_<YY> <CLIENT>.pdf` |
| Tab | `PO TO KUKLA` | `OA` |

Ask William for the next OA number — it is a running sequence he holds, not derivable from the
folder.

## Kukla quote specifics

- Lines are grouped under main lines per fabrication number (`10 — Spare parts for FN: 10339`).
  Carry the FN into the description: `Load cell Z6FC3 for FN 10769`.
- Some lines have **no Kukla item number** (the DWC-7B in the reference case). Leave it blank
  rather than inventing one.
- The quote's transport line is a *guiding price* under `FCA Vöcklabruck`, not an ordered item.
  It does not become a PO line; freight goes out as `TBD` and is settled later.
- Where the client PO specifies more than Kukla's description (`+ Ethernet`), carry the client's
  requirement into the PO description so Kukla builds the right thing.

## Spec schema

```jsonc
{
  "kind": "po_kukla" | "oa",
  "currency": "EUR" | "USD",          // defaults: po_kukla→EUR, oa→USD
  "project_folder": "/abs/path",
  "pdf_name": "PO 330_02182026 KUKLA.pdf",
  "workbook": "/abs/path/CS_290.37322.xlsx",   // null to skip the tab write
  "cellmap": { ... },                           // null to skip
  "sold_to": ["KUKLA WAAGENFABRIK GmbH & Co KG", "..."],
  "ship_to": ["PANEL REY", "Address to be confirmed"],
  "meta": [["PURCHASE ORDER NUMBER", "330.02182026"], ["DATE", "18-Feb-26"]],
  "items": [{"qty": 4, "item_no": "102856", "description": "...", "unit_price": 595}],
  "freight_label": "FREIGHT",
  "freight_amount": "TBD",             // or a number
  "source_totals": {"subtotal": 28899.00}
}
```

`source_totals.subtotal` is the guard: the script sums the lines you built and refuses to write
if the result disagrees with the source document. Always populate it.

### Document shape varies by project — read the tab before writing it

There is no single template. Confirmed differences between the two reference projects:

| | Panel Rey (`CS_290.37322`) | NG Savannah (`CS_260.19034`) |
|---|---|---|
| PO tab columns | `C`=qty, `D`=item no | `C`=item no, `D`=qty |
| PO line numbers | 1, 2, 3 … | Kukla's own: 110, 115, 130 … plus a `100` heading row |
| OA meta labels | `ORDER NUMBER`, `TERMS`, `ESTIMATED SHIPPING DATE` | `SALES ORDER`, `PAYMENT TERMS` (two lines), `QUOTE` |
| OA totals | SUBTOTAL + FREIGHT + TOTAL DUE US | single `TOTAL FOR PURCHASE ORDER`; freight is a numbered line item |

So: **dump the target tab and derive the cell map from it** rather than assuming the map below.
Spec fields `line_no`, `heading`, `show_subtotal` and `total_label` exist to absorb this
variation.

### Cell maps — Panel Rey shape (verify against the actual workbook)

```jsonc
// PO TO KUKLA tab
{"tab": "PO TO KUKLA",
 "fields": {"G5": "<po number>", "G6": "<date>", "G7": "<kukla quote no>",
            "G8": "<terms>", "G9": "<incoterms>",
            "B6": "", "B7": "", "B8": "", "B9": "",   // Kukla address
            "B12": "", "B13": ""},                    // ship to
 "items": {"first_row": 17, "line": "B", "qty": "C", "item_no": "D",
           "description": "E", "unit_price": "G", "total": "H",
           "write_line_totals": false},
 "totals": {"H37": "TBD"}}

// OA tab
{"tab": "OA",
 "fields": {"F5": "<order number>", "F6": "<client PO no>", "F8": "<terms>",
            "F9": "W. Moreyra", "F11": "<date from Kukla's order confirmation>",
            "F12": "<incoterms>",
            "B6": "", "B7": "", "B8": "", "B9": "",       // sold to
            "B12": "", "B13": "", "B14": "", "B15": ""},  // ship to
 "items": {"first_row": 19, "line": "B", "qty": "C", "description": "D",
           "unit_price": "F", "total": "G", "write_line_totals": false},
 "totals": {"F39": "FREIGHT DAP - <destination>", "G39": 865}}
```

**Leave `write_line_totals` false and never write the subtotal/total cells.** The template
carries `=C19*F19`, `=SUM(G19:G37)` and `=+G38+G39`. Literals silently kill the workbook's own
arithmetic. The script backs the workbook up to `.bak` before its first write regardless.

## Checks the script enforces

Refuses to write if any line's qty × price disagrees with its stated total, the lines don't sum
to the stated subtotal, subtotal + freight ≠ stated total, or the lines disagree with
`source_totals.subtotal`.

## Workbook editing pitfalls

Carried over from the spares-quote skill, where each of these has bitten a real run:

- **Re-read the workbook fresh before every export.** William edits tabs by hand — prices,
  terms, borders. Never work from a cached read, and never overwrite his manual changes. If he
  says he changed prices, read the values he left and push those literals through; he may have
  typed over a formula.
- **Rewritten cells lose their number format.** Re-copy `_style` from an intact row or prices
  print as `400` rather than `$ 400.00`.
- **Inserting rows does not move merged ranges or fix SUM ranges.** openpyxl leaves formula
  strings alone, so template totals go stale, and a full-width merge can end up sitting on an
  item row and swallowing every cell but the first. After inserting: list
  `ws.merged_cells.ranges`, unmerge anything full-width in the item area, re-merge the note rows
  at their new position, and rewrite the totals explicitly.
- **If `unmerge_cells` raises `KeyError`**, openpyxl's bookkeeping is out of sync: drop the range
  from `ws.merged_cells.ranges` directly and delete orphaned `MergedCell` objects from
  `ws._cells` before writing, or assignment fails read-only.
- **Never restore cell contents from a LibreOffice recalc copy** — it drops values in cells
  covered by a merge. Recompute from the source documents instead.

## File the source documents with the output

Every project folder should be self-contained: the Kukla quote, the client PO, Kukla's order
confirmation, and everything derived from them. Copy uploaded sources in under their original
filenames. If a document arrived in more than one revision, file the one actually built from and
say which that was. Both reference projects are missing a source document — Panel Rey has no
Kukla order confirmation, NG Savannah no client PO — which is exactly what this prevents.

## Checks you must do yourself

- **Quantities on the PO to Kukla equal quantities on the OA.** Nothing enforces this but you.
- **Ship-to address, digit by digit.** The correct address is `CROSSROADS LOOP 10218` — it
  appears that way on the client PO and in William's own 2025-07-25 email to Kukla. The OA that
  went out reads `102218 Crossroads Loop`, which is **wrong**: a transposed digit in the
  delivery address of a $52k shipment. Never copy this field from a previous OA; take it from
  the client PO every time.
- **Delivery date against the client's request.** The client PO asked for 30/03/2026; Kukla
  confirmed 09.04.2026 and the OA promised 9-Apr. Using Kukla's date is correct, but when it is
  later than the client asked for, say so to William before the OA goes out — that is a slipped
  commitment the client has not yet agreed to.
- **Terms wording.** Client PO "Cash in advance" was acknowledged as "Advanced payment". Fine,
  but keep it deliberate.
- **File Kukla's order confirmation in the project folder.** In the reference case it is absent,
  so the source of the 9-Apr commitment cannot be verified after the fact.

## Reference cases

**Spare parts, simple 1:1** —
`01. Gypsum/08. Panel Rey/1. Monterrey MX/07. PR - Load cells & sensors`.
Client PO `4500244223`, Kukla quote `Quotation260073_01222026`, OC `940133`. Regenerated and
matching to the cent: PO €28,899.00, OA $52,735.00.

**Machine order, bundled lines and overridden prices** —
`01. Gypsum/05. National Gypsum/2. Savannah GA`.
Kukla quote `Quotation26029705` (260297/05, six pages), OC `940624`, AES quote
`AES-260.19034-c`, client PO `2500040906`. Regenerated and matching to the cent:
PO €144,600.00 + €9,730.00 freight = **€154,330.00**, which equals Kukla's own quote total
exactly; OA **$232,270.00**. Eight client lines against eleven Kukla lines.

Use the second case when testing changes — it exercises bundling, price overrides, Kukla line
numbering, heading rows and the single-total OA layout.

## Requirements and portability

**PDF rendering** tries, in order: headless Chrome → `weasyprint` → LibreOffice. Chrome gives
the closest match to the reference documents and is what William's Mac has. If none is present
the script writes the `.html` next to where the PDF would have gone and says so — open it in a
browser and print to PDF. Install `weasyprint` (`pip install weasyprint`) in a hosted sandbox to
get real PDFs.

Excel automation is deliberately not used anywhere — it needs macOS Automation permission and
hangs without it.

**Writing the workbook tab** needs `openpyxl` and the actual `CS_<number>.xlsx`. In a hosted
session you usually won't have it; render the PDF only and hand the values back so William can
update the workbook himself.

**Fonts:** Calibri is generally unavailable to headless renderers, so output falls back to a
sans-serif. Cosmetic only — every figure and label is correct. Embed the font if a pixel match
matters.

**Packaging for Cowork / claude.ai:** a `.skill` file is a zip with `SKILL.md` at the root.
Include `scripts/` and `assets/` alongside it:

```
cd .claude/skills/order-docs && zip -r ~/Desktop/order-docs.skill SKILL.md scripts assets
```
