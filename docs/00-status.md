# Status

## Done

- Downloaded WindBot **2.8.30** (latest classic-10 listing) and **2.6.2** (10.76) from tibiawindbot.com; hashed; Inno-extracted.
- PE triage: VMProtect sections `.vmp0`/`.vmp1`, Qt5 import set, ~15.8 MiB main binary (2.8.30).
- Catalogued bundled Lua (`luascripts/`, `hudscripts/`, `libs/`) and `tibiadata` XML names.
- Auth/update/navi hostnames recovered from strings (2.8.30 clearer than VMP-stripped 2.6.2).
- Tibia 10.76 client + TFS 1.1 local server + RSA/IP patch (shared with ibot_re).
- Wine: client main menu OK; WindBot reaches its Authentication dialog.
- [09 Lua API catalog](09-lua-api-catalog.md): 801 documented entries, 785 confirmed in the binary.
- [10 RTTI architecture](10-rtti-architecture.md): 152 classes; evidence of an encrypted manual-mapped hook DLL.
- [11 settings schema](11-settings-schema.md), [12 auth protocol](12-auth-protocol.md).
- Client 10.76 memory map: see sibling [ibot_re/docs/14](https://github.com/Kizuno18/ibot_re/blob/main/docs/14-client-1076-offsets.md) and local [14](14-client-1076-offsets.md).
- [13 REA notes](13-rea-analysis.md).

## Open items / environment limits

- Authentication dialog requires forum credentials; attach/script engines behind it were not exercised live.
- Deep VMProtect unpacking not completed in this pass (static PE + strings + RTTI only).
- Full in-game feature matrix not observed live.

## Next (optional)

- VMP dump/unpack via windows-lab for static analysis of HookManager / encrypted DLL loader.
- IDA/Ghidra FLIRT for Qt.
- Compare WindConverter / iBot script converters in `libs/converter/`.
