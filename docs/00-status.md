# Status

## Done

- Downloaded WindBot **2.8.30** (latest classic-10 listing) and **2.6.2** (10.76) from tibiawindbot.com; hashed; Inno-extracted.
- PE triage: VMProtect sections `.vmp0`/`.vmp1`, Qt5 import set, ~15.8 MiB main binary (2.8.30).
- Catalogued bundled Lua (`luascripts/`, `hudscripts/`, `libs/`) and `tibiadata` XML names.
- Auth/update/navi hostnames recovered from strings (2.8.30 clearer than VMP-stripped 2.6.2).
- Tibia 10.76 client + TFS 1.1 local server + RSA/IP patch (shared with ibot_re).
- Wine: client main menu OK; WindBot reaches its Authentication dialog.

## Blocked

- Authentication dialog requires forum credentials; attach/script engines behind it were not exercised live.
- Deep VMProtect unpacking not completed (static PE + strings only).
- Full in-game feature matrix not observed live.

## Next (optional)

- VMP unpack in dedicated RE VM; IDA/Ghidra FLIRT for Qt.
- Compare WindConverter / iBot script converters in `libs/converter/`.
