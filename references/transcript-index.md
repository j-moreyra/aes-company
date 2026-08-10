# Transcript index

Where every meeting transcript in the SharePoint library lives, and how to find them all again.

Built 2026-08-10. **A snapshot, not a live view.** Regenerate with the recipes at the bottom
before relying on it for a full sweep.

## Read this before counting anything

**There is no transcripts folder.** A folder search for "Transcript" returns nothing. Every
transcript sits in the project folder for whichever client the meeting was about.

**The recording and its transcript are on different drives.** The `.mp4` lives in William's
personal OneDrive (`advengsys-my.sharepoint.com`), the `.docx` in the shared library. Browsing to
one never leads to the other. That is why `Recordings/` looks empty of transcripts.

**Filename search undercounts. Four ways it fails, all confirmed:**

| Failure | Example |
|---|---|
| Misspelled prefix `Transript_` | `Transript_CEMEX-TN_20251013.docx` · `Transript_Holcim_Argentina_090302025.docx` |
| No prefix at all | `Equipo Kukla - Reunión de planificación.docx` (SOBOCE) · `USG_Dunnage overview_04112025.docx` (Qubiqa) |
| Hyphen instead of underscore | `Transcript-Holcim-ARG-Balanza para clinker-20250819…` |
| Duplicated across folders | `Transcript_Clinker Scale_CEMEX_04102025.docx` exists in both `1. Kukla/Recordings/` and `02. Cement/03. CEMEX/` |

**Search totals are unreliable.** The same content query reported `91`, then `53`, then `41` as
pagination went deeper. Graph returns estimates and trims on deep pages. Never quote a search
total as a file count. Enumerate, then count what you actually got.

## Where they are

All under
`…/Advanced Engineering Systems - General/`, which maps to
`https://advengsys.sharepoint.com/sites/AdvancedEngineeringSystems/Shared Documents/General/`.

### `1. Kukla/01. Projects/02. Cement/00. Brazil/` — the largest single block

The country folder the earlier survey missed entirely. Roughly 30 transcripts, all clinker
weighing, all in Portuguese.

| Client / plant | Transcript | Date |
|---|---|---|
| 1. Intercement / 1. Sao Paulo / 1. Carlos Alberto Moraes | `Transcript_InterCement_Clinker_20250513` | 2025-05-13 |
| 1. Intercement / 1. Sao Paulo / 2. Jaison Oliveira | `Transcript_Sistema de pesagem - clínquer-20250806` | 2025-08-06 |
| 1. Intercement / 2. Candiota, Rio Grande do Sul | `Transcript_Intercement-Clínquer-20250820` | 2025-08-20 |
| 1. Intercement / 3. Cajati, Sao Paulo | `Transcript_Intercement_clínquer_08272025` | 2025-08-27 |
| 2. Votorantim / 1. Santa Helena (SP) | `Transcript_Sistema de clínquer-20250805` | 2025-08-05 |
| 2. Votorantim / 1. Santa Helena (SP) | `Transcript_Votorantim_StHelena_20251016` | 2025-10-16 |
| 2. Votorantim / 2. Curitiba (Paraná) | `Transcript_Votorantim_Curitiba-20250911` | 2025-09-11 |
| 2. Votorantim / 3. Vila Olímpia (SP) Corporate | `Transcript_Vila Olímpia SP-20251208` | 2025-12-08 |
| 3. CSN Cimentos / 1. Alhandra, Paraíba | `Transcript_Sistema de pesagem - clínquer` | 2025-08-11 |
| 3. CSN Cimentos / 1. Alhandra, Paraíba | `Transcript_CSN_clinquer_09252025` | 2025-09-25 |
| 3. CSN Cimentos / 2. Arcos | `Transcript_CSN_clínquer_08262025` | 2025-08-26 |
| 3. CSN Cimentos / 2. Arcos | `Transcript_CSN-Arcos_20251030` | 2025-10-30 |
| 5. Cimento Tupi / 1. Carandaí MG | `Transcript_Cimento Tupi_Clínquer_08292025` | 2025-08-29 |
| 6. Supremo Cimentos / 2. Adrianópolis, Paraná | `Transcript_SupremoCimento_09262025` | 2025-09-26 |
| 7. Cimento Nacional / 1. Pitimbu, Paraíba | `Transcript_Cimento Nacional_Clínquer_09052025` | 2025-09-05 |
| 7. Cimento Nacional / 2. Sete Lagoas, Minas Gerais | `Transcript_Cimento Nactional_Sete Lagoas_20250926` | 2025-09-26 |
| 8. Cimento Apodi | `Transcript_CimentoApodi_Clínquer_20251015` | 2025-10-15 |

