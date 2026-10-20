# Protection & authentication

## Packer

VMProtect markers: section names `.vmp0` / `.vmp1`, high entropy, collapsed imports.

## Online services (strings from 2.8.30)

| Host / URL | Purpose |
| --- | --- |
| `auth.tibiawindbot.com` | License/login (`Host:` header in binary) |
| `navi.tibiawindbot.com` | Navi / multi-client coordination |
| `updates.tibiawindbot.com` | `versions/%1/updateinfo.xml` |
| `forums.tibiawindbot.com` | Forum auth / docs / trial thread |
| `http://www.tibiawindbot.com/purchase.html` | Purchase |

UI classes: `LoginDialog`, `NaviUserLoginDialog`.

***REMOVED***
Runtime (2.6.2 under Wine): window **`WindBot 2.6.2 - Authentication`**. The session ends at that dialog; attach and scripting engines behind it were documented from static metadata.
