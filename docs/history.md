# WindBot / iBot historical timeline

Sources: Wayback Machine CDX (`web.archive.org/cdx`) and archived pages of `tibiaibot.com` and `tibiawindbot.com`.
Dates marked *capture* are Wayback timestamps (UTC), not necessarily release days. Dates marked *posted* come from the archived page itself.
Community forums (OTLand, TibiaKing) were not checked page-by-page for this revision; items attributed to them below are marked as such.

## iBot (tibiaibot.com)

### Timeline
| Date | Event | Source |
|---|---|---|
| 2012 (early) | New website launched, then **iBot v1.0.0** | homepage news list, capture `20120318220929`… |
| 2012-06-08 → 2012-12-20 | v1.0.3 … **v1.1.7**, roughly every 2–3 weeks (v1.1.3 on 2012-10-25 added Import/Export). Builds distributed via the forum news section | homepage news, *posted* dates, author shown as "Jonatas" |
| 2012-05 | Features page states iBot "is built based on NeoBot"; input simulation (keys/mouse), healer, friend healer, alerts, HUD, cavebot, scripting | `/features/` capture `20120515100802` |
| 2012-06 | Hardware-ID reset form online (`/contact/reset-hardware-id.php`) | capture `20120604223838` |
| 2013 | Homepage captures continue through 2013-07 | CDX root |
| 2014-06 | "iBot Plus" redesign under construction (`/desenvolvimento/`, "ibot is coming" banner) | captures `20140617…` |
| 2014-09 | Support/purchase chat flow referencing Plimus payments | capture `20140915061130` |
| 2015-03 → 06 | Official zips harvested: `iBot v2_3_8` … `v2_7_2` (highest classic build) and iBot Plus `v10_72_0` … `v10_76_1` | `/download/` captures `20150315…`–`20150602…` |
| 2015-08 → 10 | Reseller pages (`/_revenda/cadastro.php`) and ticket validation pages | captures `20150813`, `20151030` |
| 2016 → 2017-10 | Forum still online (vBulletin activity stream), but by late 2017 the visible activity is unrelated trading posts and spam rather than bot releases | `/forum/activity.php` captures to `20171016` |
| 2019-08 | Domain behind Cloudflare error pages | capture `20190829` |
| 2021 → 2026 | Root captures resume, unrelated content under the old domain (2024 captures show generic/parked paths) | CDX root |

### Client versions
v1.x (2012) targeted the 9.x clients of that year; the 2.4.x–2.7.x builds (2014–2015) tracked 10.x; iBot Plus version numbers mirror the client directly (`v10_76_1` = Tibia 10.76).

### Pricing and trial
The 2012 purchase page sold **licence time, not perpetual licences**: packages of **30, 90 and 180 days** added to the forum account, paid via PagSeguro (BRL, Brazil) or Plimus (other currencies). Prices were rendered by the payment widgets and are not present in the archived HTML. Terms: one computer at a time, designated computer changeable **once every 7 days**, multiple instances allowed on that computer. No free trial is advertised on the archived purchase page. The page footer reads "Developed by Chen Pinghui © 2012", while news posts are signed "Jonatas"; both names are recorded as they appear.

### End of support
No end-of-life announcement is archived. The last official binaries in the archive date from mid-2015 (v2.7.2 / Plus 10.76.1, matching Tibia 10.76–10.77). After that the download area stops changing, the forum degrades into unmoderated activity through 2017, and the domain is unreachable by 2019. The practical end of support is therefore **mid-2015**.

## WindBot (tibiawindbot.com)

### Timeline
| Date | Event | Source |
|---|---|---|
| 2013-09 | Domain first captured | capture `20130926193349` |
| **2013-12-07** | **WindBot 1.0.1**, first public release, "after many months of work" | `news.html` *posted*, capture `20140209020927` |
| 2014-01-10 → 01-27 | 1.2.5 … **1.3.3**; 1.3.1 = client protocol **10.33**, 1.3.3 = **10.34**; crash reporter (1.2.6), targeting `setsetting/getsetting` | `change-log.html`, capture `20140209014554` |
| 2014-02 | Site sections: news, features, download, purchase, docs, terms, refund, privacy | captures `20140209…` |
| 2014-07 | Free tools page and promotion codes (`promotion.php?code=…`) | captures `20140701`, `20140706` |
| 2014–2015 | Per-client installers (`windbot10xx-x.y.z.exe`) follow CipSoft 10.x; study copy **2.6.2 = 10.76** | download captures; local provenance |
| 2016–2019 | `download.html` still captured; site behind Cloudflare | captures `2016…`–`20191020` |
| 2019-07 → 2020 | **cloud.tibiawindbot.com** licence portal (`/login`, `/license`) | captures `20190722`, `20200929` |
| 2019 → 2026 | Domain continuously captured (dozens to ~180 captures/year); separate 2.9.x line for the Client 11+ era | CDX year counts; local provenance |

### Team and positioning
The archived About page credits **Lucas Terra** ("one of the main minds behind NeoBot and ElfBot") for the core and **Raphael** for Lua scripts. The product is described as working "by sending mouse clicks and keyboard strokes" with its own overlay; static analysis in this repo also shows an in-process component (see `10-rtti-architecture.md`). The site footer notes that it is not associated with CipSoft and "may be against their TOS/EULA".

### Pricing and trial (purchase page, capture `20140209022337`)
| Plan | Price | Terms |
|---|---|---|
| Free trial | free | 3 days, 1 PC, program closes after 1 hour |
| Monthly | **US$ 6.95** | 30 days, 1 PC, updates, forum support, script download/sell |
| Quarterly | **US$ 18.95** | 90 days, same terms |

Prices were also offered in BRL; a forum registration was required before purchase. Client strings in later builds mention a 3-day trial expiry, a 14-day trial grant via forum thread, and a 7-day HWID rebind limit (`04-protection-auth.md`).

### End of support
WindBot has no archived end-of-support notice; the site and licence portal remain online as of 2026-10. Support for specific classic clients ends when a newer installer replaces it; 10.76 was covered by the 2.6.x line.

## Relationship
- Both products were sold as time-limited licences bound to a forum account and one machine (HWID).
- iBot's own site describes it as NeoBot-based; WindBot's author is credited with NeoBot/ElfBot work. WindBot ships iBot→Wind script converters under `libs/converter/`.
- Both target the classic C++ Tibia 10.x client. iBot is a .NET external bot; WindBot is native Qt with VMProtect and an in-process component.
- Shared client reference: [shared/client-1076-memory-map.md](shared/client-1076-memory-map.md).