Client folders are numbered 1 to 8, and `4. Cimento Itambé` has no transcript in this snapshot.
The tree runs country → client → plant → contact → project, deeper than the rest of the library.

### `1. Kukla/01. Projects/02. Cement/` — everything else

| Client / plant | Transcript | Date |
|---|---|---|
| 01. SOBOCE / 2. Cement additive / 4. Meeting Recordings | `Equipo Kukla - Reunión de planificación` | 2025-08-11 |
| 02. Holcim (root) | `Transcript_Holcim_Mexico_20250919` | 2025-09-19 |
| 02. Holcim / 4. Buenos Aires (Campana) ARG | `Transcript-Holcim-ARG-Balanza para clinker-20250819…` | 2025-08-19 |
| 02. Holcim / 5. Guayaquil ECU | `Transcript_Holcim-clinker_08222025` | 2025-08-22 |
| 02. Holcim / 6. Metapán El Salvador | `Transcript_Holcim_Clinker_08252025` | 2025-08-25 |
| 02. Holcim / 7. Córdoba ARG | `Transript_Holcim_Argentina_090302025` | 2025-09-03 |
| 02. Holcim / 8. Veracruz MX | `Transcript_Holcim Veracruz_Clinker-20251014` | 2025-10-14 |
| 03. CEMEX (root) | `Transcript_Clinker Scale_CEMEX_04102025` | 2025-04-10 |
| 03. CEMEX / 1. USA / 2. Knoxville TN | `Transript_CEMEX-TN_20251013` | 2025-10-13 |
| 03. CEMEX / 2. Monterrey MX / 2. Railcar loading | `Transcript_IFM for trains_CEMEX_20250526` | 2025-05-26 |
| 05. Loma Negra / 2. Zapala ARG | `Transcript_Loma Negra_Balanza clinker-20250811` | 2025-08-11 |
| 07. Argos US_Summit_Quikrete / 2. Newberry FL | `Transcript_Clinker Presentation-20250523` | 2025-05-23 |
| 12. Tehachapi (UNACEM) / 1. Clinker pan conveyor scale | `Transcript_Clinker scale - Tehachapi-20250718` | 2025-07-18 |
| 13. GCC | `Transcript_GCC_Apron Feeder for the mill chat-20250805` | 2025-08-05 |
| 14. Amrize / 3. Dundee MI | `Transcript_Amrize_Michigan_09232025` | 2025-09-23 |
| 15. Cementos Pacasmayo / 1. Pacasmayo PE | `Transcript_Cem_Pacasmayo-Balanza para clinker-20250821…` | 2025-08-21 |
| 16. Ash Grove Cement | `Transcript_Ash Grove_Canada_Clinker_20250910` | 2025-09-10 |
| 17. Titan America / 1. Medley FL | `Transcript_Titan America_20251010` | 2025-10-10 |

### `1. Kukla/01. Projects/01. Gypsum/`

| Client / plant | Transcript | Date |
|---|---|---|
| 02. Saint-Gobain / 2. Volcan / 1. Santiago CHI / 11. FG and Kettle feeders | `Transcript_Kettle feeder 8 & 11_Volcan Chile-20251104` | 2025-11-04 |
| 02. Saint-Gobain / 2. Volcan / 2. Chosica PE | `Transcript_VolcanPeru_Stucco WF_10282025` | 2025-10-28 |
| 03. ETEX / 1. Argentina (Durlock) / 2. Mendoza | `Transcript_Durlock_Mendoza_20250910` | 2025-09-10 |
| 03. ETEX / 2. Colombia (Gyplac) | `Transcript_Gyplac_Multiex preso_20250513` | 2025-05-13 |
| 04. GP | `Transcript_Kukla Stucco feeder_GP_20260618` | 2026-06-18 |
| 05. National Gypsum / 2. Savannah GA / 3. Meetings | `Transcript_NG_Ensign_Project chat_043026` | 2026-04-30 |
| 05. National Gypsum / 4. Wilmington NC | `Transcript_FGWF-NG_Wilmington-NC-20260617` | 2026-06-17 |
| 08. Panel Rey / 3. Houston TX / 1. LIW batch process | `Transcript_Panel Rey - Loss in weight-20250731` | 2025-07-31 |

