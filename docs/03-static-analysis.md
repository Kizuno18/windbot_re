# Static analysis

## Main binary (`code$MyConst.exe`)

### 2.8.30

| Field | Value |
| --- | --- |
| SHA256 | `756403d367e578ed7269eb967d532edd1e16916f9593e8c9ed92acf148066be3` |
| Size | 15 796 736 bytes |
| Timestamp | 2017-09-12 12:57:05Z |
| Sections | `.text` `.rdata` `.data` **`.vmp0`** `.tls` **`.vmp1`** `.rsrc` |
| `.vmp0` entropy | ~7.45 |
| `.vmp1` entropy | ~7.98 |
| CLR | none (native C++) |
| Framework | Qt5 Core/Gui/Widgets/Network/OpenGL/Svg |

Import table is **IAT-stubbed** (often one symbol per DLL) — typical of VMProtect
import protection. Real resolves happen at runtime.

### 2.6.2

Same packaging pattern (Inno → `code$MyConst.exe` + Qt5 DLLs + script trees).
Use for 10.76-matched runtime attempts.

## Ancillary tree

- `luascripts/` — user-facing bots (AntiIdle, trainers, SoftChanger, …)
- `hudscripts/` — overlay widgets (LootCounter, NaviRadar, SpellTimers, …)
- `libs/` — large vendor Lua (`LucasTerra.lua`, `Raphael.lua`, `Leonardo.lua`, …)
- `libs/converter/` — iBot→Wind script helpers (`FriendHealer_ib.lua`, …)
- `tibiadata/` — `items.xml`, `creatures.xml`, `spells.xml`, …
