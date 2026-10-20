# WindBot Reverse Engineering

**Architecture, protection, Lua surface, and local analysis notes for WindBot (Tibia classic), for preservation/education.**

[Overview](docs/02-overview.md) · [Status](docs/00-status.md) · [Provenance](docs/01-provenance.md)

`windbot_re` documents **WindBot** (tibiawindbot.com / Lucas Terra et al.), a Qt5
native bot historically attached to the classic C++ Tibia client. This repo is a
research corpus: hashes, PE/VMProtect notes, auth endpoints, bundled Lua samples,
and client-patch tooling. **No copyrighted binaries or license ***REMOVED***

## Scope

| Item | Value |
| --- | --- |
| Latest multi-client build archived | WindBot **2.8.30** (clients 10.00–10.47) |
| Version matched to this study | WindBot **2.6.2** (client **10.76**) |
| Matched client | CipSoft **Tibia 10.76** |
| Local OT | Forgotten Server **1.1** @ `127.0.0.1:7171/7172` |
| Wine prefix | `/workspace/wine/windbot` (win32, isolated) |

## Architecture (static)

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

Installer ships the main binary under the odd name `code$MyConst.exe` (Inno
constant expansion artifact); runtime title shows `WindBot <ver>`.

## License / auth

Observed at runtime under Wine:

- Window title: **`WindBot 2.6.2 - Authentication`**
- Strings: `Host: auth.tibiawindbot.com`, `Cannot connect to login server!`,
  forum login copy, trial purchase URLs, `navi.tibiawindbot.com`,
  `updates.tibiawindbot.com`.

***REMOVED***
The session ends at the Authentication dialog (forum credentials required). Feature engines behind that dialog are documented from static metadata.

## Documentation map

| Doc | Topic |
| --- | --- |
| [00-status](docs/00-status.md) | Done / blocked |
| [01-provenance](docs/01-provenance.md) | URLs + SHA256 |
| [02-overview](docs/02-overview.md) | Product lineage |
| [03-static-analysis](docs/03-static-analysis.md) | PE / VMProtect / Qt |
| [04-protection-auth](docs/04-protection-auth.md) | VMP + auth hosts |
| [05-lua-surface](docs/05-lua-surface.md) | Bundled scripts / API freq |
| [06-client-patch](docs/06-client-patch.md) | IP/RSA patch |
| [07-runtime](docs/07-runtime.md) | Wine session notes |
| [08-protocol-ot](docs/08-protocol-ot.md) | Local TFS setup |

## Tools

- `tools/pe_recon.py`
- `tools/patch_client.py`

## Notes

***REMOVED***
***REMOVED***