### `1. Kukla/Recordings/`

The one folder that looks like a transcript archive and is not. Three files only.

| Transcript | Date |
|---|---|
| `Transcript_Clinker Scale_CEMEX_04102025` (duplicate of the CEMEX copy) | 2025-04-10 |
| `Transcript_Cement questions_Armin-04152025` | 2025-04-15 |
| `Transcript_Repuestos y Kukla_Manizales_20250522` | 2025-05-22 |

### `5. MultiExport/`

| Folder | Transcript | Date |
|---|---|---|
| 2. MAC Instruments | `Transcript_MAC training_041625` | 2025-04-16 |
| 2. MAC Instruments / 1. Projects / 2. Eternit (Peru) | `Transcript_Eternit-PE_Sensor de humedad-20250619` | 2025-06-19 |
| 2. MAC Instruments / 1. Projects / 3. Saint-Gobain | `Transcript_MAC sensor_SG-20250729` | 2025-07-29 |
| 3. Finna / 1. Projects / 6. PR - Smart III RF Sensor | `Transcript_Sensor de humedad-20250717` | 2025-07-17 |
| 5. Vibra Screw / 1. Romeral CHI - Hopper discharger | `Transcript_Cilindro de impacto para tolva_10172025` | 2025-10-17 |

### `Qubiqa/1. Projects/`

| Folder | Transcript | Date |
|---|---|---|
| 2. GP | `Transcript_Dunnage design review_09012025` | 2025-09-01 |
| 2. GP | `Transcript_Qubiqa Project updates-10082025` | 2025-10-08 |
| 3. USG | `USG_Dunnage overview_04112025` | 2025-04-11 |
| 3. USG | `Transcript_USG-Dunnage system proposal review_20251009` | 2025-10-09 |

## How to find them all again

**On William's Mac, this is exhaustive and instant.** It catches the `Transript` typos and the
hyphen variants, which a search for `Transcript_` does not:

```bash
LIB=~/Library/CloudStorage/OneDrive-SharedLibraries-AdvancedEngineeringSystems/"Advanced Engineering Systems - General"
find "$LIB" -type f -iname "*.docx" \( -iname "*transcript*" -o -iname "*transript*" \) | sort
```

It still misses files with no transcript-like word in the name, the SOBOCE and Qubiqa cases
above. To catch those, look inside the documents. `.docx` is a zip, so plain grep fails:

```bash
find "$LIB" -type f -iname "*.docx" -print0 | while IFS= read -r -d '' f; do
  unzip -p "$f" word/document.xml 2>/dev/null \
    | grep -q "started transcription" && echo "$f"
done
```

That content test is the only method that finds every Teams transcript regardless of filename.

**From any session, with no OneDrive:** use the Microsoft 365 connector.

- `sharepoint_search` with `query: "started transcription"`, `fileType: docx`, paginating on
  `nextOffset`. Content-based, so filename variants do not matter.
- Narrow to a region with `folderName`, for example `folderName: "Brazil"`. The filter matches
  ancestor paths, which is what makes the country folder addressable.
- `read_resource` on a result's `uri` returns the full text. **A transcript is too big for one
  read**, roughly 80,000 characters for a 45-minute call. It spills to a file and returns the
  path. Read it in chunks or hand it to a subagent.

**For a full-corpus exercise, prefer the local content sweep.** Search pagination trims on deep
pages and the totals contradict each other; `find` over the synced library does not.

## Caveats on this snapshot

- Counts here are what enumeration actually returned, not what a search total claimed.
- `4. Cimento Itambé` and any client folder added since 2026-08-10 are not represented.
- One transcript is prefixed `NOTTA ` from a different transcription tool, and Panel Rey has both
  an original and a `Transcript-English_` translation of the same call. Neither is in the tables
  above; both turn up in the local sweep.
- Match on content, not filename. The same meeting appears as
  `Transcript_Holcim_Veracruz_10142025` in one place and
  `Transcript_Holcim Veracruz_Clinker-20251014` in another.
