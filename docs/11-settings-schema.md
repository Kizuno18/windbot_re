# Settings & waypoint schema

## Files (from UI strings)
| Ext | Content |
|---|---|
| `.xmls` | Character settings: healer, persistent, hotkeys |
| `.xmlc` | Script settings: cavebot, targeting, HUDs ("Cavebot Files (*.xmlc)") |
| `.xml` | Combined "Save/Load both". Import also accepts **iBot settings** (see `libs/converter/*_ib.lua`, `windConverter.luab`) |
| `/data/windbot.db` | SQLite: bot/character/script/world info |
| `tibiadata/*.xml` | items, creatures, spells, projectiles, blockshots, charinfo |
| `Tibia.dat/.spr/.pic` | Read from the client folder for sprites |

## Waypoint types
`Walk`, `Node`, `Stand`, `Rope`, `Ladder`, `Shovel`, `Machete`, `Use`, `Action`, `Lure` (+ the `Lure & Stand / Circle / Keep Away` targeting modes).
Waypoint actions are Lua (`Cavebot/*/Waypoints/%/Action`). Settings are addressed as slash paths, where `*` = profile/list and `%` = row index.

## Setting key tree (137 keys recovered)
```
Alerts/DisableSounds
Cavebot/*/Name
Cavebot/*/Waypoints
Cavebot/*/Waypoints/%
Cavebot/*/Waypoints/%/Action
Cavebot/*/Waypoints/%/Coordinates
Cavebot/*/Waypoints/%/Label
Cavebot/*/Waypoints/%/Range
Cavebot/*/Waypoints/%/Type
Cavebot/AutoMount
Cavebot/AutoRefillAmmo
Cavebot/Enabled
Cavebot/EnergyAvoidance
Cavebot/FireAvoidance
Cavebot/Machete
Cavebot/MapWalkDistance
Cavebot/NodeRange
Cavebot/PauseOnDeath
Cavebot/Pick
Cavebot/PoisonAvoidance
Cavebot/RefillAmmoRange
Cavebot/Rope
Cavebot/Scripts
Cavebot/Scripts/
Cavebot/Shovel
Cavebot/SpecialAreas
Cavebot/SpecialAreas/
Cavebot/SpecialAreas/%/Avoidance
Cavebot/SpecialAreas/%/Comment
Cavebot/SpecialAreas/%/Coordinates
Cavebot/SpecialAreas/%/IgnoreWhenLooting
Cavebot/SpecialAreas/%/IgnoreWhenLuring
Cavebot/SpecialAreas/%/Name
Cavebot/SpecialAreas/%/Policy
Cavebot/SpecialAreas/%/Size
Cavebot/SpecialAreas/%/Type
Cavebot/SpecialAreas/%/WaitTime
Cavebot/WalkThroughPlayers
Cavebot/WalkableIDs
Cavebot/WalkingMethod
Cavebot/Waypoints
Cavebot/Waypoints/
HUDs/Scripts
HUDs/Scripts/
Healer/HealRules/
Healer/Rules/
Hotkeys/Scripts
Hotkeys/Scripts/
Looting/*/LootList
Looting/*/LootList/%/Action
Looting/*/LootList/%/AlertOnDrop
Looting/*/LootList/%/AlertOnMiss
Looting/*/LootList/%/CapAbove
Looting/*/LootList/%/Category
Looting/*/LootList/%/Condition
Looting/*/LootList/%/Destination
Looting/*/LootList/%/HasLessThan
Looting/*/LootList/%/ID
Looting/*/LootList/%/LootingDestination
Looting/*/LootList/%/SellPrice
Looting/*/LootList/%/UseLootingDestination
Looting/*/LootList/%/Weight
Looting/*/Name
Looting/AlertOnValuableBodies
Looting/EatFoodFromCorpse
Looting/Enabled
Looting/LootingPolicy
Looting/LootingRange
Looting/MoveItemsQuickly
Looting/NodeRange
Looting/OnlyOpenValuableBodies
Looting/OpenBPsAtLogin
Looting/OpenNextBP
Looting/OpenUltraValuableImmediately
Looting/UltraValuableBodiesValue
Looting/ValuableBodiesValue
Persistent/Scripts
Persistent/Scripts/
Scripter/CavebotList/
Scripter/DisplayList/
Scripter/HotkeyList/
Scripter/PersistentList/
Settings/ClickWaitTime
Settings/FocusPolicy
Settings/KeyboardMode
Settings/LoadCharacterSettings
Settings/MouseMode
Settings/MouseMoveSpeed
Settings/OpenMenuPolicy
Settings/PressWaitTime
Settings/ScrollMode
Settings/StuckCtrlShiftPolicy
Settings/StuckCursorPolicy
Settings/TypeWaitTime
Supplies/*/Items
Supplies/*/Items/%/BuyPrice
Supplies/*/Items/%/Category
Supplies/*/Items/%/Destination
Supplies/*/Items/%/DownTo
Supplies/*/Items/%/ID
Supplies/*/Items/%/LeaveAt
Supplies/*/Items/%/LootingDestination
Supplies/*/Items/%/Rule
Supplies/*/Items/%/UpTo
Supplies/*/Items/%/UseLootingDestination
Supplies/*/Items/%/Weight
Supplies/*/Name
Supplies/AutoSwitchProfiles
Supplies/ExtraCash
Targeting/*/Creatures
Targeting/*/Creatures/%/Category
Targeting/*/Creatures/%/Count
Targeting/*/Creatures/%/DontLoot
Targeting/*/Creatures/%/EntryName
Targeting/*/Creatures/%/Name
Targeting/*/Creatures/%/PlayAlarm
Targeting/*/Creatures/%/Setting
Targeting/*/Creatures/%/Setting*/
Targeting/*/Creatures/%/SyncSpells
Targeting/*/DangerPriority
Targeting/*/HealthPriority
Targeting/*/LurePriority
Targeting/*/MustBeReachable
Targeting/*/MustBeShootable
Targeting/*/Name
Targeting/*/ProximityPriority
Targeting/*/RandomPriority
Targeting/*/StickPriority
Targeting/*/Vocation
Targeting/AutoSwitchProfiles
Targeting/Creatures
Targeting/Creatures/
Targeting/Creatures/%1%2/Setting%3
Targeting/DiagonalMovement
Targeting/Enabled
Targeting/Monsters/%1/ListSettings/%2
Targeting/NonPvPMode
```
