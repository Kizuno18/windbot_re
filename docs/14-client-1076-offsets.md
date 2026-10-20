# Tibia 10.76 client memory map (shared with ibot_re)

Static derivation and verification: [ibot_re/docs/14](https://github.com/Kizuno18/ibot_re/blob/main/docs/14-client-1076-offsets.md). The live-validated layout is mirrored below. Reader: `tools/read_1076.py`.

## Live validation (2026-10-20, local TFS 1.1 + patched 10.76 client under Wine)

**Setup.** Test account/char `Re Tester` (level 8, GM group for the outfit dialog) on local TFS 1.1. The password is stored only locally and is not published.
A spawn was added next to the temple (98,117,7): Rat, Cave Rat, Orc, Troll, NPC Riona; a wild Rabbit was nearby.
Login went through the **patched login hosts + RSA modulus** (MOTD "Welcome to The Forgotten Server!" → character list → in game).
Memory was read **read-only** from the Linux side via `/proc/<pid>/mem` of the Wine `Tibia.exe` process (`tools/read_1076.py`). The image was mapped at `0x400000` (Wine honoured the preferred base).

### Player globals: confirmed
| Addr | Field | Evidence |
|---|---|---|
| `0x9D5034` | player id | `0x10000000` = battle-list slot 0 id |
| `0x9D5038/3C/40` | x/y/z | (95,117,7) temple, then (97,117) → (97,115) after click-walking |
| `0x9D5000` ^ `[0x8380D0]` | HP | 185 (DB 185) |
| `0x9D502C` ^ XOR | max HP | 185 |
| `0x838100` ^ XOR | mana | 90 |
| `0x8380D4` ^ XOR | max mana | 90 |
| `0x8380EC` | **soul (plain, NOT XORed)** | 100. The public list implies XOR; that is wrong for 10.76 |
| `0x8380D8` | experience (plain) | 4200 (DB) — *new* |
| `0x8380E8` | level (plain) | 8 — *new* |
| `0x8380D0` | XOR key | random per process (differed across two sessions) |
| `0x8380FC` | attack target id ("RedSquare") | became `0x40000002` (Troll) after right-click → Attack |
| `0x849EEC` | connection state | 11 = in game |

### Battle-list entry (base `0xA2C0A0`, stride `0xDC`): closed layout
| Off | Field | Evidence |
|---|---|---|
| +0x00 | id | players `0x1…`, monsters `0x4…`, NPCs `0x8…` |
| +0x04 | name char[32] | |
| +0x24 / +0x28 / +0x2C | **z / y / x** (in that order) | matches the player globals for slot 0; monsters at expected spawn tiles |
| +0x30 / +0x34 | walk pixel offset (0 at rest) | |
| +0x38 | **direction** 0=N 1=E 2=S 3=W | 2 at login (south), 1 after walking east, 0 after walking north |
| +0x3C / +0x40 | walk start/end tick | non-zero only on a walking NPC (Riona) |
| +0x44 / +0x48 | walk animation state | 32 while stepping |
| +0x4C | step duration (ms) | 800 (NPC), 100 (GM player) |
| +0x54 | last turn direction (mirrors +0x38) | |
| +0x5C | 0x7FFFFFFF sentinel | constant across all entries |
| +0x60 | outfit looktype | 128 → 129 after changing outfit; Orc 5, Rat 21, Cave Rat 56, Troll 15, Rabbit 74, Riona 138 |
| +0x64/68/6C/70 | head / body / legs / feet | 78/68/58/76 = DB `lookhead/body/legs/feet` |
| +0x74 | addons | 0 → 3 after ticking addons |
| +0x78 | mount looktype | 0 (dismounted) |
| +0x7C / +0x80 | light (color 255 / intensity 0?) | constant in a lit temple. **Unconfirmed** |
| +0x8C | **HP %** | 100 for every entry. Not observed decreasing: the temple is PZ, so damage was impossible. *medium* |
| +0x90 | **speed** (protocol units) | Orc/CaveRat 75, Troll 85, Rabbit 90 = monster XML speed/2; GM 750 |
| +0x94 / +0x98 / +0x9C / +0xA0 | skull / party / war icon / guild-emblem | all 0. Order follows iBot's `Creature` (Speed→Skull→Party→WarIcon). **Not exercised** (needs a second player) |
| +0xA4 | visible | 1 for all on screen |
| +0xA8 / +0xB0 | 357 / 153 (constant) | unknown (UI/square related) |
| +0xBC | **creature type** 0=player 1=monster 2=NPC | exact match |
| +0xC0 | NPC speech/icon flag | 2 only on the NPC |
| +0xC8 / +0xD4 | heap pointers (per-creature, +0x30 apart) | probably name/text render cache |
| +0xCC | 1 (constant) | unknown |

Raw dump (fictional test entities only): `artifacts/battlelist_dump_live.txt`.

### Open items
Skull, party and war icon still need a second player or a working `setSkull` path. `+0xA8`/`+0xB0`/`+0xCC` remain unexplained constants.


## Live validation (round 2 — HP% / light)

With GM talkactions `/hurt` on a targeted Orc (temple PZ; damage applied server-side):

| Observation | Result |
|---|---|
| Orc `+0x8C` | **100 → 43** after `/hurt 50` — **HP% confirmed** |
| Rabbit `+0x8C` | **0** after death — corpse/empty slot still listed briefly |
| Light `+0x7C` / `+0x80` | Color **255** on all; intensity **215** on player (torch / light condition), **0** on monsters — treated as **light color / light intensity** |
| Skull `+0x94` | Remained 0 after `/setskull` (DB `skull=0`); **not confirmed live** |
| Party / war `+0x98`/`+0x9C`/`+0xA0` | Still 0; second client / party invite not completed this session |
| `+0xA8` / `+0xB0` / `+0xCC` | Still constants **357 / 153 / 1** across all entries — **unknown** |

Reader: `tools/read_1076.py`.
