# Subsystem map: RTTI × strings × Lua API (2.8.30, with 2.6.2 deltas)

Inputs: RTTI/vtables recovered statically from 2.8.30 ([`tools/rtti_vtables.py`](../tools/rtti_vtables.py) → [`artifacts/rtti_vtables_2.8.30.tsv`](../artifacts/rtti_vtables_2.8.30.tsv)), plaintext strings, and the 801 entries of [09-lua-api-catalog](09-lua-api-catalog.md) ([`tools/lua_subsystem_map.py`](../tools/lua_subsystem_map.py) → [`artifacts/lua_api_subsystems.tsv`](../artifacts/lua_api_subsystems.tsv)). 2.6.2 is packed (see [16](16-static-protection-profile.md)), so its side of the comparison uses the shipped Lua/XML trees.

## 1. RTTI inventory (2.8.30)

- 236 type descriptors; 299 complete-object locators; **192 classes with a located vtable** (152 first-party, rest Qt/std).
- QWidget-derived classes have two vtables (`QObject` at +0, `QPaintDevice` at +8): 45 slots for plain `QWidget`, 50 for `QDialog`, 87 for `QTableView` subclasses — consistent with Qt 5.1 (Qt5Core.dll dated 2013-07).
- `.rdata` vtables span `0x77B2B4–0x7A398C`, grouped by translation unit (alphabetical source order is visible: Alerts → Alpha → Cavebot* → … → Waypoints).
- Protected classes (licensing/HWID/injection) are in `.vmp0` — table in [16](16-static-protection-profile.md#code-relocated-into-vmp0-2830).

### Hierarchies visible through the class-hierarchy descriptors

```text
IHookManager ← HookManager
IVirtualAllocationManager ← VirtualAllocationManager<RealAllocationStrategy>
IDllStream ← EncryptedFastDllStream
IUrlBuilderSource ← MyActivationSource
HardwareID::IGetBlock ← HardwareID::GetBlock_CC
QEvent ← WindEvent ← {WindEventOneData..FourData, WindConsoleEvent, WindTrayMessageEvent, AlphaEvent}
AlphaElement ← {AlphaCommandElement, AlphaShapeElement, AlphaTextElement}
AlphaStorage + QWidget  ← WindAlphaWidget        (HUD, raster)
AlphaStorage + QGLWidget ← WindAlphaWidgetGl     (HUD, OpenGL)
WindSqliteDb ← ScriptInfoSqliteDb ← {BotInfoSqliteDb, CharacterInfoSqliteDb, WorldInfoSqliteDb}
QSyntaxHighlighter ← WindHighlighter ← {LuaHighlighter, JSONHighlighter}
QThread ← {WindThread, TibiaInput, Navigation, FileIOThread, WindSqlThread, ScreenshotTaker, ErrorThread}
QDialog ← NaviDialog ← 13 Navi* dialogs (ban/kick/room/pass/nick/file/question)
QStandardItem ← ChatUserItem ← NaviUserItem ; QStandardItem ← NaviRoomItem ← ChatRoomItem
RangeSpinbox ← CavebotRangeSpinBox ; QSpinBox/QComboBox/QCheckBox/… ← Cavebot* input widgets
```

Worker threads (`QThread` subclasses, 12-slot vtables) give the runtime model: `WindThread` (script/engine tick), `TibiaInput` (synthesized input), `Navigation` (Navi TCP client), `WindSqlThread`/`FileIOThread` (persistence), `ScreenshotTaker`, `ErrorThread` (crash upload to `/wind_error.php`).

## 2. Plaintext string surface (2.8.30)

| Group | Strings |
|---|---|
| Hosts / URLs | `auth.tibiawindbot.com` (`POST /wind_error.php`, `activation.php?code=`, `deactivation.php?hash=`), `http://updates.tibiawindbot.com/%1`, `…/versions/%1/updateinfo.xml`, `navi.tibiawindbot.com`, `windbot.net`, `forums.tibiawindbot.com` (`login.php?do=lostpw`, `showthread.php?1236`, `showthread.php?2147-Trial-Requests-Thread`), `www.tibiawindbot.com/{docs,download,purchase}.html` |
| Paths | `/data/windbot.db`, `/data/chars/`, `/data/worlds/`, `/data/custom/`, `/tibiadata/{items,creatures,spells,charinfo}.xml`, `/svgicons.dat`, `/libs/converter/{FriendHealer_ib,Refiller_ib}.lua`, `/converter/windConverter.lua`, `%1/navikeychain-%2.xml`, `\Tibia.dat`, `/admintest.txt`, `Z:/spells.xml` |
| Lua loader | `package.path` `.\?.lua;!\lua\?.lua;!\lua\?\init.lua;`, `package.cpath` `.\?.dll;!\?.dll;!\loadall.dll`; extensions `*.lua` (scripts), `*.luah` (HUD) |
| Settings files | `.xmls` (character: healer/persistent/hotkeys), `.xmlc` (script: cavebot/targeting/HUDs), `.xml` combined; iBot settings import |
| Client gate | `Wrong Tibia Version`, `This version of Tibia isn't supported by this version of WindBot! The bot will exit now.`, `10.00`, `CloseTibia`, `Open Tibia Dat/Pic/Sprite File` |
| Hooking | `external hook`, `gethook`, `sethook`, `%s.dll`, `on_injectButton_released`, `GetMemoryForDLL()` + Nt/Zw section-mapping names (in `.vmp0`) |
| Navi | `Error in Navigation communication system. Packet: `, `Joining Navi Room`, `Logged in room successfully. ID: %1. NaviRoom: %2. Owner: %3`, `Navi User Update: %1 [%2]`, `Navigation - File Browser '%1'` |
| Qt slots | 284 `on_<widget>_<signal>` names (largest prefixes: action 16, delete 12, show 9, looting 8, add 8) |
| Messages | 183 error/warning strings (e.g. `WARNING! Unable to parse spells.xml. Error: %1 %2. Line: %3`) |

Settings keys: see [11-settings-schema](11-settings-schema.md).

## 3. Lua API grouped by subsystem

Assignment is rule-based (catalog section first, then identifier pattern; first match wins in the order below). "In binary" = identifier string present in 2.8.30. "Lua use" = identifier occurrences in shipped `libs/`, `luascripts/`, `hudscripts/` (2.6.2 / 2.8.30).

| Subsystem | Entries | In binary | Native side (RTTI / strings) | Main catalog sections | Most used functions (Lua use 2.6.2/2.8.30) |
|---|---|---|---|---|---|
| Client memory / state (via `HookManager`) | 234 | 234 | `HookManager`, `IVirtualAllocationManager`, `EncryptedFastDllStream`, `TibiaInput`, `MainEventReceiver`, `WindEvent*` | variables/{character,status,skill,bot,timer}, types/creature, functions/client, events/* | `move` 25/27, `gettile` 19/19, `say` 13/16, `npcsay` 11/9, `ischannel` 9/9, `turn` 7/7, `tileclickable` 4/7 |
| Looting / items / containers | 199 | 197 | `Looting{Widget,Model,ProfileWidget,…Delegate}`, `ImportLootListDialog`, `CategoryAndDestinationDialog`, `TibiaItemWidget`, `items.xml` | types/itemdata (94), events/item, types/lootingdata, types/container, variables/equip | `items` 145/150, `itemcount` 117/120, `itemid` 83/91, `moveitems` 44/44, `topitem` 45/35 |
| HUD / widgets | 113 | 113 | `WindAlphaWidget(Gl)`, `Alpha*Element`, `AlphaStorage`, `ScriptsWidget`, `svgicons.dat` | huds/*, widgets/*, types/rectangle | — |
| Healing / supplies / spells | 64 | 63 | `HealerWidget(+Tabs)`, `Supplies{Widget,Model,ProfileWidget}`, `SupplyRuleWidget`, `spells.xml` | types/spellinfo, types/supplydata | `spellinfo` 25/25, `cast` 20/20, `cooldown` 11/11, `getarearunetile` 4/4 |
| Scripting core / DB / util | 58 | 48 | `LuaEditor`, `LuaHighlighter`, `WindbotConsole`, `ScriptEditorWidget`, `LibraryUpdaterWidget`, `WindSqliteDb` family | functions/bot-control, functions/functionality, iterators, functions/string | `time` 107/109, `wait` 73/78, `message` 12/34, `printerror` 29/32, `pausewalking` 23/27 |
| Navigation (Navi) | 44 | 43 | `Navigation` (thread), ~35 `Navi*` classes, `navi.tibiawindbot.com`, `navikeychain-%2.xml` | types/navtarget, types/navchar, types/navping, functions/navigation | `navchar` 2/2, `navping` 2/2, `navsendping` 1/1 |
| Cavebot | 41 | 40 | `CavebotWidget`, `Waypoints{Widget,TableModel,TableView,Delegate}`, `SpecialAreasWidget`, `MapView/MapWidget/MapItem`, `Cavebot*` inputs | functions/cavebot (24), variables/bot | `getsetting` 46/44, `setsetting` 40/36, `reachlocation` 17/17, `tilereachable` 14/14, `gotolabel` 6/6 |
| Targeting | 30 | 29 | `TargetingWidget`, `TargetingProfile{Widget,TableModel,TableView,Delegate}`, `TargetingTableModel`, `EnmityListsWidget` | variables/creature, events/creature | `creature` 128/131, `attack` 22/22, `useoncreature` 10/10, `setattackmode` 6/6, `maround` 5/5 |
| Network / session | 18 | 18 | `LoginDialog`, `MyActivationSource`, `FileUpload`, `ErrorThread`, auth/update hosts; `WS2_32`, `Qt5Network` | events/character (connect/logout/xlog/reconnect), variables/server | `logout` 25/21, `useworldhud` 5/5, `connect` 1/1, `xlog` 1/1 |

Not found as identifiers in 2.8.30 (16): `browsefield`, `DB:getvalue`, `DB:setvalue`, `DB:sectionvalue`, `setdelayedload`, `deadcreature`, `lootingitem`, `navchar`, `newanimatedtext`, `neweffect`, `newmessage`, `newprojectile`, `queuedevent`, `settingsentry`, `supplyitem`, `vipentry` — mostly constructors/iterators provided by Lua-side libs or later builds.

Location: all 785 confirmed identifiers resolve to **`.rdata`** (registration tables). The few `.vmp0` hits are short field names (`.id`, `.x`, `.mp`) matching random bytes. Lua bindings are therefore not virtualized; only licensing, HWID and DLL/hook management are.

### Data flow (static inference)

```text
LoginDialog → MyActivationSource(IUrlBuilderSource) → auth.tibiawindbot.com
           → HardwareID::GetBlock_CC (IPHLPAPI GetBestInterface, VERSION, ADVAPI32)
ClientPicker → HookManager → VirtualAllocationManager<Real> ← EncryptedFastDllStream (IDllStream)
             → Tibia process (external hook / gethook / sethook)
WindThread (Lua VM) ⇄ variables/types/functions ⇄ HookManager state
             → TibiaInput (keyboard/mouse synthesis)
Navigation thread ⇄ navi.tibiawindbot.com (rooms, files, nav* API)
WindSqlThread ⇄ /data/windbot.db (BotInfo/CharacterInfo/WorldInfo)
WindAlphaWidget(Gl) ⇐ huds/* API (overlay)
```

## 4. Differences 2.6.2 → 2.8.30

| Area | 2.6.2 | 2.8.30 |
|---|---|---|
| Protection | packed VMP image | unpacked; VM code in `.vmp0` |
| Build tree | `Z:\WindBot\gui\` | `Z:\WindBot\gui2.0-tibia10\` |
| Qt5 runtime / `svgicons.dat` | identical hashes | identical hashes |
| `tibiadata/` | items/creatures/spells.xml (older) | updated; **adds `blockshots.xml`** (per-item-id `blockshoton` / `blockshotthrough` flags: magic walls, wild growth, …) |
| Raphael lib | 1.4.2 | 1.6.3 (+`closebattlelist`, `getwpt`, `iteminuse`, `pm`, `whisper`, `yell`, `table.reverse`; ~6 000 changed lines) |
| Lucas Terra lib | 16.1 | 16.8 (+`currentcity`, `depotindextoid`, `offlinetrain`, `pvpsafeworld`, `usedskill`, `usetrainer`, `waitcondition`; −`BODYLIST`/`SKINLIST`/`STAKELIST` helpers, `equipitem` wrapper, `skinsample`, `resetbodylists`) |
| Leonardo lib | 1.5.1 | 1.6.2 (+`isinsidespecialarea`) |
| `hudscripts/SSTaker.lua` | — | 14 changed lines |
| Shipped-Lua API use | baseline | new: `openbattlelist`; increased: `message` 12→34, `channel` field 20→32, `tileclickable` 4→7; decreased: `topitem` 45→35, `logout` 25→21 |

The native API set of 2.6.2 cannot be enumerated without unpacking. The bundled Lua libraries of 2.6.2 call only identifiers that are also present in 2.8.30 (no entry is used in 2.6.2 and absent from 2.8.30), so the 2.6.2 surface is a subset of the 2.8.30 one as far as the shipped code exercises it. `.rsrc` holds the same 8 resources in both (6 `RT_ICON`, `IDI_ICON1`, `RT_MANIFEST`) with identical payload hashes; the section bytes differ only through RVA-based data-entry offsets. No `VERSIONINFO` resource is present.
