# Authentication & online services (static)

All findings come from plaintext `.rdata` strings in 2.8.30 (file offsets given).

## Login form → request fields (`0x37b2b0`)
Form field keys: `username`, `userpass`, `rememberme`. The UI labels are "Forums user name / Forums password / Remember me", with the window title `WindBot %1 - Authentication`.
`windbot.net` (`0x380b1c`) appears next to the dialog strings and is the likely auth host/SNI. The transport is a custom socket ("Error sending/receiving data!") rather than QNetworkAccessManager.

## Server result codes (UI messages, in table order)
| Message | Meaning |
|---|---|
| Cannot connect to login server! / Error sending / receiving data / Timed out! | transport |
| Authentication failed! | generic |
| Trial of 3 days expired! … | trial expired |
| Invalid username/password combination! | creds |
| Registration expired! | subscription |
| **HardwareId is different, but it has already been changed in the last 7 days!** | HWID binding, 1 change per 7 days |
| Failed to grant a 14 day trial … | trial provisioning |

Combined with the RTTI class `GetBlock_CC@HardwareID`, the licence is **account + HWID bound**, with a server-side 7-day rebind limit.

## Other endpoints
| Endpoint | Use |
|---|---|
| `POST /wind_error.php` @ `auth.tibiawindbot.com` (`0x37ecf8`) | **Crash reporter**, form-urlencoded. Fields: `client, osversion, runtime, ecode, state, wmodule, wmbase, module, mbase, eipdata, stack, comment1..4` + 16-byte hex digest. The upload path uses multipart (`action`, `uploaded`) and expects `**ok**` |
| `http://updates.tibiawindbot.com/versions/%1/updateinfo.xml` | Library updater. It syncs files matching `(libs\|libs/converter\|libs/delayed\|hudscripts\|luascripts\|tibiadata)/.+\.(lua\|xml\|luab)` |
| `navi.tibiawindbot.com` | Navi chat/position server. Room protocol events: logged in / room added / removed / user joined / left / count |

## Startup checks
- Admin-rights probe: writes `/admintest.txt`, otherwise shows "No admin rights".
- Client version gate: `Wrong Tibia Version`.
