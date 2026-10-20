# Tibia 10.76 client memory map (shared reference)

> Shared between `ibot_re` and `windbot_re` (identical copy in `docs/shared/` of both repos).
> Consolidates the address tables from each repo's `docs/14-client-1076-offsets.md`. The full
> validation logs (rounds 1–3, setup, diffs) remain in those docs; this page is the reference map only.

## Target
| Item | Value |
|---|---|
| Client | CipSoft Tibia **10.76** (`FileVersion 10.7.6.0`) |
| `Tibia.exe` SHA256 | `1b47ab0e…efffcb` |
| ImageBase | `0x400000` (`DYNAMIC_BASE` set, DllCharacteristics `0x8140`) |
| Rebasing | Addresses are absolute VAs at the preferred base. If the image loads elsewhere, add `(module base − 0x400000)` |
| Sources | Public BlackD Proxy 10.76 address list (reposted on OTLand); static check `tools/verify_offsets_1076.py` (ibot_re); live read-only validation via `/proc/<pid>/mem` on a local TFS 1.1 server (`tools/read_1076.py`, `tools/snap_1076.py`) |

Status legend: **L** = live-validated, **S** = static only (imm32 references in `.text`), **P** = public list, not independently confirmed.

## Player globals
| VA | Field | Encoding | Status |
|---|---|---|---|
| `0x9D5034` | player id | u32, equals battle-list id of own creature | L |
| `0x9D5038` / `0x9D503C` / `0x9D5040` | x / y / z | u32 | L |
| `0x9D5000` | HP | `stored ^ [0x8380D0]` | L |
| `0x9D502C` | max HP | XOR | L |
| `0x838100` | mana | XOR | L |
| `0x8380D4` | max mana | XOR | L |
| `0x8380EC` | soul | **plain** (the public list implies XOR; wrong for 10.76) | L |
| `0x8380D8` | experience | plain | L |
| `0x8380E8` | level | plain | L |
| `0x8380D0` | XOR key | random per process | L |
| `0x8380FC` | attack target id ("RedSquare") | u32, 0 = none | L |
| `0x849EEC` | connection state | 11 = in game | L |
| `0x9D5030` / `0x9D5028` / `0x9D5004` | go-to x / y / z | u32 | S |
| `0xA2C0F0` | go-to flag | | S |
| `0x9D7DF0` | attack-click counter | | S |
| `0x9D2424` | selected character index | | S |
| `0x9D2398` | character list pointer | | S |
| `0x848B32` | last packet | | S |

### Player flags (iBot `Player.PlayerFlags`)
Poisoned `0x1`, Burning `0x2`, Energized `0x4`, Drunken `0x8`, ManaShield `0x10`, Paralyzed `0x20`, Hasted `0x40`,
Battle `0x80`, Drowning `0x100`, Freezing `0x200`, Dazzled `0x400`, Cursed `0x800`, Buffed `0x1000`,
PZ-locked `0x2000`, In PZ `0x4000`, Bleeding `0x8000`.

## Other structures
| Struct | Location / layout | Status |
|---|---|---|
| Login server table | `*0x88F5EC`, stride `0x30`; hostname ptr +`0x4`, IP +`0x20`, port +`0x28` | S |
| Chat log | `[[0x8386CC]+0x40]+0x3C`; selected channel `[[[0x8386CC]+0x40]+0x30]+0x30` | P |
| Popup base | `0x8386C8` | S |
| Map / tiles | `MAP_POINTER_ADDR 0xA72128`, `OFFSET_POINTER_ADDR 0xA76C50` | S |
| XTEA session key | `0x82B9C4` (16 bytes) | S |
| Code sites (instruction addresses) | multiclient `0x5585A5`, level-spy NOP `0x517090`, light `0x537072` | P |

## Battle list
Base **`0xA2C0A0`**, stride **`0xDC`** (220 bytes), 1300 slots (index 0–1299). Status: **L** for all fields below.

| Off | Field | Notes |
|---|---|---|
| +0x00 | id | players `0x1…`, monsters `0x4…`, NPCs `0x8…` |
| +0x04 | name | char[32] |
| +0x24 / +0x28 / +0x2C | z / y / x | in that order |
| +0x30 / +0x34 | walk pixel offset | 0 at rest |
| +0x38 | direction | 0 N, 1 E, 2 S, 3 W |
| +0x3C / +0x40 | walk start / end tick | |
| +0x44 / +0x48 | walk animation state | |
| +0x4C | step duration (ms) | |
| +0x54 | last turn direction | mirrors +0x38 |
| +0x5C | sentinel | `0x7FFFFFFF` |
| +0x60 | outfit looktype | |
| +0x64 / +0x68 / +0x6C / +0x70 | head / body / legs / feet colours | |
| +0x74 | addons | |
| +0x78 | mount looktype | |
| +0x7C / +0x80 | light intensity / colour | |
| +0x8C | HP % | 0 on death |
| +0x90 | speed | protocol units |
| +0x94 | unpassable | byte; 1 for normal viewers, 0 for GM viewers |
| +0x98 | skull | 0 none, 1 yellow, 2 green, 3 white, 4 red, 5 black, 6 orange |
| +0x9C | party shield | 0 none, 1 white-yellow, 2 white-blue, 3 blue, 4 yellow, 5 blue+shared, 6 yellow+shared |
| +0xA0 | guild emblem | 0 none, 1 ally, 2 enemy, 3 neutral, 4 member, 5 other |
| +0xA4 | visible / alive | |
| +0xA8 / +0xAC / +0xB0 | mark colour R / G / B | default 357 / 0 / 153 (mark `0xFF`) |
| +0xB4 | marked | byte |
| +0xB8 | helpers | u16 |
| +0xBC | creature type | 0 player, 1 monster, 2 NPC |
| +0xC0 | speech bubble | |
| +0xC8 / +0xD4 | per-creature heap pointers | likely render cache |
| +0xCC | constant 1 | not a protocol field |

Static anchors: creature packet parser `0x4222E0`–`0x422404`, slot initializer `0x48A35C`, mark decoder `0x412B60`,
packet `0x93` handler `0x428C80`.

## Reading example (pseudo-code)
```text
xor   = u32(0x8380D0)
hp    = u32(0x9D5000) ^ xor
self  = u32(0x9D5034)
for i in 0..1299:
    e = 0xA2C0A0 + i*0xDC
    if u32(e) == 0: continue
    id, name, (z,y,x), hp_pct = u32(e), str(e+4,32), u32(e+0x24..0x2C), u32(e+0x8C)
```
