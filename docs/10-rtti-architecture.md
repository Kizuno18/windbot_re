# Architecture from RTTI (WindBot 2.8.30)

VMProtect virtualizes selected functions, but MSVC RTTI type descriptors (`.?AV<name>@@`) in `.rdata` are left in plaintext.
That gives **152 first-party classes** (Qt/std filtered out; full list in `artifacts/rtti_classes_2.8.30.txt`).
The PDB path also survives: `Z:\WindBot\gui2.0-tibia10\Release\windbot.pdb`.

| Subsystem | Classes |
|---|---|
| Client attach / injection | `ClientPicker`, **`HookManager` / `IHookManager`**, **`EncryptedFastDllStream` / `IDllStream`**, **`IVirtualAllocationManager`**, `TibiaInput`, `MainEventReceiver` |
| Licensing | `LoginDialog`, `MyActivationSource`, **`GetBlock_CC@HardwareID` / `IGetBlock@HardwareID`**, `IUrlBuilderSource`, `ErrorThread`, `FileUpload` |
| Overlay (HUD) | `WindAlphaWidget`, `WindAlphaWidgetGl`, `Alpha{Element,ShapeElement,TextElement,CommandElement,Event,Storage}` |
| Cavebot | `WaypointsWidget/TableModel/TableView/Delegate`, `SpecialAreasWidget`, `Cavebot*` input widgets, `MapView/MapWidget/MapItem` |
| Targeting | `TargetingWidget`, `TargetingProfile{Widget,TableModel,TableView,Delegate}`, `TargetingListDelegate` |
| Healer / supplies / looting | `HealerWidget(+Tabs)`, `Supplies*`, `SupplyRuleWidget`, `Looting*`, `ImportLootListDialog`, `CategoryAndDestinationDialog` |
| Scripting | `LuaEditor`, `LuaHighlighter`, `ScriptsWidget(+Tab)`, `ScriptEditorWidget`, `WindbotConsole`, `LibraryUpdaterWidget` |
| Navigation (Navi) | ~35 `Navi*` classes: chat rooms, file browser, ban list, user login, `Navigation` |
| Persistence | `SettingsStorage`, `WindSqliteDb` + `{Bot,Character,Script,World}InfoSqliteDb`, `WindSqlThread` (`/data/windbot.db`, statically linked SQLite) |
| Threads/events | `WindThread`, `FileIOThread`, `WindEvent{One..Four}Data`, `WindConsoleEvent`, `WindTrayMessageEvent` |

## Key finding: in-process component
The marketing ("works by sending mouse clicks and keyboard strokes", from docs.html in 2014) is **incomplete**.
`HookManager` + `EncryptedFastDllStream` + `IVirtualAllocationManager`, together with strings such as `external hook`, `gethook`, `%s.dll`,
`LoadLibraryA/W` and `GetProcAddressA`, point to an **encrypted DLL that is manually mapped (VirtualAllocEx-style) into the Tibia process** to install hooks.
Input itself is still synthesized (`TibiaInput`). Version gating strings: `Wrong Tibia Version`, `This version of Tibia isn't supported by this version of WindBot!`.

This is static inference from RTTI and strings. The Authentication dialog is reached before attach; the injection path was not observed live.
