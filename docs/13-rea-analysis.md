# REA 6.7.0 notes (WindBot 2.8.30)

These are execution-free runs only. Nothing was unpacked from VMProtect.

| Command | Result |
|---|---|
| `inspect-artifact code$MyConst.exe` | PE root (SHA256 `756403d3…66be3`). Suggested next probe: native `open_binary` |
| `inspect-desktop-application app/` | 92 entries examined; **no managed/Electron/JS runtime candidate**, which fits a native Qt5 + MSVC10 app |
| `inspect-pe-resources` | Only 6 `RT_ICON`, 1 `RT_GROUP_ICON`, 1 `RT_MANIFEST`. UI assets (`:/windbot/...`, `:/buttons/...`) are compiled Qt `qrc` blobs inside `.rdata`, not PE resources |

For contrast, iBot Plus's `ibotplus.exe` fails `inspect-pe-resources` (resource ranges not file-backed, i.e. a packer). WindBot's VMProtect leaves the resource directory intact.
Details of the iBot side: [ibot_re/docs/15](https://github.com/Kizuno18/ibot_re/blob/main/docs/15-rea-analysis.md).
