# Tibia 10.76 client memory map (shared with ibot_re)

> Consolidated reference map: [shared/client-1076-memory-map.md](shared/client-1076-memory-map.md). This page keeps the sources and live validation logs.

Static derivation and verification: [ibot_re/docs/14](https://github.com/Kizuno18/ibot_re/blob/main/docs/14-client-1076-offsets.md). The live-validated layout is mirrored below. Reader: `tools/read_1076.py`.

## Live validation (2026-10-20, local TFS 1.1 + patched 10.76 client under Wine)

**Setup.** Test account/char `Re Tester` (level 8, GM group for the outfit dialog in rounds 1–2) on local TFS 1.1. The password is stored only locally and is not published.
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
| +0x7C / +0x80 | light **intensity / color** (protocol order: level, color) | GM viewer: 255 / 215 (server sends level 0xFF to access accounts); normal viewer: 0 / 0 in the lit temple. Parser stores byte 1 → +0x7C, byte 2 → +0x80 (`0x42231D`) |
| +0x8C | **HP %** | Orc 100 → 43 after 50 damage; Re Tester B 100 → 99 after a 5-damage PvP hit; 0 on death |
| +0x90 | **speed** (protocol units) | Orc/CaveRat 75, Troll 85, Rabbit 90 = monster XML speed/2; GM 750 |
| +0x94 | **unpassable** (byte; last byte of AddCreature) | 1 for every creature seen by a normal player, 0 for every creature seen by a GM (server `canWalkthroughEx`). Parser `0x4223FC`; slot init sets 1 |
| +0x98 | **skull** 0 none, 1 yellow, 2 green, 3 white, 4 red, 5 black, 6 orange | white (3) on the attacker after a PvP hit; green (2) on party members and on guild-war participants; 1/4/5/6 via `Creature:setSkull` |
| +0x9C | **party shield** 0 none, 1 white-yellow, 2 white-blue, 3 blue, 4 yellow, 5 blue+shared exp, 6 yellow+shared exp (7–11 blink/noshared/gray per protocol) | invite: leader self 4, invitee seen by leader 2, leader seen by invitee 1; join: member 3; shared exp on: 4→6 / 3→5, off: back to 4 / 3 |
| +0xA0 | **guild emblem** 0 none, 1 ally, 2 enemy, 3 neutral, 4 member, 5 other | guilds without war: self 4, other guild 5; active `guild_wars` row: self 1, enemy 2. Only sent for unknown creatures (`AddCreature` with `!known`) |
| +0xA4 | visible / alive | 1 for on-screen creatures, 0 after death |
| +0xA8 / +0xAC / +0xB0 | **creature mark color** R / G / B (each 0..255 step 51) | decoded from the mark byte by `0x412B60`: R=(m/36)·51, G=((m/6)%6)·51, B=(m%6)·51. Default mark 0xFF (`MARK_UNMARKED`) gives **357 / 0 / 153**, the constant seen on every entry |
| +0xB4 | **marked** (byte) | 0 when the mark is 0xFF, 1 otherwise (packet 0x93 handler `0x428C80`, permanent mark type) |
| +0xB8 | **helpers** (u16 from AddCreature) | party: leader 2 after invite (leader + invitee), member 2 after join, 0 after leaving; guild only: online guild members (1) |
| +0xBC | **creature type** 0=player 1=monster 2=NPC | exact match |
| +0xC0 | speech bubble | 2 on NPC Riona, 0 on players/monsters |
| +0xC8 / +0xD4 | heap pointers (per-creature, +0x30 apart) | probably name/text render cache |
| +0xCC | 1 (constant, not set by the creature packet parser) | unchanged across party, PvP, skull, guild, war, damage and death. Sits between the heap pointers +0xC8/+0xD4; treated as part of that per-creature render object, not a protocol field |

Raw dump (fictional test entities only): `artifacts/battlelist_dump_live.txt`.


## Live validation (round 2 — HP% / light)

With GM talkactions `/hurt` on a targeted Orc (temple PZ; damage applied server-side):

| Observation | Result |
|---|---|
| Orc `+0x8C` | **100 → 43** after `/hurt 50` — **HP% confirmed** |
| Rabbit `+0x8C` | **0** after death — corpse/empty slot still listed briefly |
| Light `+0x7C` / `+0x80` | 255 / 215 on the player, 255 / 0 on monsters with a GM viewer; closed in round 3 as intensity / color |
| `+0x94` | stayed 0 with GM viewers; closed in round 3 (unpassable flag; skull is +0x98) |
| `+0x98`/`+0x9C`/`+0xA0` | closed in round 3 (skull / party shield / guild emblem) |
| `+0xA8` / `+0xB0` / `+0xCC` | closed in round 3 (mark color R/B; +0xCC non-protocol constant) |

Reader: `tools/read_1076.py`.

## Live validation (round 3: two clients, party, PvP skull, guild war)

**Setup.** Second account `1076test2` with char `Re Tester B` on the same local TFS 1.1 (passwords stored only locally).
Tibia 10.76 allows one client per Wine session (named object, "Error Code 39"), so the second patched client runs in a second
fresh Wine prefix (`/workspace/wine/tibia2`) on its own Xvfb display (`:98`); the first stays on `/workspace/wine/windbot`, `:99`.
`config.lua`: `worldType = "pvp"`, `protectionLevel = 1`. Both chars set to group 1 (normal player) for the PvP/war steps.
Guilds `Alpha Lab` (Re Tester) and `Beta Lab` (Re Tester B) inserted in `guilds`/`guild_membership`; war via a `guild_wars` row with `status=1`.
Lab talkactions: `/pvp <name>` (`doTargetCombatHealth` 5 physical damage, which goes through `Player::onAttackedCreature` and the normal skull logic), `/setskull`, `/tp`.
Both processes were read through `/proc/<pid>/mem` only; `tools/snap_1076.py` records the player entries (+0x8C..+0xD8) of every pid per action and prints the diff.
Full log: `artifacts/battlelist_diffs_party_pvp_war.txt`.

| Action | A's client | B's client |
|---|---|---|
| baseline (both GM) | +0x94=0 on all | +0x94=0 on all |
| A invites B | self: skull 0→2, shield 0→4, helpers 0→2; B: shield 0→2 | A: shield 0→1, helpers 0→2 |
| B joins | B: skull 2, shield 2→3, helpers 2 | A: skull 2, shield 1→4; self: skull 2, shield 3, helpers 2 |
| shared exp on | A 4→6, B 3→5 | same |
| shared exp off | A 6→4, B 5→3 | same |
| A leaves party | skull/shield/helpers → 0 on both entries | same |
| relog as normal players | +0x94=1 on all entries | same |
| guilds, no war | self emblem 4, B emblem 5, helpers 1 | mirror |
| A `/pvp` B (no war) | A skull 0→3 (white); B hp% 100→99 | A skull 0→3; self hp% 100→99 |
| B hits back | A hp% 100→99, no skull on B (self-defence) | same |
| B `/setskull` 1,4,5,6,0 | B skull 1,4,5,6,0 | same |
| guild war active (relog) | self emblem 1, B emblem 2, skull 2 on both | mirror |
| A `/pvp` B during war | B hp% 100→99, no white skull | same |

### Static cross-check (creature packet parser, `0x4222E0`–`0x422404`)
Field writes in protocol order: outfit → +0x60..+0x78, light level → +0x7C, light color → +0x80, speed → +0x90, skull → +0x98,
shield → +0x9C, emblem → +0xA0, type → +0xBC, speech bubble → `0x488BF0` (+0xC0), mark → color struct +0xA8/+0xAC/+0xB0 and flag +0xB4,
helpers (u16) → +0xB8, unpassable → +0x94. The slot initializer at `0x48A35C` writes skull 0, shield 0, mark 0x165/0/0x99, marked 0, emblem 0, unpassable 1, helpers 0.
