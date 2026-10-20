# WindBot Reverse Engineering

**Architecture, Lua API, auth surface, and a live-validated Tibia 10.76 memory map for WindBot.**

[Start here](docs/02-overview.md) · [Documentation](#documentation) · [Status](docs/00-status.md) · [Memory map](docs/shared/client-1076-memory-map.md) · [History](docs/history.md)

`windbot_re` documents **WindBot** (tibiawindbot.com, Lucas Terra et al., 2013–present),
a Qt5 native bot for the classic C++ Tibia client. The repository holds research notes,
hashes, Lua catalogs, tooling and runtime evidence; vendor binaries are referenced by
SHA256 and archive links only.

## Research highlights

- **Lua API tied to the binary.** 801 documented entries, 785 confirmed in the 2.8.30 build
  ([09](docs/09-lua-api-catalog.md)), cross-referenced by subsystem ([17](docs/17-subsystem-map.md)).
- **Class architecture from RTTI.** 152 classes and their hierarchies, including evidence of
  an in-process hook component ([10](docs/10-rtti-architecture.md)).
- **Complete battle-list layout for client 10.76**, shared with ibot_re
  ([shared memory map](docs/shared/client-1076-memory-map.md)).
- **Product history from primary sources**: launch on 2013-12-07, 2014 pricing, forum record
  ([history](docs/history.md)).

## Architecture at a glance

```text
Inno Setup installer
        |
        v
code$MyConst.exe   (Qt5 GUI + engine, VMProtect .vmp0/.vmp1)
        |
        +-- Lua 5.x scripting (luascripts/, hudscripts/, libs/)
        +-- tibiadata/*.xml (items, creatures, spells, …)
        +-- Qt5 Network → auth.tibiawindbot.com / updates / navi
        |
        v
Attach to running Tibia.exe (memory + UI automation; see strings)
```

The installer ships the main binary as `code$MyConst.exe` (an Inno constant expansion
artifact); the window title shows `WindBot <ver>`. Under Wine the session stops at
`WindBot 2.6.2 - Authentication`, which needs forum credentials from `auth.tibiawindbot.com`.

## Analyzed components and coverage

| Item | Value |
| --- | --- |
| Latest multi-client build studied | WindBot **2.8.30** (clients 10.00–10.47) |
| Build matched to this study | WindBot **2.6.2** (client **10.76**) |
| Matched client | CipSoft **Tibia 10.76** |
| Local OT | The Forgotten Server **1.1** @ `127.0.0.1:7171/7172` |
| Wine prefix | `/workspace/wine/windbot` (win32, isolated) |

Coverage per area is tracked in [00-status](docs/00-status.md).

## Documentation

### Choose a reading path

| Goal | Start with |
| --- | --- |
| Understand the product | [Overview](docs/02-overview.md) → [History](docs/history.md) → [Provenance](docs/01-provenance.md) |
| Explore scripting | [Lua surface](docs/05-lua-surface.md) → [Lua API catalog](docs/09-lua-api-catalog.md) → [Subsystem map](docs/17-subsystem-map.md) |
| Read client memory | [Shared memory map](docs/shared/client-1076-memory-map.md) → [14 validation log](docs/14-client-1076-offsets.md) → [Client patch](docs/06-client-patch.md) |
| Assess coverage | [Status](docs/00-status.md) → [Static analysis](docs/03-static-analysis.md) → [Static protection profile](docs/16-static-protection-profile.md) |

<details>
<summary><strong>Complete documentation index</strong></summary>

| Chapter | Subject |
| --- | --- |
| [00 — Status](docs/00-status.md) | Done, coverage, out of scope, follow-ups |
| [01 — Provenance](docs/01-provenance.md) | URLs + SHA256 |
| [02 — Overview](docs/02-overview.md) | Product lineage |
| [03 — Static analysis](docs/03-static-analysis.md) | PE / VMProtect / Qt |
| [04 — Protection and auth](docs/04-protection-auth.md) | VMP identification + auth hosts |
| [05 — Lua surface](docs/05-lua-surface.md) | Bundled scripts / API frequency |
| [06 — Client patch](docs/06-client-patch.md) | IP/RSA patch |
| [07 — Runtime](docs/07-runtime.md) | Wine session notes |
| [08 — Protocol / OT](docs/08-protocol-ot.md) | Local TFS setup |
| [09 — Lua API catalog](docs/09-lua-api-catalog.md) | 801-entry Lua API ↔ binary |
| [10 — RTTI architecture](docs/10-rtti-architecture.md) | Class map + injection evidence |
| [11 — Settings schema](docs/11-settings-schema.md) | .xmls/.xmlc, waypoints |
| [12 — Auth protocol](docs/12-auth-protocol.md) | Auth/updater/navi |
| [13 — REA analysis](docs/13-rea-analysis.md) | REA 6.7.0 artifact/desktop notes |
| [14 — Client 10.76 offsets](docs/14-client-1076-offsets.md) | Sources and live validation log |
| [15 — VMP lab](docs/15-vmp-lab.md) | Applicability notes (no unpacking) |
| [16 — Static protection profile](docs/16-static-protection-profile.md) | Sections/entropy/imports, 2.6.2 vs 2.8.30 |
| [17 — Subsystem map](docs/17-subsystem-map.md) | RTTI × strings × Lua API by subsystem |
| [History](docs/history.md) | Timeline, pricing, end of support, forum mentions |
| [Shared memory map](docs/shared/client-1076-memory-map.md) | Consolidated 10.76 player + battle-list map (same file in ibot_re) |
</details>

## Repository layout and tools

| Path | Content |
| --- | --- |
| `docs/` | Research chapters; `docs/shared/` is mirrored in ibot_re |
| `artifacts/` | Text dumps and profiles |
| `scripts/` | Environment helpers |
| `tools/pe_recon.py`, `tools/vmp_section_profile.py` | PE triage; section/entropy/import profile |
| `tools/rtti_vtables.py` | MSVC RTTI → vtables/bases |
| `tools/lua_subsystem_map.py` | Lua API ↔ binary ↔ shipped Lua |
| `tools/patch_client.py` | Hostname + RSA modulus patcher (local copies only) |
| `tools/read_1076.py`, `tools/snap_1076.py` | Read-only `/proc/<pid>/mem` reader and diff snapshotter for a live client |

## Evidence and limitations

**Observed vs. inferred.** Memory fields marked live-validated were read from a running
client on a local server; RTTI and string findings are static and labelled as such.

**Protection.** VMProtect-virtualized code is identified and profiled, not unpacked or
dumped. Licence bypass is out of scope.

**Historical observations.** Endpoints, prices and download availability describe what was
archived or observed, not a statement about current service behaviour.

## Contributing research

Include the binary hash, build, address and evidence when proposing a correction, and keep
runtime observations separate from hypotheses. Documentation and commit messages use English,
UTF-8, LF endings and a final newline. Keep credentials, vendor binaries and personal data out.
