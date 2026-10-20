# Status & roadmap

Resume point for the WindBot (Tibia 10.76) study. What is done, what is out of scope, what could follow.

## Done
- WindBot **2.8.30** (clients 10.00–10.47) and **2.6.2** (10.76) downloaded from tibiawindbot.com, hashed and Inno-extracted ([01](01-provenance.md)).
- PE triage: VMProtect sections `.vmp0`/`.vmp1`, Qt5 imports; section/entropy profile of both builds ([03](03-static-analysis.md), [16](16-static-protection-profile.md)).
- Bundled Lua (`luascripts/`, `hudscripts/`, `libs/`) and `tibiadata` XML catalogued ([05](05-lua-surface.md)).
- Lua API catalog: 801 documented entries, 785 confirmed in the binary ([09](09-lua-api-catalog.md)).
- RTTI class map (152 classes) and subsystem map ([10](10-rtti-architecture.md), [17](17-subsystem-map.md)).
- Settings schema and auth/updater/navi hosts ([11](11-settings-schema.md), [12](12-auth-protocol.md)).
- Tibia 10.76 client + TFS 1.1 + RSA/IP patch, shared with ibot_re ([06](06-client-patch.md), [08](08-protocol-ot.md)); WindBot reaches its Authentication dialog under Wine ([07](07-runtime.md)).
- Client 10.76 memory map live-validated ([14](14-client-1076-offsets.md), consolidated in [shared map](shared/client-1076-memory-map.md)).
- REA notes ([13](13-rea-analysis.md)); product history from Wayback and community forums ([history](history.md)).

## Coverage
| Area | State | Evidence |
|---|---|---|
| Distribution / provenance | complete for studied builds | [01](01-provenance.md) |
| Static PE / Qt / RTTI | complete at metadata level | [03](03-static-analysis.md), [10](10-rtti-architecture.md) |
| Lua API surface | complete | [09](09-lua-api-catalog.md) |
| Auth surface | hosts and strings only | [12](12-auth-protocol.md) |
| Client memory map (10.76) | live-validated | [14](14-client-1076-offsets.md) |
| Feature engines in game | not exercised (behind auth) | [07](07-runtime.md) |

## Out of scope
- VMProtect-virtualized code is not unpacked or dumped; [15](15-vmp-lab.md) records applicability notes only. Protection bypass is outside this repo's scope.
- The Authentication dialog needs vendor forum credentials; no licence workaround is attempted.

## Optional follow-ups
- Compare the shipped iBot→Wind converters in `libs/converter/` with iBot script formats (plain Lua).
- Add Wayback snapshot links to the forum mentions in [history](history.md) once the archive API responds.

## Conventions
- Addresses are VAs at ImageBase `0x400000` unless stated otherwise.
- Docs are English, UTF-8, LF, final newline. Vendor binaries are referenced by SHA256, never committed.
- Doc numbers are stable identifiers; `01` is provenance here (sibling repos use `01-overview`), kept to avoid breaking links.
