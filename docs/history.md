# WindBot / iBot historical timeline

# Historical timeline

Sources: Wayback Machine CDX + archived download/purchase pages. Dates are capture timestamps (UTC), not necessarily release days.

## iBot (tibiaibot.com)

| Period | Notes |
|---|---|
| ~2012–2013 | Early public builds (v1.x / v2.0.x) appear on community mirrors for clients 9.6x–9.8x (forum indexes; official zips from this era sparsely archived). |
| 2014 | Active 2.4.x line for Tibia 10.5x (forum threads; official `tibiaibot.com/download/iBot v2_4_*.zip` later mirrored on Wayback in 2015). |
| **2015-03** | Dense Wayback harvest of official zips: **v2.4.7–v2.5.2**, then **v2.6.5–v2.7.2**. Highest classic zip in the archive: **`iBot v2_7_2.zip`** (capture `20150323184551`). |
| **2015-03–06** | **iBot Plus** parallel Qt line: `ibotplus v0_3_0` then `ibotplus v10_71_0` … **`v10_76_1`** (capture `20150323162944`). Version numbers follow the CipSoft client. |
| After mid-2015 | Official site / auth host go dark; no further official zips in CDX. Community mirrors continue briefly, then dry up. |

Author attributed in contemporary posts: Jonatas (ElfBot lineage). Licensing: account + HWID (`ibotlib!getHardwareID`), SOAP login on `tibiaibot.com`.

## WindBot (tibiawindbot.com)

| Period | Notes |
|---|---|
| **2013–2014** | Product launch era. Docs site live by **2014-02** (`docs.html` capture `20140209014523`); community docs later crowdsourced as [rmobis/WindBot-Docs](https://github.com/rmobis/WindBot-Docs). Author: **Lucas Terra** (NeoBot/ElfBot background, site copy). |
| 2014–2015 | Per-client installers (`windbot10xx-x.y.z.exe`) track CipSoft 10.x; download.html snapshots appear regularly on Wayback. |
| 2016–2019 | download.html still captured (`20160328` … `20191020`). Product remains commercially licensed (forum account + trial/purchase pages). |
| **Ongoing (as of 2026-10)** | Site still serves installers: study copies **2.6.2 (10.76)** and **2.8.30 (10.00–47)**; separate **2.9.x** line for Client 11. Auth: `auth.tibiawindbot.com` (forum user/pass, HWID, trial messages for 3/14 days). |

### Pricing (archived purchase page)
Exact EUR/USD figures vary by capture and are often behind dynamic markup; the purchase funnel historically offered a **time-limited trial** (UI strings: 3-day trial expiry, 14-day trial grant via forum thread) and a paid full licence bound to the forum account + HWID (7-day HWID rebind limit in client strings). Treat forum/purchase pages as the authoritative price list for any given date.

## Relationship
- WindBot ships iBot→Wind converters under `libs/converter/`.
- Both target classic C++ Tibia 10.x; iBot is managed/.NET external, WindBot is native Qt + VMProtect with an in-process hook component (RTTI).
